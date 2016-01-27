//
//  MainViewVC.swift
//  Weather
//
//  Created by Lalit on 2016-01-26.
//  Copyright © 2016 Bagga. All rights reserved.
//

import UIKit

class MainViewVC: UIViewController {

    var weatherData : Weather!
    @IBOutlet weak var currentCity:UILabel!
    @IBOutlet weak var currentTemp:UILabel!
    @IBOutlet weak var currentWind:UILabel!
    @IBOutlet weak var currentHumidity:UILabel!
    @IBOutlet weak var desc:UILabel!
    @IBOutlet weak var tempMax:UILabel!
    @IBOutlet weak var tempImage:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       weatherData = Weather(name: "Weather")
        weatherData.downloadWeather { () -> () in
            
            self.update()
            
        }
       
    }
    func update(){
        self.currentCity.text = weatherData.currentCity.capitalizedString
        self.currentWind.text = weatherData.wind
        self.currentHumidity.text = weatherData.humidity
        self.currentTemp.text = weatherData.temp
        self.desc.text = weatherData.description.capitalizedString
        self.tempMax.text = weatherData.tempMin
        
        if weatherData.icon == "" {
            tempImage.image = UIImage(named: "01d")
        }
        else{
            tempImage.image = UIImage(named: weatherData.icon)
        }
    }


}
