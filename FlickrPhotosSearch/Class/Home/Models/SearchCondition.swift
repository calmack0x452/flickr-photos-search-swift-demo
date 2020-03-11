//
//  SearchCondition.swift
//  FlickrPhotosSearch
//
//  Created by Mack Liu on 2020/3/8.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

import UIKit

/*struct SearchCondition {
    
    // MARK: Property with Singleton
    static var shared = SearchCondition()
    
    // MARK: Propertis
    var keyword: String?
    var perPage: String?
    
    // Disable self-created instances
    private init() {}
}*/

class SearchCondition: NSObject {
    
    // MARK: Property with Singleton
    static let shared = SearchCondition()
    
    // MARK: Propertis
    var keyword: String?
    var perPage: String?
    
    // Disable self-created instances
    private override init() {}
}
