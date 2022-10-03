//
//  WeatherAPIViewController.swift
//  weatherAPI
//
//  Created by Hung-Ming Chen on 2022/8/31.
//

import UIKit

class WeatherAPIViewController: UIViewController {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityLonLat: UILabel!
    @IBOutlet weak var cityMinTemp: UILabel!
    @IBOutlet weak var cityMaxTemp: UILabel!
    @IBOutlet weak var cityWeather: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    var chooseCityNameEN = ""
    var chooseCityNameCN = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityName.font = cityName.font.withSize(25)
        cityLonLat.font = cityLonLat.font.withSize(25)
        cityMinTemp.font = cityMinTemp.font.withSize(25)
        cityMaxTemp.font = cityMaxTemp.font.withSize(25)
        cityWeather.font = cityWeather.font.withSize(25)
        
        navigationRightButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NetworkManager.shared.getWeatherData(city: chooseCityNameEN) { (response: CurrentWeatherData?) in
            
            guard let name = response?.name else { return }
            guard let coordLon = response?.coord.lon else { return }
            guard let coordLat = response?.coord.lat else { return }
            guard let temp_min = response?.main.temp_min else { return }
            guard let temp_max = response?.main.temp_max else { return }
            guard let description = response?.weather[0].description else { return }
            guard let cityWeather = response?.weather[0].main else { return }
            
            print("============== Weather data ==============")
            print(response!)
            print("============== Weather data ==============")
            print("城市名稱: \(name)")
            print("經緯度: (\(coordLon),\(coordLat))")
            print("最高溫: \(temp_max)°C, 最低溫: \(temp_min)°C")
            print("描述: \(description)")
            
            DispatchQueue.main.async {
                self.cityName.text = "城市名稱：\(self.chooseCityNameCN)"
                self.cityLonLat.text = "經緯度：(\(coordLon), \(coordLat))"
                self.cityMinTemp.text = "最低溫：\(temp_min)"
                self.cityMaxTemp.text = "最高溫：\(temp_max)"
                self.cityWeather.text = "天氣描述：\(description)"
                
                if cityWeather == "Clouds" {
                    self.weatherImage.image = UIImage(systemName: "cloud")
                }
                if cityWeather == "Clear" {
                    self.weatherImage.image = UIImage(systemName: "sun.max")
                }
                
            }
        } failure: { errorMessage in
            print(errorMessage!)
        }
    }
    
    func navigationRightButton() {
        let rightButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(searchCity))
        
        rightButton.tintColor = .blue
        rightButton.image = UIImage(systemName: "magnifyingglass")
        
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func searchCity() {
        let searchPageVC = SearchPageViewController()
        
        searchPageVC.searchPageDelegate = self
        
        self.navigationController?.pushViewController(searchPageVC, animated: true)
    }
}

extension WeatherAPIViewController: chooseCityDelegate {
    func chooseCity(nameEN: String, nameCN: String) {
        chooseCityNameEN = nameEN
        chooseCityNameCN = nameCN
    }
}
