//
//  ViewController.swift
//  Demo_012
//
//  Created by 鄭淳澧 on 2021/7/19.
//

import UIKit

class ViewController: UIViewController {
    
    //運算結果
    @IBOutlet weak var resultLabel: UILabel!
    //現在螢幕顯示的數值; 過去螢幕顯示的數值; 是否做運算
    var currentNum:Double = 0
    var previousNum:Double = 0
    var calculated:Bool = false
    var tempNum:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func numbers(_ sender: Any) {
        //按下數字按鈕, 變數inputNumber的值即是每個label的標籤值 - 1
        let inputNumber = (sender as AnyObject).tag - 1
        
        //label在0 及運算符以外的字串, 字串會加上新輸入的數字; 否則label即是新輸入的數字
        if resultLabel.text != "0" && resultLabel.text != "＋" && resultLabel.text != "−" && resultLabel.text != "×" && resultLabel.text != "÷" {
            resultLabel.text! += "\(inputNumber)"
//            tempNum = Double(inputNumber)
        } else {
            resultLabel.text = "\(inputNumber)"
        }
        
        //現在螢幕顯示值, 有label值便是label轉Double, 否則為0
        if resultLabel.text!.count >= 10 {
            resultLabel.text = String(resultLabel.text!.prefix(10))
        }
        currentNum = Double(resultLabel.text!) ?? 0
    }
    
    //按下清除, label顯示為0, 現在值清空, 舊數值清空, 是否計算為否
    @IBAction func clearBtn(_ sender: Any) {
        resultLabel.text = "0"
        currentNum = 0
        previousNum = 0
        calculated = false
    }
    
    //非清除, 而是消去上次輸入的數字, 使之能修改為新的數字
    //若label不為0, 移除前一次的輸入(字串最後的字元), 此時若label為空, label設為0
    //最後賦值給currentNum, 以便在有運算子時做運算
    @IBAction func deleteBtn(_ sender: Any) {
//        if resultLabel.text != "0" {
//            resultLabel.text?.removeLast()
//            if resultLabel.text! == ""  {
//                resultLabel.text = "0"
//            }
//
//        }
        if resultLabel.text?.count != 1 {
            resultLabel.text?.removeLast()
        } else {
            resultLabel.text = "0"
        }
        currentNum = Double(resultLabel.text!) ?? 0
    }
    
    //按下%, 現在值除以100, 連按便連除(將此次運算賦值給currentNum)
    @IBAction func percentageBtn(_ sender: Any) {
//        resultLabel.text = "\(currentNum / 100)"
        wantedPresentString(from: currentNum / 100)
        currentNum = currentNum / 100
    }
    
//    x^Y
    //按下後currentNum變號
    @IBAction func signBtn(_ sender: Any) {
        currentNum = -currentNum
//        resultLabel.text = "\(currentNum)"
        wantedPresentString(from: -currentNum)
    }
    
    @IBAction func dotBtn(_ sender: Any) {
        resultLabel.text! += "."
    }
    
    func wantedPresentString(from number: Double) {
        var wantedText: String
        //無條件進位後若與自身相同, 代表後面無小數位的表達式較適合顯示, 否則直接顯示自身
        //並且字串長度限縮為10
        if floor(number) == number {
            wantedText = "\(Int(number))"
        } else {
            wantedText = "\(number)"
        }
        if wantedText.count >= 10 {
            wantedText = String(wantedText.prefix(10))
        }
        resultLabel.text = wantedText
    }
   
    //按下+, label變成+, 將原先螢幕顯示的數字存入舊數字
    @IBAction func plusBtn(_ sender: Any) {
        resultLabel.text = "＋"
        operactor = .plus
        calculated = true
        previousNum = currentNum
    }
    @IBAction func minusBtn(_ sender: Any) {
        resultLabel.text = "−"
        operactor = .minus
        calculated = true
        previousNum = currentNum
    }
    @IBAction func crossBtn(_ sender: Any) {
        resultLabel.text = "×"
        operactor = .times
        calculated = true
        previousNum = currentNum
    }
    @IBAction func overBtn(_ sender: Any) {
        resultLabel.text = "÷"
        operactor = .divide
        calculated = true
        previousNum = currentNum
    }
    
    
    var operactor:OperactionType = .none
    
    enum OperactionType{
        case plus
        case minus
        case times
        case divide
//        case percentage
//        case dot
        case none
    }
    
    @IBAction func equalsBtn(_ sender: Any) {
        if calculated == true {
            switch operactor {
                case .plus:
                    currentNum = previousNum + currentNum
//                    resultLabel.text = "\(currentNum)"
                    wantedPresentString(from: currentNum)
                case .minus:
                    currentNum = previousNum - currentNum
                    wantedPresentString(from: currentNum)
                case .times:
                    currentNum = previousNum * currentNum
                    wantedPresentString(from: currentNum)
                case .divide:
                    currentNum = previousNum / currentNum
                    wantedPresentString(from: currentNum)
                case .none:
                    resultLabel.text = ""
//                case .percentage:
//                    resultLabel.text = ""
//                case .dot:
//                    resultLabel.text = ""
            }
            calculated = false
        }
    }
    

}

