//
//  ViewController.swift
//  BirthdayIphoneApp
//
//  Created by 宮崎　幹太郎 on 2021/10/25.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    
    var dataArray = try! Realm().objects(BirthdayPerson.self).sorted(byKeyPath: "month", ascending:true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    // データの数（＝セルの数）を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    // 各セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let birthday = dataArray[indexPath.row]
        cell.textLabel?.text = String(birthday.month)  + "/" + String(birthday.day) + " " + birthday.name

        return cell
    }

    // 各セルを選択した時に実行されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "cellSegue",sender: nil) 
        }


    // セルが削除が可能なことを伝えるメソッド
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)-> UITableViewCell.EditingStyle {
        return .delete
    }

    // Delete ボタンが押された時に呼ばれるメソッド
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write {
                self.realm.delete(self.dataArray[indexPath.row])
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "cellSegue" {
            let editViewController:EditViewController = segue.destination as! EditViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            editViewController.birthday = dataArray[indexPath!.row]
        }else {
            let inputViewController:InputViewController = segue.destination as! InputViewController
            let birthday = BirthdayPerson()
            
            let allBirthday = realm.objects(BirthdayPerson.self)
            if allBirthday.count != 0 {
                birthday.id = allBirthday.max(ofProperty: "id")! + 1
               
            inputViewController.birthday = birthday
            }else{
                birthday.id = 1
                inputViewController.birthday = birthday
            }
            
        }
        
    }
    // 入力画面から戻ってきた時にViewを更新
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

