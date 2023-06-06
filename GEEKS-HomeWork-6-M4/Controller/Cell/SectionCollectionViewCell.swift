//
//  SectionCollectionViewCell.swift
//  GEEKS-HomeWork-6-M4
//
//  Created by MacBook Pro on 6/6/23.
//

import UIKit

class SectionCollectionViewCell: UICollectionViewCell {
    
    private let bgViewBig: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let bgViewSmoll: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15

        return view
    }()
    
    private let image: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    private let label: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Poppins-Medium", size: 10)
        view.textColor = .white
        
        return view
    }()
    
    var i = 0
    
    var section: SectionModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func getData(section: SectionModel) -> Void{
        
        if section.selected {
            contentView.addSubview(bgViewBig)
            bgViewBig.addSubview(image)
            bgViewBig.addSubview(label)
            label.text = section.name
            image.image = UIImage(named: section.image + "White")
            selectedCell()
            return ()
        } else {
            contentView.addSubview(bgViewSmoll)
            bgViewSmoll.addSubview(image)
            image.image = UIImage(named: section.image + "Black")
            unSelectedCell()
            return ()
        }
    }
    
    private func selectedCell() {
        bgViewBig.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalTo(image.snp.trailing).offset(3)
        }
        image.snp.makeConstraints { make in
            make.height.width.equalTo(25)
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    private func unSelectedCell() {
        bgViewSmoll.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        image.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
