import Foundation

struct WeatherManager {
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
            let id = decodedData.weather[0].id
        } catch {
            print(error)
        }
    }
    
    func getConditionName(weatherID: Int) -> String {
        switch weatherID {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
                }
    }
        
}
