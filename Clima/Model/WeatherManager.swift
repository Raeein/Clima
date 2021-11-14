struct WeatherMamager {
    let API_KEY = Constants().OpenWeatherAppApiKey
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)&appid=\(API_KEY)&units=metric"
        print(urlString)
    }
}
