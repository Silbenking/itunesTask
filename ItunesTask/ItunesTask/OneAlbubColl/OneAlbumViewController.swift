//
//  OneAlbumViewController.swift
//  ItunesTask
//
//  Created by Сергей Сырбу on 20.07.2023.
//

import UIKit

class OneAlbumViewController: UIViewController {
    
    let albumImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "no")
        return image
    }()
    let nameAlbumLabel: UILabel = {
        let label = UILabel()
        label.text = "name Album"
        return label
    }()
    let reliseLabel: UILabel = {
        let label = UILabel()
        label.text = "relase date"
        return label
    }()
    let nameArtistLabel: UILabel = {
        let label = UILabel()
        label.text = "name Artist"
        return label
    }()
    let countTrackLabel: UILabel = {
        let label = UILabel()
        label.text = "10 tracks"
        return label
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        view.backgroundColor = .white
        return view
    }()
    var album: Album? //создаю альбом чтобы через него передавать новые данные
    var songs = [Song]() //создаем массив куда записываем треки
    override func viewDidLoad() {
        super.viewDidLoad()
        setModel()
        initialize()
        fetchSongs(album: album)
    }
    private func setModel(){
        guard let album = album else {return}// разворачиваем опционал, так как пременна опциональная
        nameAlbumLabel.text = album.collectionName
        nameArtistLabel.text = album.artistName
        reliseLabel.text = stringData(date: album.releaseDate)
        countTrackLabel.text = "\(album.trackCount) traks"
        guard let url = album.artworkUrl100 else {return}
        setImage(urlString: url)
    }
    private func stringData(date: String)->String { // преобразование даты в формат который нам нужен
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        guard let backendDate = dateFormatter.date(from: date) else {return ""}
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd-MM-yyyy"
        let date = formatDate.string(from:  backendDate)
        return date
    }
    private func setImage(urlString: String?){
        if let urlString = urlString{
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
    }
    private func fetchSongs(album: Album?){//получаем треки из коллекцим
        guard let album = album else {return}
        let idAlbum = album.collectionId
        let urlString = "https://itunes.apple.com/lookup?id=\(idAlbum)&entity=song" // подставляем Ид по которому выдаются треки
        NetworkDataFetch.shared.fetchSong(urlString: urlString) { [weak self] songModel, error in
             // обрабатываем ошибку
            if error == nil{// если ошибки нет
                guard let songModel = songModel else {return} // снимаем опционал
                self?.songs = songModel.results //добавлеям резултатты в массив
                self?.collectionView.reloadData()//обновляем коллекцию
            } else{//если есть
                print(error!.localizedDescription)
                self?.alertOk(name: "Error", mesaage: error!.localizedDescription)
            }
        }
    }
    
    func initialize(){
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = .white
        view.addSubview(albumImage)
        albumImage.snp.makeConstraints { make in
            make.size.equalTo(150)
            make.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(100)
        }
        let stackView = UIStackView()
        stackView.addArrangedSubview(nameAlbumLabel)
        stackView.addArrangedSubview(nameArtistLabel)
        stackView.addArrangedSubview(reliseLabel)
        stackView.addArrangedSubview(countTrackLabel)
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.equalTo(albumImage.snp.trailing).offset(10)
        }
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(100)
            make.leading.equalTo(albumImage.snp.trailing).offset(10)
            make.trailing.bottom.equalToSuperview()
        }
    }
}

extension OneAlbumViewController: UICollectionViewDelegate{
    
}
extension OneAlbumViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {fatalError()}
        let song = songs[indexPath.row].trackName
        cell.nameSong.text = song
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width:collectionView.frame.width, height: 20)
    }
}

