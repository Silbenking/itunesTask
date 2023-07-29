//
//  TableViewCell.swift
//  ItunesTask
//
//  Created by Сергей Сырбу on 19.07.2023.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    let albumImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    let nameAlbumLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    let nameArtistLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    let countTrackLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(album:Album){
        
        if let urlString = album.artworkUrl100{
            NetworkRequest.shared.requestData(urlString: urlString) { result in
                switch result {
                    
                case .success(let data)://если можем перейти по ссылке то получаем картинку если ошибка то устанавливаем значение в нил
                    self.albumImage.image = UIImage(data: data)
                case .failure(let error):
                    self.albumImage.image = nil
                    print(error)
                }
            }
        } else {
            albumImage.image = nil
        }
        
        
        nameAlbumLabel.text = album.collectionName
        nameArtistLabel.text = album.artistName
        countTrackLabel.text = "\(album.trackCount) tracks"
    }
    func initialize(){
        contentView.addSubview(albumImage)
        albumImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(5)
            make.size.equalTo(50)
        }
        contentView.addSubview(nameAlbumLabel)
        nameAlbumLabel.snp.makeConstraints { make in
            make.leading.equalTo(albumImage.snp.trailing).offset(20)
            make.top.equalToSuperview().inset(5)
        }
        contentView.addSubview(nameArtistLabel)
        nameArtistLabel.snp.makeConstraints { make in
            make.leading.equalTo(albumImage.snp.trailing).offset(20)
            make.bottom.equalToSuperview().inset(5)
        }
        contentView.addSubview(countTrackLabel)
        countTrackLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(5)
        }
    }
}
