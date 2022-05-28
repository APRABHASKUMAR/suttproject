import 'package:app/location.dart';
import 'package:app/networking.dart';
import 'package:geolocator/geolocator.dart';

const apiKey = '99c670dcc180792335a4ffe0d0de5837';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    Uri url = Uri.parse('$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    NetworkHelper networkHelper = NetworkHelper(
        url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    Position position = await location.determinePosition();


    Uri url = Uri.parse('$openWeatherMapURL?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric');
    NetworkHelper networkHelper = NetworkHelper(
        url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  int getWeatherIcon(int condition) {
    var dt = DateTime.now();
    String phase;
    if(dt.hour > 18 || dt.hour<6) {
      phase = 'night';
    } else phase = 'day';
   if (condition < 600 && phase == 'day') {
      return 1;
    } else if (condition < 700 && phase == 'day') {
      return 2;
    } else if (condition <= 800 && phase == 'day') {
      return 3;
    }  else if (condition <= 804 && phase == 'day') {
      return 4;
    } else return 5;
  }

  String getMessage(int temp) {
    if (temp > 40) {
      return 'A hot';
    } else if (temp >25) {
      return 'A pleasent';
    } else if (temp > 10) {
      return 'A cold';
    } else {
      return 'A very cold';
    }
  }
}
