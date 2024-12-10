//
//  WeatherView.swift
//  EdstemTest
//
//  Created by FARIS CP on 09/12/24.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel : WeatherViewModel = WeatherViewModel()
    @State private var searchText: String = ""
//    init(){
//            UITableView.appearance().backgroundColor = .clear
//            UITableViewCell.appearance().backgroundColor = .clear
//
//        }
    var body: some View {
        ZStack{
        backGroundView
            VStack(spacing:16 ){
              searchView
               currentWeatherView
                fiveDayForecastView
                Spacer()
            }
        }.onAppear(perform: {
            viewModel.getCurrentWeather()
        })
    }
}
extension WeatherView{
    var backGroundView: some View{
        LinearGradient(gradient: Gradient(colors:[.blue, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
    var searchView: some View{
        HStack(spacing: 16) {
            
            //SearchIcon
            Image("search-icon")
                .resizable()
                .frame(width: 18 ,height: 18)
            HStack{
                TextField("Search Location", text: $searchText)
                    
                Spacer()
                
            }
          
            
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 0)
        )

    }
    var currentWeatherView: some View{
        HStack{
            VStack(alignment: .leading){
                Text(viewModel.currentWeather?.name ?? "")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 18))
                    .lineLimit(2)
                Text(viewModel.currentWeather?.weather?[0].main ?? "")
                    .foregroundColor(.white)
                    //.fontWeight(.semibold)
                    .font(.system(size: 18))
                    .lineLimit(2)
                //30°
                Text("\(Int(Double(viewModel.currentWeather?.main?.feelsLike ?? 0.0)/10))°")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 50))
            }
            Spacer()
            Image("weather-icon")
                .resizable()
                .frame(width: 120 ,height: 120)
            
        }
        .padding(16)
        .frame(height: 130)
    }
    var fiveDayForecastView: some View {
        VStack {
            HStack {
                Text("5-Day Forecast")
                    .foregroundColor(.white)
                
                Spacer()
                }.padding(.leading)
            
            Divider()
                .padding([.leading, .trailing])
            ScrollView{
            ForEach(viewModel.forcastList ?? [], id: \.dt) { data in
                ZStack {
                    var date = data.dtTxt?.split(separator: " ")
                                        HStack {
                                            Text(date?[0] ?? "")
                                                .foregroundColor(.white)
                                            Spacer()
                                            Text("\(Int(data.main?.tempMin ?? 0.0))")
                                                .foregroundColor(.white)
                                                .padding(8)
                                            Text("\(Int(data.main?.tempMax ?? 0.0))")
                                                .foregroundColor(.white)
                                            }.padding([.leading, .trailing])

                                        Image(viewModel.setForcastImage(weather: data.weather?[0].main ?? ""))
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                    }
            }.listRowBackground(Color.clear)
        }
        }
       
    }

    
}
struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
