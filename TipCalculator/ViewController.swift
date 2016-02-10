//
//  ViewController.swift
//  TipCalculator
//
//  Created by Zishi Wu on 2/7/16.
//  Copyright © 2016 Zishi Wu. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    // if user enters non-numerical text, prompt
    // user to type numerical
    @IBOutlet weak var instructions: UILabel!
    
    // needs to be checked for non-numerical text field values
    @IBOutlet weak var billAmount: UITextField!
    
    // changes according to value of the slider
    @IBOutlet weak var tipRate: UILabel!
    
    // billAmount * tipRate using NSDecimal
    @IBOutlet weak var tipAmount: UILabel!
    
    // bill amount + tipAmount using NSDecimal
    @IBOutlet weak var totalAmount: UILabel!

    @IBOutlet weak var tipRateSlider: UISlider!
    
    // changes tipRate label based on slider
    @IBAction func changeTipRate(sender: UISlider) {
        let currentTipRate = Int(sender.value)
        tipRate.text = "Tip Percentage: \(currentTipRate)%"
    }
    
    // gets bill amount and tip rate, converts to NSDecimalNumber, and calculates the tip and total
    @IBAction func calculatePay(sender: UIButton) {

        // first check if user entered a numerical or not
        if let _ = Float(billAmount.text!) {
            // get decimal values of bill and tip rate
            let decimal_100 = NSDecimalNumber(string: "100.0")
            let decimal_bill = NSDecimalNumber(string: billAmount.text)
            let sliderRate = NSDecimalNumber(integer: Int(tipRateSlider.value))
            let decimal_tipRate = sliderRate.decimalNumberByDividingBy(decimal_100)
        
            // calculate decimal values for tip and total, then update labels
            let decimal_tipAmount = decimal_bill.decimalNumberByMultiplyingBy(decimal_tipRate)
            let decimal_total = decimal_bill.decimalNumberByAdding(decimal_tipAmount)
            tipAmount.text = formatAsCurrency(decimal_tipAmount)
            totalAmount.text = formatAsCurrency(decimal_total)
        }
        else {
            print("Not a number")
            // billAmount.text = "Enter a valid number: "
        }
    }

    // convert decimal number to currency format
    func formatAsCurrency(decimal_number: NSNumber) -> String {
        let formatter = NSNumberFormatter()
        formatter.locale = NSLocale.currentLocale()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        return formatter.stringFromNumber(decimal_number)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billAmount.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

