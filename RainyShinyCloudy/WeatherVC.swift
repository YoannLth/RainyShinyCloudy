//
//  ViewController.swift
//  RainyShinyCloudy
//
//  Created by yoann lathuiliere on 17/03/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

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
  var forecasts = [Forecast]()
  let locationManager = CLLocationManager()
  var currentLocation: CLLocation!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    locationManager.delegate = self
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startMonitoringSignificantLocationChanges()
    
    dateLabel.text = ""
    tempLabel.text = "--°C"
    cityLabel.text = ""
    weatherLabel.text = ""
    
    locationAuthStatus()
  }
  
  
  
  
  // MARK: - Functions
  func updateUI() {
    dateLabel.text = currentWeather.date
    tempLabel.text = String(format: "%.1f°C", currentWeather.currentTemp)
    cityLabel.text = currentWeather.cityName
    weatherLabel.text = currentWeather.weatherType
    weatherImage.image = UIImage(named: currentWeather.weatherType) ?? UIImage()
    
    self.tableView.reloadData()
  }
  
  func downloadForecastData(completion: @escaping () -> Void) {
    let cnt = "10"
    let url = "\(Const.baseURL)forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=\(cnt)&appid=\(Const.APIKey)"
    
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
    if let list = json["list"].array {
      for obj in list {
        let forecast = Forecast(weatherDict: obj)
        forecasts.append(forecast)
      }
      forecasts.remove(at: 0)
    }
  }
  
  func locationAuthStatus() {
    if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
      currentLocation = locationManager.location
      Location.sharedInstance.latitude = currentLocation.coordinate.latitude
      Location.sharedInstance.longitude = currentLocation.coordinate.longitude
      
      currentWeather.downloadWeatherDetails(completion: {
        self.downloadForecastData(completion: {
          self.updateUI()
        })
      })
    } else {
      locationManager.requestWhenInUseAuthorization()
    }
  }
}





// MARK: - UITableView
extension WeatherVC: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return forecasts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
      cell.configureCell(forecast: forecasts[indexPath.row])
      return cell
    }
    
    return WeatherCell()
  }
}




// MARK: - CoreLocation
extension WeatherVC: CLLocationManagerDelegate {
  
}
