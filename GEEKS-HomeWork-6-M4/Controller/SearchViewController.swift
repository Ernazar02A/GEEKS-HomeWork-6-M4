//
//  SearchViewController.swift
//  GEEKS-HomeWork-6-M4
//
//  Created by MacBook Pro on 6/6/23.
//

import UIKit

struct Address {
    var image: String
    var street: String
    var location: String
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var sevadTableVIew: UITableView!
    
    private let addresses: [Address] = [Address(image: "house",
                                                street: "Jukeev-Pudovkin St 43, apt #12",
                                                location: "Home"),
                                        Address(image: "work",
                                                street: "Manas Ave 32, floor 7, office #703",
                                                location: "Work"),
                                        Address(image: "hotel",
                                                street: "Frunze St 50, floor 10, room #1011 ",
                                                location: "Hotel"),
                                        Address(image: "house",
                                                street: "Jukeev-Pudovkin St 43, apt #12",
                                                location: "Home"),
                                        Address(image: "work",
                                                street: "Manas Ave 32, floor 7, office #703",
                                                location: "Work"),
                                        Address(image: "hotel",
                                                street: "Frunze St 50, floor 10, room #1011 ",location: "Hotel")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sevadTableVIew.dataSource = self
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backTapped))
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: false)
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let address = addresses[indexPath.row]
        cell.textLabel?.text = address.location
        cell.detailTextLabel?.text = address.street
        cell.imageView?.image = UIImage(named:address.image)
        return cell
    }
    
    
}
