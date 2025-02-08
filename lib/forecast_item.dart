import 'package:flutter/cupertino.dart';
import './weather_colors.dart';

class ForecastItem extends StatelessWidget {
  final String hour;
  final String temperature;
  final IconData icon;

  const ForecastItem({ 
    Key? key,
    required this.hour,
    required this.temperature,
    required this.icon,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return //card
      Container (
        margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
        width: 70,
        clipBehavior: Clip.none,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: CoHida.neuwhite,
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              offset: Offset(-5, -5),
              color: CoHida.glow,
            ),
            BoxShadow(
              blurRadius: 5.0,
              offset: Offset(5, 5),
              color: CoHida.shadow,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column (
            children: [
              Text(
                hour,
                style: const TextStyle(
                   fontSize: 14,
                 ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
               ),
              const SizedBox(height: 8),
              Icon(
                icon,
                color: CoHida.shadow,
                size: 32,
               ),
               const SizedBox(height: 8,),
                Text(temperature),
            ],
          ),
        ),
      );
  }
}