import 'package:flutter/material.dart';
import 'package:line_follower_controller/colors.dart' as colors;
import 'package:line_follower_controller/widgets/kd_controller.dart';
import 'package:line_follower_controller/widgets/pid_controller.dart';
import 'package:line_follower_controller/widgets/pid_spinner.dart';

class MainContainer extends StatelessWidget {
  MainContainer({Key? key}) : super(key: key);



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
                  "Controle PID",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
               PidSpinner(),

              ],
            ),
          ),
          const SizedBox(height: 25,),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(left: 15, right: 15),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                ContainerController(),
                SizedBox(width: 15,),
                KdController(),
                SizedBox(width: 15,),

              ],
            ),
          )
        ],
      ),
    );
  }
}

// class MainContainer extends StatefulWidget {
//   const MainContainer({Key? key}) : super(key: key);
//
//   @override
//   State<MainContainer> createState() => _MainContainerState();
// }
//
// class _MainContainerState extends State<MainContainer> {
//   List<String> straight = ['Reta', 'Curva'];
//   String? selectedStraight = 'Reta';
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Controle PID",
//               style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black),
//             ),
//             Row(
//               children: [
//                 Container(
//                   width: 110,
//                   height: 35,
//                   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
//                   decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                           colors: [Color(0XFF58D68D ), colors.Colors.primaryColor]),
//                       borderRadius: BorderRadius.circular(20)),
//                   child: DropdownButton<String>(
//                     borderRadius: BorderRadius.circular(12),
//                     dropdownColor: colors.Colors.primaryColor,
//                     value: selectedStraight,
//                     isExpanded: true,
//                     icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
//                     style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         selectedStraight = newValue!;
//                       });
//                     },
//                     items: straight.map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Icon(Icons.arrow_forward_rounded, color: Colors.green)
//               ],
//             ),
//
//           ],
//         ),
//         const SizedBox(
//           height: 30,
//         ),
//         ContainerController()
//       ],
//     );
//   }
// }
