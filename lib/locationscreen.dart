import 'package:flutter/material.dart';
import 'package:app/constants.dart';
import 'package:app/weather.dart';
import 'package:app/city_name.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  var dt = DateTime.now();
  String phase;
  int temperature;
  int weatherimage;
  String cityName;
  String weatherMessage;
  int feelLike;


  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;

        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherimage = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
       double feelslike = weatherData['main']['feels_like'];
      feelLike = feelslike.toInt();


      if(dt.hour > 18 || dt.hour<6) {
        phase = 'night';
      } else phase = 'day';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/pic$weatherimage.JPG'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        var weatherData = await weather.getLocationWeather();
                        updateUI(weatherData);
                      },
                      child: Icon(
                        Icons.pin_drop,
                        size: 50.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        if (typedName != null) {
                          var weatherData =
                          await weather.getCityWeather(typedName);
                          updateUI(weatherData);
                        }
                      },
                      child: Icon(
                        Icons.search,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 100, 0, 0),
                child: Text(
                  '$weatherMessage',
                  textAlign: TextAlign.left,
                  style: big,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  phase,
                  textAlign: TextAlign.left,
                  style: big,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 250, 0, 0),
                child: Text(
                  cityName,
                  textAlign: TextAlign.left,
                  style: small,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15.0,10,0,0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°C',
                      style: huge,
                    ),


                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(
                  'feels like   $feelLike°C',
                  textAlign: TextAlign.left,
                  style: small,
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }
}
