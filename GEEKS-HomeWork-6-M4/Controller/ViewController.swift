//
//  ViewController.swift
//  GEEKS-HomeWork-6-M4
//
//  Created by MacBook Pro on 1/6/23.
//

import UIKit



class ViewController: UIViewController {
    
    var food: [Food] = [Food(image: "momosFoodImage", name: "Tony Roma’s", text: "Ribs & Steaks", detail: "Delivery: FREE • Minimum: $20")]
    
    var sections: [SectionModel] = [SectionModel(image: "delivery", name: "Delivery", selected: true),
                                    SectionModel(image: "takeaway", name: "Takeaway", selected: false),
                                    SectionModel(image: "catering", name: "Catering", selected: false),
                                    SectionModel(image: "curbside", name: "Curbside", selected: false),
                                    SectionModel(image: "offers", name: "Offers", selected: false)]

    @IBOutlet weak var foodCollectionView: UICollectionView!
    
    @IBOutlet weak var sectionCollectionView: UICollectionView!
    
    let foodCollectionViewIdentifier = "foodCollectionView"
    let sectionCollectionViewBIdentifier = "sectionCollectionView"
    //    private let foodCol: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 160, height: 236)
//        layout.minimumInteritemSpacing = 10
//        layout.minimumLineSpacing = 10
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
//        layout.scrollDirection = .horizontal
//        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        view.showsHorizontalScrollIndicator = false
//        return view
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateFoodCollections()
        updateSectionCollections()
    }
    
    private func updateSectionCollections() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 47)
        layout.minimumInteritemSpacing = 15
        //layout.sectionInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
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
       5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.foodCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: foodCollectionViewIdentifier, for: indexPath) as! FoodCollectionViewCell
            
            cell.updateData(food: food[0])
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
