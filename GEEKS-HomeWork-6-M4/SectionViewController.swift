//
//  SectionViewController.swift
//  GEEKS-HomeWork-6-M4
//
//  Created by MacBook Pro on 5/6/23.
//

import UIKit



class SectionViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!

    
    var sections: [SectionModel] = [SectionModel(image: "delivery", name: "Delivery", selected: true),
                                    SectionModel(image: "takeaway", name: "Takeaway", selected: false),
                                    SectionModel(image: "catering", name: "Catering", selected: false),
                                    SectionModel(image: "curbside", name: "Curbside", selected: false),
                                    SectionModel(image: "offers", name: "Offers", selected: false)]
    
    private let foodCol: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 47)
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(foodCol)
        
        foodCol.dataSource = self
        foodCol.delegate = self
        
        foodCol.register(SectionCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        foodCol.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
    }
}


extension SectionViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SectionCollectionViewCell
        cell.getData(section: sections[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for (i,_) in sections.enumerated() {
            sections[i].selected = false
        }
        print(sections[indexPath.row].name)
        sections[indexPath.row].selected = true
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if sections[indexPath.row].selected {
            return CGSize(width: 100, height: 50)
        } else {
            return CGSize(width: 50, height: 47)
        }
    }
}
