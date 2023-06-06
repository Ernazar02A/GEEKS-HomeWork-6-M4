//
//  DetailViewController.swift
//  GEEKS-HomeWork-6-M4
//
//  Created by MacBook Pro on 6/6/23.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let product = product else {return}
        categoryLabel.text = product.category
        titleLabel.text = product.title
        brandLabel.text = product.brand
        detailLabel.text = product.description
        image.kf.setImage(with: URL(string: product.thumbnail ?? ""))
    }

}
