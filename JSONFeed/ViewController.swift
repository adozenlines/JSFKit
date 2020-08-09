//
//  ViewController.swift
//  JSONFeed
//
//  Created by Sean Batson on 2020-08-08.
//  Copyright © 2020 Sean Batson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let reader = JSReader(url: URL(string: "https://www.jsonfeed.org/feed.json"))
        reader.read { (jsfeed, error) in
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                guard let title = jsfeed?.title else { return }
                print("\(title)")
            }
        }
        
    }


}

