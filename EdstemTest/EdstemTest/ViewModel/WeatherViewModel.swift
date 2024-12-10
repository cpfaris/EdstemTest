//
//  WeatherViewModel.swift
//  EdstemTest
//
//  Created by FARIS CP on 09/12/24.
//

import Foundation
class WeatherViewModel: ObservableObject{
    @Published var currentWeather : CurrentWeather?
    @Published var forcastWeather : DaysForecast?
    @Published var forcastList : [ForcastList]? = []
    @Published var isLoading : Bool = false
    var image : String?
   
    func getCurrentWeather(){
        
        isLoading = true
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=10.973498&lon=76.132942&appid=6f5af6262fdbd0d3a71a4ae5e6551f4e"
        NetworkManager.shared.getWeatherData(urlPath: urlString, queryParams: nil, completion: { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    DispatchQueue.main.async {
                    self.isLoading = false
                    self.currentWeather = try? decoder.decode(CurrentWeather.self, from: data)
                      //  self.article?.append(contentsOf: self.welcome?.articles ?? [])
                    }
                    if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                       let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                        let welcome1 = try? JSONDecoder().decode(CurrentWeather.self, from: jsonData)
                        print(String(decoding: jsonData, as: UTF8.self))
                        self.getFiveDayWeather()
                    } else {
                        print("json data malformed")
                        self.isLoading = false
                    }
                
                }catch{
                    self.isLoading = false
                    print("error",error.localizedDescription)
                }
            case .failure(let error):
                print("error",error.localizedDescription)
                self.isLoading = false
            }
            
        })
    }
    func getFiveDayWeather(){
        isLoading = true
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=10.973498&lon=76.132942&appid=6f5af6262fdbd0d3a71a4ae5e6551f4e"
        NetworkManager.shared.getWeatherData(urlPath: urlString, queryParams: nil, completion: { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    DispatchQueue.main.async {
                    self.isLoading = false
                    self.forcastWeather = try? decoder.decode(DaysForecast.self, from: data)
                    self.forcastList?.append(contentsOf: self.forcastWeather?.list ?? [])
                    }
                    if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                       let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                        let welcome1 = try? JSONDecoder().decode(DaysForecast.self, from: jsonData)
                        print("***************Forecast****************")
                        print(String(decoding: jsonData, as: UTF8.self))
                    } else {
                        print("json data malformed")
                        self.isLoading = false
                    }
                
                }catch{
                    self.isLoading = false
                    print("error",error.localizedDescription)
                }
            case .failure(let error):
                print("error",error.localizedDescription)
                self.isLoading = false
            }
            
        })
    }
    func setForcastImage(weather : String) -> String{
         image = weather ?? ""
        if image == "Clouds"{
           image = "cloudy"
        }else if image == "Rain"{
            image = "rain"
        }else{
            image = "clear-day"
        }
        return image ?? ""
    }
//    func loadMoreUsers(currentNews item: Article) {
//
//        guard !isLoading, let lastnews = article?.last, lastnews.source?.name == item.source?.name else {
//            return
//        }
//        if welcome?.totalResults ?? 0 > article?.count ?? 0{
//            pagesize += page
//
//            getNewsFeeds()
//        }
//
//    }

    
}
