//
//  Forecast.swift
//  RainyShinyCloudy
//
//  Created by yoann lathuiliere on 23/03/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit
import SwiftyJSON

class Forecast {
  private var _date: String!
  private var _weatherType: String!
  private var _highTemp: Double!
  private var _lowTemp: Double!
  
  var date: String {
    if _date == nil {
      _date = ""
    }
    
    return _date
  }
  
  var weatherType: String {
    if _weatherType == nil {
      _weatherType = ""
    }
    
    return _weatherType
  }
  
  var highTemp: Double {
    if _highTemp == nil {
      _highTemp = 0.0
    }
    
    return _highTemp
  }
  
  var lowTemp: Double {
    if _lowTemp == nil {
      _lowTemp = 0.0
    }
    
    return _lowTemp
  }
  
  init(weatherDict: JSON) {
    if let weatherArray = weatherDict["weather"].array, let weatherType = weatherArray.first?["main"].string {
      self._weatherType = weatherType
    }
    
    if let minTemp = weatherDict["temp"]["min"].double {
      self._lowTemp = minTemp - 273.5
    }
    
    if let maxTemp = weatherDict["temp"]["max"].double {
      self._highTemp = maxTemp - 273.5
    }
    
    if let date = weatherDict["dt"].int {
      self._date = Date(timeIntervalSince1970: TimeInterval(date)).dayOfTheWeek()
    }
  }
}
