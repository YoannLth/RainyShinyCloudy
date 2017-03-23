//
//  WeatherCell.swift
//  RainyShinyCloudy
//
//  Created by yoann lathuiliere on 24/03/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

  @IBOutlet weak var weatherIcon: UIImageView!
  @IBOutlet weak var dayLabel: UILabel!
  @IBOutlet weak var weatherLabel: UILabel!
  @IBOutlet weak var highTemp: UILabel!
  @IBOutlet weak var lowTemp: UILabel!

  func configureCell(forecast: Forecast) {
    dayLabel.text = forecast.date
    weatherLabel.text = forecast.weatherType
    highTemp.text = "\(forecast.highTemp)"
    lowTemp.text = "\(forecast.lowTemp)"
    weatherIcon.image = UIImage(named: forecast.weatherType) ?? UIImage()
  }

}
