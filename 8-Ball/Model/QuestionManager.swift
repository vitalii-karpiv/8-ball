//
//  QuestionManager.swift
//  8-Ball
//
//  Created by newbie on 23.01.2022.
//

import Foundation
import Firebase

protocol AnswerUpdater {
    func updateAnswer(with answer: String)
}

struct QuestionManager {
    var delegate: AnswerUpdater?
    var db = Firestore.firestore()
    var hardcodedAnswers = ["Yes", "No", "Definitely"]
    let url = "https://8ball.delegator.com/magic/JSON/8ball"
    var requestUrl: URL? {
        URL(string: self.url)
    }
    
    
    func getResponse() {
        if requestUrl != nil {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: requestUrl!) { data, response, error in
                if let _ = error {
                    db.collection(Constants.answerCollection).getDocuments() { (querySnapshot, err) in
                        if let _ = err {
                            delegate?.updateAnswer(with: hardcodedAnswers[Int.random(in: 0...2)])
                        } else {
                            for document in querySnapshot!.documents {
                                if let saveAnswer = document.data()["answer"] {
                                    delegate?.updateAnswer(with: saveAnswer as! String)
                                }
                            }
                            delegate?.updateAnswer(with: hardcodedAnswers[Int.random(in: 0...2)])
                        }
                    }
                } else {
                    if let saveData = data {
                        delegate?.updateAnswer(with: self.parseJson(saveData))
                    }
                }
            }
            
            task.resume();
        }
    }
    
    func parseJson(_ data: Data) -> String {
        let decoder = JSONDecoder()
        do {
            let answer = try decoder.decode(Answer.self, from: data)
            return answer.magic.answer
        } catch {
            return hardcodedAnswers[Int.random(in: 0...2)]
        }
    }
}
