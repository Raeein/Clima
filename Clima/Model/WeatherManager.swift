import Foundation

struct WeatherMamager {
    let API_KEY = Constants().OpenWeatherAppApiKey
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)&appid=\(API_KEY)&units=metric"
        performRequest(urlString: urlString)
    }
    func performRequest(urlString: String) {
        //Create URL
        if let url = URL(string: urlString) {
            //Create URLSessiom
            let session = URLSession(configuration: .default)
            //Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    //Add self because in a closure
                    self.parseJSON(weatherData: safeData)
                }
            }
            //Start the task
            task.resume()
        }
        
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        //.self to show the type of an object
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].description)
        } catch {
            print(error)
        }
    }
        
}
