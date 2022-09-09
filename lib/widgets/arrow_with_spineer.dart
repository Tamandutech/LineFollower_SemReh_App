import 'package:flutter/material.dart';
import 'package:line_follower_controller/colors.dart' as colors;

class ArrowSpinner extends StatefulWidget {
  ArrowSpinner({Key? key}) : super(key: key);

  @override
  State<ArrowSpinner> createState() => _ArrowSpinnerState();
}

class _ArrowSpinnerState extends State<ArrowSpinner> {
  List<String> straight = ['Reta', 'Curva', 'S.M'];
  String? selectedStraight = 'Reta';


  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Container(
          width: 110,
          height: 35,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0XFF58D68D ), colors.Colors.primaryColor]),
              borderRadius: BorderRadius.circular(20)),
          child: DropdownButton<String>(
            borderRadius: BorderRadius.circular(12),
            dropdownColor: colors.Colors.primaryColor,
            value: selectedStraight,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold),
            onChanged: (String? newValue) {
              setState(() {
                selectedStraight = newValue!;
              });
            },
            items: straight.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        SizedBox(width: 10),
        Icon(Icons.arrow_forward_rounded, color: Colors.green),
      ],
    );
  }
}
