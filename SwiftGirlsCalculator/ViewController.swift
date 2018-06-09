//
//  ViewController.swift
//  SwiftGirlsCalculator
//
//  Created by Candy on 2018/5/30.
//  Copyright © 2018年 com.CandyHu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scriptLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    //紀錄使用者目前輸入的所有字的字串
    var inputString: String = "" {
        didSet {
            scriptLabel.text = inputString
        }
    }
    
    //因使用者可能會輸入多位數，這個變數用來紀錄使用者輸入的數字
    var tempNumberString: String = ""
    
    //記錄目前的運算子
    var operatorString: String = ""
    
    //記錄結果
    var result: Float? = nil {
        didSet {
            resultLabel.text = "\(result ?? 0)"
        }
    }
    
    //記錄第二個數字
    var nextNumber: Float? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //數字(0~9)按鈕被按下後要執行的方法
    @IBAction func numeralButtonClicked(_ sender: UIButton) {
        let number = sender.tag
        inputString += "\(number)"
        tempNumberString += "\(number)"
    }
    
    // "+", "-", "x", "/" 按鈕被按下後要執行的方法
    @IBAction func operatorButtonClicked(_ sender: UIButton) {
        //需可以抓取operator，不然接下來做什麼都沒意義
        guard let symbol = sender.currentTitle else {
            return
        }
        
        //把tempNumberString 轉換成數字，放進result 或nextNumber 內
        //判斷兩個變數是否都有值（表示可運算）
        //依照operatorString 來決定是走哪一個運算方法
        inputString += symbol
        
        if let number = Float(tempNumberString) {
            if result == nil {
                result = number
            } else {
                nextNumber = number
            }
        }
        tempNumberString = ""
        
        if (result != nil && nextNumber != nil) {
            switch (operatorString) {
            case "+" :
                add()
            case "-" :
                minus()
            case "x" :
                multiply()
            case "/" :
                divide()
                
            default:
                break
            }
        }
        
        operatorString = symbol
    }
    
    // "C" 按鈕被按下後要執行的方法
    @IBAction func clearButtonClicked(_ sender: UIButton) {
        clear()
    }
    
    // "=" 按鈕被按下後要執行的方法
    @IBAction func amountButtonClicked(_ sender: UIButton) {
        inputString += "="
        
        if let number = Float(tempNumberString) {
            if result == nil {
                result = number
            } else {
                nextNumber = number
            }
        }
        tempNumberString = ""
        
        if (result != nil && nextNumber != nil) {
            switch (operatorString) {
            case "+" :
                add()
            case "-" :
                minus()
            case "x" :
                multiply()
            case "/" :
                divide()
                
            default:
                break
            }
        }
        
        //跟+-x/ 不一樣的地方是，按下等於後要把結果串接進inputString，且不用紀錄operatorString
        guard result != nil else {
            return
        }
        inputString += "\(result!)"
    }
    
    //MARK: 運算子運算方法
    func add() {
        //判斷兩個變數是否都有值，都有就相加
        //計算完後把第二個數字改為nil
        guard result != nil && nextNumber != nil else {
            return
        }
        
        result = result! + nextNumber!
        nextNumber = nil
    }
    
    func minus() {
        guard result != nil && nextNumber != nil else {
            return
        }

        result = result! - nextNumber!
        nextNumber = nil
    }
    
    func multiply() {
        guard result != nil && nextNumber != nil else {
            return
        }
        
        result = result! * nextNumber!
        nextNumber = nil
    }
    
    func divide() {
        guard result != nil && nextNumber != nil else {
            return
        }
        
        guard nextNumber != 0 else {
            clear(string: "Error")
            return
        }
        result = result! / nextNumber!
        nextNumber = nil
    }
    
    func clear(string: String = "") {
        //把所有參數都歸0或清空
        inputString = string
        tempNumberString = ""
        operatorString = ""
        result = nil
        nextNumber = nil
    }
}

