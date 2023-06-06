//
//  ViewController.swift
//  GEEKS-HomeWork-6-M4
//
//  Created by MacBook Pro on 1/6/23.
//

import UIKit



class ViewController: UIViewController {
    


    @IBOutlet weak var foodCollectionView: UICollectionView!
    
    @IBOutlet weak var sectionCollectionView: UICollectionView!
    
    private var data: [Product] = []
    
    var sections: [SectionModel] = [SectionModel(image: "delivery", name: "Delivery", selected: true),
                                    SectionModel(image: "takeaway", name: "Takeaway", selected: false),
                                    SectionModel(image: "catering", name: "Catering", selected: false),
                                    SectionModel(image: "curbside", name: "Curbside", selected: false),
                                    SectionModel(image: "offers", name: "Offers", selected: false)]
    
    let foodCollectionViewIdentifier = "foodCollectionView"
    let sectionCollectionViewBIdentifier = "sectionCollectionView"

    override func viewDidLoad() {
        super.viewDidLoad()
        updateFoodCollections()
        updateSectionCollections()
        addBarButton()
        networking()
    }
    
    private func addBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barButton))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    @objc func barButton() {
        
        let alertController = UIAlertController(title: "Добавить новый продукт", message: "Заполните все поля!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Добавить", style: .default) { action in
            guard let id = alertController.textFields?.first?.text,let title = alertController.textFields?[1].text else{return}
            ApiManager.shared.dataManager(requestType: .post(id: Int(id)!, title: title)) { result in
                switch result {
                case .success(.value(let statusCode)):
                    DispatchQueue.main.async {
                        self.showAlert(title: "Status code", message: "Your status code is: \(statusCode)")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                default:
                    break
                }
            }
        }
        let action2 = UIAlertAction(title: "Назад", style: .cancel)
        
        alertController.addAction(action)
        alertController.addAction(action2)
        alertController.addTextField { tf in
            tf.placeholder = "ID"
        }
        alertController.addTextField { tf in
            tf.placeholder = "Name"
        }
        self.present(alertController, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    private func networking() {
        ApiManager.shared.dataManager(requestType: .get) { result in
            switch result {
            case .success(.model(let data)):
                DispatchQueue.main.async {
                    self.data = data.products
                    self.foodCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            default:
                break
            }
        }
    }
    
    private func updateSectionCollections() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 47)
        layout.minimumInteritemSpacing = 15
        layout.scrollDirection = .horizontal
        sectionCollectionView.collectionViewLayout = layout
        sectionCollectionView.backgroundColor = .clear
        sectionCollectionView.frame = .zero
        sectionCollectionView.showsHorizontalScrollIndicator = false
        sectionCollectionView.dataSource = self
        sectionCollectionView.delegate = self
        sectionCollectionView.register(SectionCollectionViewCell.self, forCellWithReuseIdentifier: sectionCollectionViewBIdentifier)
    }
    
    private func updateFoodCollections() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 160, height: 236)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 21
        layout.sectionInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
        layout.scrollDirection = .horizontal
        foodCollectionView.collectionViewLayout = layout
        foodCollectionView.backgroundColor = .clear
        foodCollectionView.showsHorizontalScrollIndicator = false
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
        foodCollectionView.register(FoodCollectionViewCell.self, forCellWithReuseIdentifier: foodCollectionViewIdentifier)
    }
    
    
    @IBAction func busketButtonTapped(_ sender: UIBarButtonItem) {
        print("tapped")
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.foodCollectionView {
            return data.count
        } else {
            return sections.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.foodCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: foodCollectionViewIdentifier, for: indexPath) as! FoodCollectionViewCell
            
            cell.updateData(food: data[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sectionCollectionViewBIdentifier, for: indexPath) as! SectionCollectionViewCell
            cell.getData(section: sections[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.sectionCollectionView {
            for (i,_) in sections.enumerated() {
                sections[i].selected = false
            }
            print(sections[indexPath.row].name)
            sections[indexPath.row].selected = true
            collectionView.reloadData()
        } else {
            let vc = navigationController?.storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
            vc.product = data[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.sectionCollectionView {
        if sections[indexPath.row].selected {
            return CGSize(width: 100, height: 50)
        } else {
            return CGSize(width: 50, height: 47)
            }
        } else {
            return CGSize(width: 160, height: 236)
        }
    }
}
