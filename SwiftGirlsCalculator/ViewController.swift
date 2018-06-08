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
    
    //紀錄等待被相互運算的數字們
    var numberArray: [Float] = [] {
        didSet {
            if numberArray.count > 0 {
                resultLabel.text = "\(numberArray[0])"
            } else {
                resultLabel.text = "0"
            }
        }
    }
    
    //記錄目前的運算子
    var operatorString: String = ""
    
    //記錄結果
    var result: Float = 0
    
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
        
        //把tempNumberString 轉換成數字，加進numberArray 內
        //判斷numberArray 內的數字是否大於等於兩個（表示可以運算）
        //依照operatorString 來決定是走哪一個運算方法
        inputString += symbol
        
        if let number = Float(tempNumberString) {
            numberArray.append(number)
        }
        tempNumberString = ""
        
        if (numberArray.count >= 2) {
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
            numberArray.append(number)
        }
        tempNumberString = ""
        
        if (numberArray.count >= 2) {
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
        guard numberArray.count > 0 else {
            return
        }
        inputString += "\(numberArray[0])"
        
    }
    
    //MARK: 運算子運算方法
    func add() {
        //先取出numberArray 中的第一個數字，用for 迴圈把剩下的數字都相加
        //最後再把算出的數字塞回numberArray ，此時numberArray 裡面只剩result ，等待後繼被運算
        guard numberArray.count > 0 else {
            return
        }
        
        var result = numberArray[0]
        
        for index in 1..<numberArray.count {
            result = result + numberArray[index]
        }
        numberArray = [result]
    }
    
    func minus() {
        guard numberArray.count > 0 else {
            return
        }
        
        var result = numberArray[0]
        
        for index in 1..<numberArray.count {
            result = result - numberArray[index]
        }
        numberArray = [result]
    }
    
    func multiply() {
        guard numberArray.count > 0 else {
            return
        }
        
        var result = numberArray[0]
        
        for index in 1..<numberArray.count {
            result = result * numberArray[index]
        }
        numberArray = [result]
    }
    
    func divide() {
        guard numberArray.count > 0 else {
            return
        }
        
        var result = numberArray[0]
        
        for index in 1..<numberArray.count {
            //除以0會錯誤
            if (numberArray[index] == 0) {
                clear(string: "Error")
                return
            }
            
            result = result / numberArray[index]
        }
        numberArray = [result]
    }
    
    func clear(string: String = "") {
        //把所有參數都歸0或清空
        inputString = string
        tempNumberString = ""
        operatorString = ""
        result = 0
        numberArray = []
    }
}

