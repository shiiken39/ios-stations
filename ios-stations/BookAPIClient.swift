//
//  BookAPIClient.swift
//  ios-stations
//

import Alamofire
import Foundation

protocol BookAPIClientProtocol {
    func fetchBooks(offset: Int, completion: @escaping ([Book]?) -> Void)
}

class BookAPIClient: BookAPIClientProtocol {
    func fetchBooks(offset: Int, completion: @escaping ([Book]?) -> Void) {
        let url = "https://railway.bookreview.techtrain.dev/public/books" // 実際のAPIエンドポイントURLに置き換えてください。
        let parameters: Parameters = ["offset": offset]
        
        AF.request(url, method: .get, parameters: parameters).responseDecodable(of: [Book].self) { response in
            switch response.result {
            case .success(let books):
                completion(books)
            case .failure(_):
                completion(nil)
            }
        }
    }
}
