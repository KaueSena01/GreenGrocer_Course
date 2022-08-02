import 'package:flutter/material.dart';
import 'package:greengrocer_course/src/config/custom_colors.dart';

class QuantityWidget extends StatelessWidget {

  final int value;
  final String suffixText;
  final Function(int quantity) result;

  const QuantityWidget({ 
    Key? key,
    required this.value,
    required this.suffixText,
    required this.result
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          _QuantityButton(
            color: Colors.grey, 
            icon: Icons.remove, 
            onPressed: () {
              
              if(value == 1) return;
              
              int resultCount = value - 1;
              result(resultCount);
            }
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text('$value$suffixText', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          _QuantityButton(
            color: CustomColors.customPrimaryColor, 
            icon: Icons.add, 
            onPressed: () {
              int resultCount = value + 1;
              result(resultCount);
            }
          )
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;


  const _QuantityButton({
    Key? key,
    required this.color,
    required this.icon,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onPressed,
        child: Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
    );
  }
}