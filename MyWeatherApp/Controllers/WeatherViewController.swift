//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Zofka Jostakova on 22/07/2021.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController {
    
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var feelsLike: UILabel!
    
    @IBOutlet weak var weatherDescription: UILabel!
    var weatherManager = WeatherManager()
    let locationManager =  CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        weatherManager.delegate = self
        searchTextField.delegate =  self 
    }
    

            
            }
        
    
    
 
    


//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!) //print what is in search field
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Please, enter the city"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLike.text = weather.feelsLikeTemp
            self.weatherImage.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.weatherDescription.text = weather.weatherDescription
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

//MARK: - CLLocationmanagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
            
        
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)  {
        print(error)
    }
}



    



