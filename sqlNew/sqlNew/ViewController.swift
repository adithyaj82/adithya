//
//  ViewController.swift
//  sqlNew
//
//  Created by varun.polanki on 3/27/18.
//  Copyright © 2018 varun.polanki. All rights reserved.
//

import UIKit
import SQLite
class ViewController: UIViewController {
    var con:Connection?
    var path = String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.path = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask , true).first!
        print(self.path)
        do{
        self.con = try Connection("\(self.path)/db.sqlite3")
            try con?.run("CREATE TABLE IF NOT EXISTS CONTACTS(ID INTEGER PRIMARY KEY,NAME TEXT,ADDRESS TEXT, PHONE TEXT)")
        }
        catch{
                print(error)
        }
    }
    
    @IBOutlet weak var TXT1: UITextField!
    
    @IBOutlet weak var TXT2: UITextField!
    

    @IBAction func submit(_ sender: Any) {
        
        do{
            try con?.run("INSERT INTO CONTACTS(NAME,ADDRESS)VALUES(?,?)",self.TXT1.text,self.TXT2.text)
        }
        catch{
            print(error)
        }
    }
    @IBAction func btn2(_ sender: Any) {
        
        
        do{
            let w = try! con?.run("SELECT NAME,ADDRESS FROM CONTACTS")
            for row in w! {
                for (a,b) in (w?.columnNames.enumerated())!{
                   print(row[a]!)
                   
                }
            }
        }
    }
    @IBAction func delet(_ sender: Any) {
        do{
            let table = try con?.run("DELETE FROM CONTACTS WHERE NAME = (?)",self.TXT1.text)
  }
        catch{
            print(error)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func update(_ sender: Any) {
        
        do{
            try con?.run("UPDATE CONTACTS SET NAME = (?) WHERE NAME = 'vamsikrishna'",self.TXT1.text)
        }
        catch{
            print(error)
        }
    }

}

