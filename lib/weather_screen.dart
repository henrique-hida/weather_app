import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'weather_colors.dart';
import 'additional_item.dart';
import 'forecast_item.dart';
import './get_weather.dart';
import 'package:http/http.dart' as http;
import './secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({ Key? key }) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String city = 'Iida';

  void _updateCity(String newcity) {
    setState(() {
      city = newcity;
    });
  }
  
  final TextEditingController _controller = TextEditingController();
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {

      final res = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$city&APPID=$weatherAPI'),
      );

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw data['message'];
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(

//NavBar
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CoHida.neuwhite,
        automaticallyImplyMiddle: true,
        trailing: CupertinoButton(
          onPressed: () {
            setState(() {});
          },
          child: const Icon(
            CupertinoIcons.refresh,
            size: 20,
            color: CoHida.green,
          ),
        ),
        middle: const Text(
          'WeatherApp',
          style: TextStyle(
            color: CoHida.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
//endNavBar

//Loader
      child: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
//endLoader

          final data = snapshot.data as Map<String, dynamic>;
          final currentWeatherData = data['list'][0];

          final currentTemp = (currentWeatherData['main']['temp']);
          final currentSky = currentWeatherData['weather'][0]['main'];
          final currentHumidity = currentWeatherData['main']['humidity'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];
          final currentPressure = currentWeatherData['main']['pressure'];

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
//TextField
                CupertinoTextField(
                  controller: _controller,
                  placeholder: 'Enter city name',
                  onSubmitted: (value) {
                    _updateCity(value);
                  }
                ),
                const SizedBox(height: 20),
//endTextField

//MainForecast
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: CoHida.neuwhite,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 30.0,
                        offset: Offset(-10, -10),
                        color: CoHida.glow,
                      ),
                      BoxShadow(
                        blurRadius: 30.0,
                        offset: Offset(10, 10),
                        color: CoHida.shadow,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          '${(currentTemp - 273).toStringAsFixed(0)}°C',
                          style: const TextStyle(
                            color: CoHida.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Icon(
                          getWeatherIcon(currentSky),
                          size: 70,
                          color: CoHida.green,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          currentSky,
                          style: const TextStyle(
                            color: CoHida.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
//endMainForecast

//HourForecast
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hour Forecast',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                SizedBox(
                  height: 125,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      final forecast = data['list'][index + 1];
                      return ForecastItem(
                        hour: '${forecast['dt_txt'].toString().substring(11, 13)}h', 
                        temperature: '${(forecast['main']['temp']-273).toStringAsFixed(0)}°C', 
                        icon: getWeatherIcon(forecast['weather'][0]['main'])
                      );
                    },
                  ),
                ),
//endHourForecast

//AdditionalInfo
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Additional information',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalItem(
                      icon: CupertinoIcons.drop,
                      label: 'Humidity',
                      value: '${currentHumidity.toString()} %',
                    ),
                    AdditionalItem(
                      icon: CupertinoIcons.wind,
                      label: 'Wind Speed',
                      value: '${currentWindSpeed.toString()} m/s',
                    ),
                    AdditionalItem(
                      icon: CupertinoIcons.arrow_down_to_line_alt,
                      label: 'Pressure',
                      value: '${currentPressure.toString()} hPa',
                    ),
                  ],
                ),
//endAdditionalInfo

              ],
            ),
          );
        },
      ),
    );
  }
}
