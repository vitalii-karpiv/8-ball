//
//  ViewController.swift
//  8-Ball
//
//  Created by newbie on 22.01.2022.
//

import UIKit

class ViewController: UIViewController, AnswerUpdater {
    
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
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            // TODO change UI
        }
    }
    
    func updateAnswer(with answer: String) {
        //todo update ui with answer
    }
}

