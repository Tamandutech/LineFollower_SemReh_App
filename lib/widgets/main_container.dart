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
                  'Controle PID',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
               PidSpinner(),

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

