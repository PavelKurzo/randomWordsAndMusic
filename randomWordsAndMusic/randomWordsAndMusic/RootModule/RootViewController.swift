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
        rootView.wordsButton.addTarget(self, action: #selector(wordsButtonPressed), for: .primaryActionTriggered)
        rootView.musicButton.addTarget(self, action: #selector(musicButtonPressed), for: .primaryActionTriggered)
    }
    
    public func showWrongNumberAlert() {
        let alert = UIAlertController(title: "Incorrect input",
                                      message: "Type in number from 5 to 20",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc func wordsButtonPressed() {
        if let text = rootView.textfield.text, let number = Int(text), number > 4, number < 21 {
            rootView.textfield.text = nil
        } else {
            showWrongNumberAlert()
            rootView.textfield.text = nil
        }
    }
    
    @objc func musicButtonPressed() {
    }
    
}

