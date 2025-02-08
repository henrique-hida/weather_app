import 'package:flutter/cupertino.dart';
import 'package:weather_app/weather_screen.dart';
import 'weather_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        scaffoldBackgroundColor: CoHida.neuwhite,
      ),
      home: WeatherScreen(),
    );
  }
}

