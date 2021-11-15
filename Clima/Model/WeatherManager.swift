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
            let task = session.dataTask(with: url, completionHandler: handle(data: response: error: ))
            //Start the task
            task.resume()
        }
        
    }
    func handle(data: Data?, response: URLResponse?, error: Error?) -> Void {
        if error != nil {
            print(error!)
            return
        }
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
}
