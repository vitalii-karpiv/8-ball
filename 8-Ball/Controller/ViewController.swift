//
//  ViewController.swift
//  8-Ball
//
//  Created by newbie on 22.01.2022.
//

import UIKit

class ViewController: UIViewController, AnswerUpdater {
    @IBOutlet weak var answerLabel: UILabel!
    
    var questionManager = QuestionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        self.questionManager.delegate = self
    }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            questionManager.getResponse()
        }
    }
    
    func updateAnswer(with answer: String) {
        DispatchQueue.main.async {
            self.answerLabel.text = answer
        }
    }
}

