//
//  ViewController.swift
//  tipCalculator
//
//  Created by Sofiya Taskova on 9/4/16.
//  Copyright © 2016 Sofiya Taskova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    
    let tipPercentages = [0.18, 0.2, 0.25]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        let defaultTip = defaults.integer(forKey: "default_tip")
        tipControl.selectedSegmentIndex = defaultTip
        
        let defaultBill = defaults.double(forKey: "bill")
        billField.text = String(defaultBill)
        let defaultBillDouble = defaultBill ?? 0.0
        let defaultTipDouble = tipPercentages[defaultTip] * defaultBillDouble
        
        calc(bill: defaultBillDouble, tip: defaultTipDouble)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let defaults = UserDefaults.standard
        let billFieldDouble = billField.text?.replacingOccurrences(of: "$", with: "")
        defaults.set(billFieldDouble, forKey: "bill")
        defaults.synchronize()
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        calc(bill: bill, tip: tip)
    }
    
    func calc(bill: Double, tip: Double) {
        let total = bill + tip
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
}

