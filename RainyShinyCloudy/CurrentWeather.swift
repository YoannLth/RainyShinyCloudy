//
//  CurrentWeather.swift
//  RainyShinyCloudy
//
//  Created by yoann lathuiliere on 22/03/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import Foundation
import Alamofire
import Timberjack
import SwiftyJSON

class CurrentWeather {
  private var _cityName: String!
  private var _date: String!
  private var _weatherType: String!
  private var _currentTemp: Double!
  
  var cityName: String {
    if _cityName == nil {
      _cityName = ""
    }
    
    return _cityName
  }
  
  var date: String {
    if _date == nil {
      _date = ""
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .none
    let currentDate = dateFormatter.string(from: Date())
    self._date = "Today, \(currentDate)"
    
    return _date
  }
  
  var weatherType: String {
    if _weatherType == nil {
      _weatherType = ""
    }
    
    return _weatherType
  }
  
  var currentTemp: Double {
    if _currentTemp == nil {
      _currentTemp = 0.0
    }
    
    return _currentTemp
  }
  
  func downloadWeatherDetails(completion: @escaping () -> Void) {
    let url = "\(Const.baseURL)weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=\(Const.APIKey)"
    
    Alamofire.request(url).responseJSON { response in
      let result = response.result
      
      switch result {
      case .success(let value):
        let json = JSON(value)
        self.parseJSON(json: json)
        completion()
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func parseJSON(json: JSON) {
    if let name = json["name"].string {
      self._cityName = name.capitalized
    }
    
    if let weatherArray = json["weather"].array, let weatherType = weatherArray.first?["main"].string {
      self._weatherType = weatherType
    }
    
    if let temp = json["main"]["temp"].double {
      self._currentTemp = temp - 273.5
    }
  }
}
