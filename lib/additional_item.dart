import 'package:flutter/cupertino.dart';
import './weather_colors.dart';

class AdditionalItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const AdditionalItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
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
            child: Center(
              child: Icon(
                icon,
                color: CoHida.green,
                size: 32,
               ),
            ),
          ),
          const SizedBox(height: 8),
          Text(label),
          const SizedBox(height: 8),
          Text(value,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
    );
  }
}