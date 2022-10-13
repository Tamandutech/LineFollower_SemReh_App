import 'package:flutter/material.dart';
import 'package:line_follower_controller/colors.dart' as colors;
import 'package:line_follower_controller/widgets/speed_controller.dart';
import 'package:line_follower_controller/widgets/stop_button.dart';
import 'package:line_follower_controller/widgets/reset_button.dart';
import 'package:line_follower_controller/widgets/arrow_with_spineer.dart';

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  'Velocidade',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                ArrowSpinner(),
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
                SpeedController(),


                SizedBox(width: 15,),
                StopButton(),
                SizedBox(width: 15,),
                ResetButton(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RecommendedItemCard extends StatelessWidget {
  const RecommendedItemCard({Key? key, required this.title, required this.session, required this.iconData}) : super(key: key);

  final String title;
  final String session;
  final IconData iconData;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: colors.Colors.iconBackgroundColor,
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(10),
            child: Icon(
              iconData,
              color: colors.Colors.accentColor,
              size: 40,
            ),
          ),
          const SizedBox(height: 20,),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 20,),
          Text(
            '$session sessions',
            style: TextStyle(
              color: colors.Colors.secondaryTextColor,
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}