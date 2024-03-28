//
//  FirstViewController.swift
//  ios-stations
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var books: [Book]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // TableViewにRefreshControlを追加
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        // 書籍一覧を取得
        fetchBooks()
        
    }
    
    @IBAction func click() {
        fetchBooks()
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        fetchBooks()
        // 更新が終わったら、リフレッシュコントロールを終了する
        sender.endRefreshing()
    }
    
    func fetchBooks() {
        let client = BookAPIClient()
        client.fetchBooks(offset: 0) { [weak self] books in
            DispatchQueue.main.async {
                self?.books = books
                debugPrint(books as Any)
                self?.tableView.reloadData()
            }
        }
    }
    
    
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath) as! BookCell
        cell.element = books?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books?.count ?? 0
    }
}

extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = books?[indexPath.row].url
        let secondViewController = SecondViewController(url: url ?? "")
        // SecondViewControllerをモーダルで表示
        present(secondViewController, animated: true, completion: nil)
        
        // ハイライトを消す
        tableView.deselectRow(at: indexPath, animated: true)

    }
}

