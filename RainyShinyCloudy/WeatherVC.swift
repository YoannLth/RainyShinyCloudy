//
//  ViewController.swift
//  RainyShinyCloudy
//
//  Created by yoann lathuiliere on 17/03/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {

  // MARK: - Outlets
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var tempLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var weatherLabel: UILabel!
  @IBOutlet weak var weatherImage: UIImageView!
  @IBOutlet weak var tableView: UITableView!
  
  
  
  // MARK: - Variables
  var currentWeather = CurrentWeather()
  
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    currentWeather.downloadWeatherDetails()
  }
}





// MARK: - UITableView
extension WeatherVC: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 6
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
    
    return cell
  }
}
