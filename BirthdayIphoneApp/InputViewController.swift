//
//  InputViewController.swift
//  BirthdayIphoneApp
//
//  Created by 宮崎　幹太郎 on 2021/10/25.
//

import UIKit
import RealmSwift

class InputViewController: UIViewController {

    @IBOutlet weak var monthText: UITextField!
    @IBOutlet weak var dayText: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var gaveText: UITextView!
    @IBOutlet weak var giveText: UITextView!
    
    let realm = try! Realm()
    var birthday: BirthdayPerson!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        try! realm.write{
            self.birthday.month = Int(self.monthText.text!)!
            self.birthday.day = Int(self.dayText.text!)!
            self.birthday.name = self.nameTextField.text!
            self.birthday.gaveText = self.gaveText.text!
            self.birthday.giveText = self.giveText.text!
            self.realm.add(self.birthday, update: .modified)
        }
        super.viewWillDisappear(animated)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
