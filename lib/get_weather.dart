import 'package:flutter/cupertino.dart';

IconData getWeatherIcon(String weatherCondition) {
    switch (weatherCondition.toLowerCase()) {
      case 'thunderstorm':
        return CupertinoIcons.cloud_bolt_fill;
      case 'drizzle':
        return CupertinoIcons.cloud_drizzle_fill;
      case 'rain':
        return CupertinoIcons.cloud_rain_fill;
      case 'snow':
        return CupertinoIcons.snow;
      case 'atmosphere':
        return CupertinoIcons.smoke_fill;
      case 'clear':
        return CupertinoIcons.sun_max_fill;
      default:
        return CupertinoIcons.cloud_fill;
    }
  }