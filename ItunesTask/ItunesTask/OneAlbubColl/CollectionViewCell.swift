//
//  CollectionViewCell.swift
//  ItunesTask
//
//  Created by Сергей Сырбу on 20.07.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let nameSong: UILabel = {
        let label = UILabel()
        label.text = "name song"
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initialize(){
        contentView.backgroundColor = .white
        contentView.addSubview(nameSong)
        nameSong.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}

