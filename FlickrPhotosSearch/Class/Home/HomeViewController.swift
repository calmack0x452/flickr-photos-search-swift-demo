//
//  HomeViewController.swift
//  FlickrPhotosSearch
//
//  Created by Mack Liu on 2020/3/8.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var keywordTextField: UITextField!
    @IBOutlet weak var perPageTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disableSearchButton(disable: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange(notification:)), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: NotificationCenter Methods
    
    @objc func textFieldDidChange(notification: Notification) {
        
        if (keywordTextField.text!.count > 0 &&
            perPageTextField.text!.count > 0) {
            disableSearchButton(disable: false)
        }
        else {
            disableSearchButton(disable: true)
        }
    }
    
    // MARK: Buttin Events
    func disableSearchButton(disable: Bool) {
        
        if (disable) {
            searchButton.isUserInteractionEnabled = false
            searchButton.backgroundColor = UIColor.lightGray
        }
        else {
            searchButton.isUserInteractionEnabled = true
            searchButton.backgroundColor = UIColor.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    @IBAction func searchButtonTaped(_ sender: UIButton) {

        let searchCondition = SearchCondition.shared
        searchCondition.keyword = keywordTextField.text
        searchCondition.perPage = perPageTextField.text
        
        self.performSegue(withIdentifier: "tabBarConnector", sender: nil)
    }
}
