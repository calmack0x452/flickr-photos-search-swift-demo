//
//  SearchViewController.swift
//  FlickrPhotosSearch
//
//  Created by Mack Liu on 2020/3/8.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    var photosPage: Int = 0
    var searchPhotos = Array<FlickrPhoto>()
    var favoritePhotos = Array<FlickrPhoto>()
    let searchCondition = SearchCondition.shared
    
    var searchCompletion: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoritePhotos = FavoritPhotosManager.loadFavoritPhotos()
        
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        photosCollectionView.register(UINib.init(nibName: "PhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        
        searchNewPhotos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.title = "搜尋結果 \(searchCondition.keyword ?? "")"
    }
    
    @IBAction func favoritButtonTaped(_ sender: UIButton) {
        let flickrPhoto = searchPhotos[sender.tag]
        
        if !FavoritPhotosManager.isFavoritedPhoto(favoritedPhotos: favoritePhotos, imageID: flickrPhoto.image_id!) {
            favoritePhotos.append(flickrPhoto)
            FavoritPhotosManager.saveFavoritPhotos(photos: favoritePhotos)
            sender.setImage(UIImage.init(named: "favorit.added"), for: .normal)
        }
    }

    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let flickrPhoto = searchPhotos[indexPath.row]
        let cell: PhotosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(favoritButtonTaped(_:)), for: .touchUpInside)
        cell.assignData(data: flickrPhoto)
        
        if FavoritPhotosManager.isFavoritedPhoto(favoritedPhotos: favoritePhotos, imageID: flickrPhoto.image_id!) {
            cell.favoriteButton.setImage(UIImage.init(named: "favorit.added"), for: .normal)
        } else {
            cell.favoriteButton.setImage(UIImage.init(named: "favorit.add"), for: .normal)
        }
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewBottomPosition = scrollView.contentSize.height - scrollView.frame.size.height
        
        if (scrollView.contentOffset.y > scrollViewBottomPosition) {
            searchNewPhotos()
        }
    }
    
    // MARK: UICollectionViewLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = self.view.frame.size.width / 2.0
        let cellHeight = cellWidth + 30.0
        let cellSize = CGSize(width: cellWidth - 15.0, height: cellHeight)
        
        return cellSize;
    }
    
    // MARK: Request Flickr API
    
    func searchNewPhotos() {
        
        if searchCompletion {
            searchCompletion = false
            
            photosPage += 1
            requestPhotosSearch()
        }
    }
    
    func requestPhotosSearch() {
        
        let apiKey = "a8a3e93361034c6da4f2e64ec3b8bab1"
        let originalString = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(searchCondition.keyword!)&per_page=\(searchCondition.perPage!)&page=\(String(photosPage))&format=json&nojsoncallback=1"
        
        if let urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            AF.request(urlString).responseJSON { (response) in
                
                switch response.result {
                case .success:
                    self.parseResponseData(content: response.value)
                    break
                case .failure(_):
                    
                    break
                }
            }
        }
    }
    
    func parseResponseData(content: Any?) {
        if let jsonObject = content as? Dictionary<String, Any?> {
            if jsonObject["stat"] as? String != "ok" {
                return
            }
            
            if let photosObj = jsonObject["photos"] as? Dictionary<String, Any?> {
                if let photoObj = photosObj["photo"] as? Array<Dictionary<String, Any?>> {
                    for photoInfo in photoObj {
                        
                        let flickrPhoto = FlickrPhoto()
                        flickrPhoto.name = photoInfo["title"] as? String
                        flickrPhoto.farm_id = photoInfo["farm"] as? Int
                        flickrPhoto.server_id = photoInfo["server"] as? String
                        flickrPhoto.image_id = photoInfo["id"] as? String
                        flickrPhoto.secret = photoInfo["secret"] as? String
                        
                        searchPhotos.append(flickrPhoto)
                    }
                    
                    
                    self.photosCollectionView.reloadData()
                }
            }
        }
        
        searchCompletion = true
    }
}
