//
//  ViewController.swift
//  randomWordsAndMusic
//
//  Created by Павел Курзо on 28.04.22.
//

import UIKit

class RootViewController: UIViewController {
    
    private let repository: RootRepository = RootRepository()
    
    var words = [WordsResult]()
    var musicData = [MusicData]()
    
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
            fetchWords(number)
        } else {
            showWrongNumberAlert()
            rootView.textfield.text = nil
        }
    }
    
    @objc func musicButtonPressed() {
        fetchMusic()
    }
    
    private func fetchWords(_ count: Int) {
        repository.fetchWords(count) { result in
            switch result {
            case .success(let data):
                self.wordsFetched(words: data)
            case .failure:
                break
            }
        }
    }
    
    private func wordsFetched(words: [WordsResult]) {
        self.words = words
        self.putWordsInTextView()
        self.rootView.musicButton.isHidden = false
    }
    
    private func putWordsInTextView() {
        let attributedString = NSMutableAttributedString()
        
        words.forEach {
            let wordAttributedString = NSMutableAttributedString()
            wordAttributedString.append(buildTitleAndSubtitle(title: "Word: ", subtitle: $0.word))
            wordAttributedString.append(buildTitleAndSubtitle(title: "\nDefinition: ", subtitle: $0.definition))
            wordAttributedString.append(buildTitleAndSubtitle(title: "\nPronunciation: ", subtitle: $0.pronunciation + "\n\n"))
            attributedString.append(wordAttributedString)
            
        }
        rootView.textView.attributedText = attributedString
    }
    
    func buildTitleAndSubtitle(title: String, subtitle: String) -> NSAttributedString {
        let titleAttributes: [NSAttributedString.Key : Any] = [.foregroundColor : UIColor.black, .font : UIFont.systemFont(ofSize: 16, weight: .bold)]
        let subtitleAttributes: [NSAttributedString.Key : Any] = [.foregroundColor : UIColor.black, .font : UIFont.systemFont(ofSize: 16, weight: .regular)]
        let result = NSMutableAttributedString()
        result.append(NSAttributedString(string: title, attributes: titleAttributes))
        result.append(NSAttributedString(string: subtitle, attributes: subtitleAttributes))
        return result
    }
    
    private func fetchMusic() {
        repository.fetchMusic(for: words) { result in
            switch result {
            case .success(let data):
                self.musicFetched(data)
            case .failure:
                break
            }
        }
    }
    
    private func musicFetched(_ music: [MusicData]) {
        self.musicData = music
        self.putMusicInTextView()
    }
    
    private func putMusicInTextView() {
        let attributedString = NSMutableAttributedString()
        
        musicData.forEach {
            let wordAttributedString = NSMutableAttributedString()
            wordAttributedString.append(buildTitleAndSubtitle(title: "Word: ", subtitle: $0.word.word))
            wordAttributedString.append(buildTitleAndSubtitle(title: "\nDefinition: ", subtitle: $0.word.definition))
            wordAttributedString.append(buildTitleAndSubtitle(title: "\nPronunciation: ", subtitle: $0.word.pronunciation))
            wordAttributedString.append(buildTitleAndSubtitle(title: "\nMusic Info: ", subtitle: "\($0.description) \n\n"))
            attributedString.append(wordAttributedString)
        }
        rootView.textView.attributedText = attributedString
    }
}

