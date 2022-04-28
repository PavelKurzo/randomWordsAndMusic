//
//  RootView.swift
//  randomWordsAndMusic
//
//  Created by Павел Курзо on 28.04.22.
//

import Foundation
import UIKit

class RootView: UIView {
    let textfield: UITextField = {
        let textfield = UITextField()
        textfield.textAlignment = .left
        textfield.layer.cornerRadius = 6
        textfield.layer.masksToBounds = true
        textfield.layer.borderWidth = 1.2
        textfield.layer.borderColor = UIColor.gray.cgColor
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Type in your number"
        textfield.textAlignment = .center
        return textfield
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.text = nil
        textView.layer.cornerRadius = 10
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.masksToBounds = true
        textView.layer.borderWidth = 1.2
        textView.layer.borderColor = UIColor.gray.cgColor
        return textView
    }()
    
    let wordsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("Fetch words!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let musicButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("Fetch music!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        backgroundColor = .white
        addSubview(textfield)
        addSubview(wordsButton)
        addSubview(musicButton)
        addSubview(textView)
        setConstraints()
    }

    func setConstraints() {
        let constraints = [
            textfield.topAnchor.constraint(equalTo: self.topAnchor, constant: 90),
            textfield.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            textfield.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            textfield.heightAnchor.constraint(equalToConstant: 56),
            wordsButton.topAnchor.constraint(equalTo: textfield.bottomAnchor, constant: 16),
            wordsButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            wordsButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            wordsButton.heightAnchor.constraint(equalToConstant: 56),
            musicButton.topAnchor.constraint(equalTo: wordsButton.bottomAnchor, constant: 8),
            musicButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            musicButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            musicButton.heightAnchor.constraint(equalToConstant: 56),
            textView.topAnchor.constraint(equalTo: musicButton.bottomAnchor, constant: 20),
            textView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            textView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
