//
//  FavoriteViewController.swift
//  FlickrPhotosSearch
//
//  Created by Mack Liu on 2020/3/10.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    var favoritePhotos = Array<FlickrPhoto>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        photosCollectionView.register(UINib.init(nibName: "PhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotosCollectionViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.title = "我的最愛"
        
        favoritePhotos = FavoritPhotosManager.loadFavoritPhotos()
        photosCollectionView.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritePhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let flickrPhoto = favoritePhotos[indexPath.row]
        let cell: PhotosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        
        cell.favoriteButton.isHidden = true
        cell.assignData(data: flickrPhoto)
        
        return cell
    }
    
    // MARK: UICollectionViewLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = self.view.frame.size.width / 2.0
        let cellHeight = cellWidth + 30.0
        let cellSize = CGSize(width: cellWidth - 15.0, height: cellHeight)
        
        return cellSize;
    }
}
