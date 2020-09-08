//
//  ViewController.swift
//  Currency Converter
//
//  Created by Adwait Barkale on 08/09/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    let url = URL(string: "http://data.fixer.io/api/latest?access_key=\(K.apiKey)") //Put Your API Key where i have written K.apiKey,You will get it from http://data.fixer.io
    var myCurrency:[String] = []
    var myValues:[Double] = []
    var selectedCurrencyValue:Double = 0
    var selectedCurrencyName:String = ""
    
    @IBOutlet weak var txtUserInput: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var lblOutput: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNetworkData(from: url!)
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myCurrency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myCurrency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrencyValue = myValues[row]
        selectedCurrencyName = myCurrency[row]
    }
    
    
    func getNetworkData(from url:URL)
    {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil
            {
                print("Error Occured in Network Request")
            }else{
                if let data = data{
                    do{
                        let obj = try JSONDecoder().decode(CurrencyDataModel.self, from: data)
                        for(key , value) in obj.rates
                        {
                            self.myCurrency.append(key)
                            self.myValues.append(value)
                        }
                        print("MyCurrency = \(self.myCurrency)")
                        print("MyValues = \(self.myValues)")
                    }catch{
                        print("Error Decoding Data")
                    }
                }
                DispatchQueue.main.async {
                    self.pickerView.reloadAllComponents()
                }
                
            }
        }
        task.resume()
    }
    
    @IBAction func btnConvertTapped(_ sender: UIButton) {
        if txtUserInput.text != ""{
            lblOutput.text = "\(selectedCurrencyName) = " + String(Double(txtUserInput.text!)! * selectedCurrencyValue)
        }
    }
    
    
}

