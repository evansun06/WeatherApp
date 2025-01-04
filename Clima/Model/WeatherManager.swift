//
//  WeatherManager.swift
//  Clima
//
//  Created by Evan Sun on 2024-08-07.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather (_ weatherManagaer:WeatherManager, weather:WeatherModel)
    func didFailWithError (error:Error)
}

class WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=f993b62ad6b09ddd949b97b01b495020&units=metric" //default url for api
    var delegate:WeatherManagerDelegate?
    
    func fetchWeather (cityName:String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest (with urlString:String) {
        //1.Create URL
        if let url = URL(string: urlString) {
        
            //2.Create URL session
            let session = URLSession (configuration: .default) //think of this as a browser
            
            //3. Give session a task
            /*
             let task = session.dataTask(with: url, completionHandler: handle(data: response: error:)) //when task is complete/session is over this method calls the handle method
             */
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){//self is required
                        self.delegate?.didUpdateWeather(self,weather:weather)
                    }
                }
            }
            //4. Start Task
            task.resume()
        }
    }
    
    func parseJSON (_ weatherData:Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
           
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            print(weather.temperatureString)
            print(weather.cityName)
            print(weather.conditionName)
            print(weather.conditionId)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
        
    }
    
    
}
