//
//  BookCell.swift
//  ios-stations
//

import UIKit

class BookCell: UITableViewCell {
    
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    var element: Book! {
        didSet {
            title?.text = element.title
            detail?.text = element.detail
        }
    }
}
