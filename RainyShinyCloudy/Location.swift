//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by yoann lathuiliere on 24/03/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import CoreLocation

class Location {
  static var sharedInstance = Location()
  
  private init() {}
  
  var latitude: Double!
  var longitude: Double!
}
