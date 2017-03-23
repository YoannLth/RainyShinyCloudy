//
//  Date+extensions.swift
//  RainyShinyCloudy
//
//  Created by yoann lathuiliere on 23/03/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import Foundation

extension Date {
  func dayOfTheWeek() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter.string(from: self)
  }
}
