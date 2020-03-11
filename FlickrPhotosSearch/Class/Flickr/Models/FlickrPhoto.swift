//
//  FlickrPhoto.swift
//  FlickrPhotosSearch
//
//  Created by Mack Liu on 2020/3/8.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

import UIKit

class FlickrPhoto: NSObject, NSSecureCoding {
    
    var name: String?
    var farm_id: Int?
    var server_id: String?
    var image_id: String?
    var secret: String?
    
    override init() {}
    
    required init?(coder: NSCoder) {
        self.name = coder.decodeObject(forKey: "name") as? String
        self.farm_id = coder.decodeObject(forKey: "farm_id") as? Int
        self.server_id = coder.decodeObject(forKey: "server_id") as? String
        self.image_id = coder.decodeObject(forKey: "image_id") as? String
        self.secret = coder.decodeObject(forKey: "secret") as? String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(farm_id, forKey: "farm_id")
        coder.encode(server_id, forKey: "server_id")
        coder.encode(image_id, forKey: "image_id")
        coder.encode(secret, forKey: "secret")
    }
    
    static var supportsSecureCoding: Bool = true
}
