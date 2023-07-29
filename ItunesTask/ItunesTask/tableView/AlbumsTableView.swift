//
//  AlbumsTableView.swift
//  ItunesTask
//
//  Created by Сергей Сырбу on 19.07.2023.
//

import UIKit

class AlbumsTableView: UITableViewController {

    let searchBar = UISearchController(searchResultsController: nil)
    var albumArray = [Album]()
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        setNavCont()
        setSearchBar()
        
        
    }

    func setNavCont(){
        navigationItem.title = "Album"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "person.fill"), target: self, action: #selector(userTap))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    func setSearchBar(){
        searchBar.searchBar.delegate = self
        searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchBar
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    // метод при помощи которого вводим название альбома и делаем запроса в ITunesAPI
    private func fetchAlbums(albumName: String) {
        let url = "https://itunes.apple.com/search?term=\(albumName)&entity=album&attribute=albumTerm"
        NetworkDataFetch.shared.fetchAlbum(urlString: url) { [weak self] albumModel, error in
            if error == nil { // если ошибки нет
                guard let albumModel = albumModel else {return} // выводим из опционала если ее нет то просто выходим из метода
                
                if albumModel.results != [] {//если не находит альбом, то выходит алерт
                    let sortedAlbums = albumModel.results.sorted { firstItem, secondItem in
                        return firstItem.collectionName.compare(secondItem.collectionName) == ComparisonResult.orderedAscending // берем элемент сравниваем с другим и выставляем по алфавиту
                    }
                    self?.albumArray = sortedAlbums // и присваием массиву результаты из модели
                    self?.tableView.reloadData() // обновляем таблицу
                } else {
                    self?.alertOk(name: "Error", mesaage: "Album is not found")
                }
              
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albumArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {fatalError()}
        let album = albumArray[indexPath.row]
        cell.configure(album: album)
         
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OneAlbumViewController()
        let album = albumArray[indexPath.row] //создаем альбом
        vc.album = album
        vc.title = album.artistName
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func userTap(){
        let vc = ActiveUserViewController()
        navigationController?.pushViewController(vc, animated: true)
    }


}

extension AlbumsTableView: UISearchBarDelegate {
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) // чтобы можно было вводить на русском
        if text != "" { // если searchText не равен пустой строке тогда вызываем метод
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in // вызываем таймер чтобы при вводе буквы каждый раз не создавался запрос
                self.fetchAlbums(albumName: text ?? "nil")
            })
         
        }
    }

 
    
    
}
