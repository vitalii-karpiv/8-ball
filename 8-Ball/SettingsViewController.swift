//
//  SettingsViewController.swift
//  8-Ball
//
//  Created by newbie on 23.01.2022.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    @IBOutlet weak var textFieldOutlet: UITextField!
    @IBOutlet weak var tableViewOutlet: UITableView!
    var db = Firestore.firestore()
    let idCell = "idCell"
    var firestoreManager = FirestoreManager()
    var answerList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldOutlet.delegate = self
        tableViewOutlet.dataSource = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
        loadAnswers()
    }
    
    func loadAnswers() {
        answerList = []
        db.collection("answers").getDocuments() { (querySnapshot, err) in
            if let _ = err {
                print("Error getting documents")
            } else {
                for document in querySnapshot!.documents {
                    if let saveAnswer = document.data()["answer"] {
                        self.answerList.append(saveAnswer as! String)
                        DispatchQueue.main.async {
                            self.tableViewOutlet.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func goBackPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        firestoreManager.saveAnswerIntoFirestore(textField)
        loadAnswers()
        self.tableViewOutlet.reloadData()
        return true
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answerList.count-1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .default, reuseIdentifier: idCell)
        cell.textLabel?.text = answerList[indexPath.row]
        return cell
    }
}
