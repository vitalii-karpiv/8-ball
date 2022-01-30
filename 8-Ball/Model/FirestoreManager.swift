//
//  FirestoreManager.swift
//  8-Ball
//
//  Created by Віталій Карпів on 29.01.2022.
//

import Foundation
import Firebase

struct FirestoreManager{
    var db = Firestore.firestore()
    
    func saveAnswerIntoFirestore(_ textField: UITextField) {
        if let saveData = textField.text {
            db.collection(Constants.answerCollection).addDocument(data: [
                "answer": saveData
            ]) { err in
                if let _ = err {
                    textField.text = ""
                    textField.placeholder = "Something went wrong"
                    textField.backgroundColor = UIColor.red
                } else {
                    textField.text = ""
                }
            }
        } else {
            textField.placeholder = "Type something"
        }
    }
}
