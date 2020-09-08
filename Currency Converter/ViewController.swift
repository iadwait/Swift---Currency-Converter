//
//  ViewController.swift
//  Currency Converter
//
//  Created by Adwait Barkale on 08/09/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let url = URL(string: "http://data.fixer.io/api/latest?access_key=\(K.apiKey)") //Put Your API Key where i have written K.apiKey,You will get it from http://data.fixer.io
    var myCurrency:[String] = []
    var myValues:[Double] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getNetworkData(from: url!)
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
                
            }
        }
        task.resume()
    }

}

