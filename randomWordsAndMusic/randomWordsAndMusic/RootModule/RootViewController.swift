//
//  ViewController.swift
//  randomWordsAndMusic
//
//  Created by Павел Курзо on 28.04.22.
//

import UIKit

class RootViewController: UIViewController {
    
    private var rootView: RootView {
        return self.view as! RootView
    }
    
    override func loadView() {
        self.view = RootView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

