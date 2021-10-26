//
//  EditViewController.swift
//  BirthdayIphoneApp
//
//  Created by 宮崎　幹太郎 on 2021/10/25.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gaveText: UITextView!
    @IBOutlet weak var giveText: UITextView!
    var birthday: BirthdayPerson!
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        nameLabel.text = String(birthday.month)  + "/" + String(birthday.day) + " " + birthday.name
        gaveText.text = birthday.gaveText
        giveText.text = birthday.giveText
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        try! realm.write{
            self.birthday.gaveText = self.gaveText.text!
            self.birthday.giveText = self.giveText.text!
            self.realm.add(self.birthday, update: .modified)
        }
        super.viewWillDisappear(animated)
    }

}
