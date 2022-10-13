import 'package:flutter/material.dart';
import 'package:line_follower_controller/colors.dart' as colors;
import 'package:line_follower_controller/widgets/kd_controller.dart';
import 'package:line_follower_controller/widgets/kp_controller.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({Key? key}) : super(key: key);

  @override
  State<MainContainer> createState() => _MainContainer();
}

class _MainContainer extends State<MainContainer> {

  List<String> straight = ['Reta', 'Curva'];
  String? selectedStraight = 'Reta';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Controle PID',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
      Row(
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
          Icon(Icons.arrow_forward_rounded, color: Colors.green)
        ],
      ),

              ],
            ),
          ),
          const SizedBox(height: 25,),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(left: 15, right: 0),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                KpController(pista: selectedStraight),
                SizedBox(width: 15,),
                KdController(pista: selectedStraight),
                SizedBox(width: 15,),

              ],
            ),
          )
        ],
      ),
    );
  }



}

