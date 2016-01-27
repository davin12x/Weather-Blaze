//
//  Weather.swift
//  Weather
//
//  Created by Lalit on 2016-01-26.
//  Copyright © 2016 Bagga. All rights reserved.
//

import Foundation
import Alamofire

class Weather{
    private var _currentCity:String!
    private var _humidity:String!
    private var _temp:String!
    private var _wind : String!
    private var _weatherUrl:String!
    private var _description:String!
    private var _icon :String!
    private var _lat = 43.4256890
    private var _long = -80.4408190
    private var _temp_min:String!
    
    init(name:String){
        _currentCity = name
    }
    var tempMin:String{
        if _temp_min == nil{
            _temp_min = ""
        }
        return _temp_min
        
    }
 
    var currentCity:String{
        get{
            if _currentCity == nil{
                _currentCity = ""
            }
            return _currentCity
        }
    }
    var humidity:String{
        if _humidity == nil{
            _humidity = "--"
        }
         return _humidity
    }
    var temp :String{
        if _temp == nil{
            _temp = "--"
        }
        return _temp
    }
    var wind:String{
        if _wind == nil {
            _wind = "--"
        }
        return _wind
    }
    var description:String{
        if _description == nil{
            _description = ""
        }
        return _description
    }
    var lat :Double{
        return _lat
    }
    var long:Double{
        return _long
    }
    var icon:String{
        if _icon == nil{
            _icon = ""
        }
        return _icon
    }
   
    func downloadWeather(complete:DownloadComplete){
        func celsius (kelvin:Double)->Double{
            let celsius = kelvin - 273.15
            return celsius
        }
        let url = "\(BASEURL)lat=\(_lat)&lon=\(_long)\(APIKEY)"
        let nsurl = NSURL(string: url)
        Alamofire.request(.GET,nsurl!).responseJSON{response in
        
        let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let weather = dict["weather"] as? [Dictionary<String,AnyObject>]{
                    print(weather)
                    if let desc = weather[0]["description"] as? String {
                        self._description = desc
                    }
                    if let icon = weather[0]["icon"] as? String{
                        self._icon = icon
                    }
                }
                if let main = dict["main"] as? Dictionary<String,AnyObject>{
                    if let temp = main["temp"] as? Double{
                        let celsiusTemp = celsius(temp)
                        let tempDigit = NSString(format: "%.0f", celsiusTemp)
                        self._temp = "\(tempDigit)°"
                    }
                    if let temp_min = main["temp_min"] as? Double{
                        
                        let getTemp = celsius(temp_min)
                         let tempDigit = NSString(format: "%.0f", getTemp)
                        self._temp_min = "\(tempDigit)°"
                    }
                    if let humidity = main["humidity"] as? Int{
                        self._humidity = "\(humidity)%"
                    }
                }
                if let wind = dict["wind"] as? Dictionary<String,AnyObject>{
                    if let speed = wind["speed"] as? Double{
                        self._wind = "\(speed) mph"
                    }
                }
                if let name = dict["name"] as? String{
                    self._currentCity = name
                }
//                print(self._currentCity)
//                print(self.speed)
//                print(self.humidity)
//                print(self.temp)
//                print(self.icon)
//                print(self.description)
                
                
                
            }
            complete()
        }
        
    }
    
    
}
