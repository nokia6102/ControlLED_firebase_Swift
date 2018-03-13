//
//  ViewController.swift
//  ControlLED
//
//  Created by Kuan L. Chen on 20/01/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

//---
import FirebaseDatabase


var ref: DatabaseReference!              //new version is Database
//---


class ViewController: UIViewController {
    
    @IBOutlet weak var greenBtn: UIButton!
    @IBOutlet weak var yellowBtn: UIButton!
    @IBOutlet weak var redBtn: UIButton!
    
    func getOnNet() {
        ref = Database.database().reference()           //new version Database
        
        // 從 Firebase 取得資料庫資料。
        
        // 進入該資料並指定位置 "led"。
        // 官方 observe 方法去監測指定位置底下的數據變化 。
        
        ref.child("led").observe(.value, with: {
            (snapshot) in
            // 並設定 snapshot 為閉包回傳的資料。
            
            let value = snapshot.value as? [String:AnyObject]
            // 從 snapshot 的 value 取得的就是我們在資料庫的資料，
            // 並指定它的型別就是 [String:AnyObject]。
            
            let led17State = value?["led17"]?["on"] as! Bool
            let led22State = value?["led22"]?["on"] as! Bool
            let led27State = value?["led27"]?["on"] as! Bool
            // 宣告三個常數，讓它們解析從資料庫取得下來的資料，
            // 分別解析 led 資料底下的 led17, led22, led27，
            // 再從中取得 on 的狀態，
            // 並轉換指定型別為布林。
            
            self.greenBtn.isSelected = led17State
            self.yellowBtn.isSelected = led22State
            self.redBtn.isSelected = led27State
            // 最後就是設定每一顆 iOS 上的按鈕的狀態等於從網路上取得的狀態。
        })
    }
    
    
    @IBAction func btnAction(_ sender: UIButton)
    {
        // tag100: 綠色btn, 200: 黃色btn, 300: 紅色btn
        
        sender.isSelected = sender.isSelected ? false : true
        
        switch sender.tag
        {
        case 100:
            ref.child("led/led17/on").setValue(sender.isSelected ? true : false)
        case 200:
            ref.child("led/led22/on").setValue(sender.isSelected ? true : false)
        case 300:
            ref.child("led/led27/on").setValue(sender.isSelected ? true : false)
        default:
            break
        }
        
        // 我們使用了 Swith Case 去判斷被按下的按鈕是哪一顆，
        // 依據先前所設定的 tag 即可以判斷是 綠/黃/紅 哪一顆按鈕被傳進來這個函式，
        // 當 tag 為 100 的按鈕進來後，我們進去設定全域變數 ref 資料的 child，
        // 這個情況下我們要改變的就是 Firebase 裡 led 底下 led17 的 on 狀態，
        // 所以可以直接寫成 "led/led17/on" （就像電腦目錄一層一層下去一樣），
        // 之後用官方的方法 setValue 給他，
        // 而因為在 Firebase 上 on 的狀態是布林，
        // 所以我們就將 iOS App 該按鈕是否被點選的狀態寫入，
        // 在裡面判斷式的解釋為：
        // 如果 sender.isSelected (被點擊的狀態) 是 true，我就寫入 true，反之則 false。
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getOnNet()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    
}

