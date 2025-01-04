//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {//Additional Superclasses
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    var shouldEndTextEditingDueToGesture = false
    var weatherManager = WeatherManager()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer (target: self, action: #selector (dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        searchTextField.delegate = self //sets handling of the textbar to the viewcontroller (here)
        weatherManager.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
        
    }
         
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" || shouldEndTextEditingDueToGesture {
            shouldEndTextEditingDueToGesture = false
            return true
        } else {
            searchTextField.placeholder = "enter location"
            return false
        }
    }
    
    func didUpdateWeather (_ weatherManagaer:WeatherManager, weather:WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
        
    }
    @objc func dismissKeyboard() {
            shouldEndTextEditingDueToGesture = true
            searchTextField.endEditing(true)
    }
                                    
}


