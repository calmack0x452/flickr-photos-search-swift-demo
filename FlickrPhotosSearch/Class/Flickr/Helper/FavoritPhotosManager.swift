//
//  FavoritPhotosManager.swift
//  FlickrPhotosSearch
//
//  Created by Mack Liu on 2020/3/10.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

import UIKit

class FavoritPhotosManager: NSObject {
    
    static func isFavoritedPhoto(favoritedPhotos: Array<FlickrPhoto>, imageID: String) -> Bool {
        
        let favoritedSearch = favoritedPhotos.filter { (flickrPhoto) -> Bool in
            return flickrPhoto.image_id == imageID
        }
        
        if favoritedSearch.count > 0 {
            return true
        }
        else {
            return false
        }
    }
    
    static func saveFavoritPhotos(photos: Array<FlickrPhoto>) {
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: photos)
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(encodedData, forKey: "favoritPhotos")
        userDefaults.synchronize()
    }
    
    static func loadFavoritPhotos() -> Array<FlickrPhoto> {
        
        let userDefaults = UserDefaults.standard
        
        if let encodedData = userDefaults.data(forKey: "favoritPhotos") {
            let photos = NSKeyedUnarchiver.unarchiveObject(with: encodedData) as! [FlickrPhoto]
            return photos
        }
        else {
            return Array<FlickrPhoto>()
        }
    }
}
