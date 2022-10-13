import 'package:flutter/material.dart';
import 'package:line_follower_controller/colors.dart' as colors;
import 'package:line_follower_controller/widgets/main_container.dart';
import 'package:line_follower_controller/widgets/list_cards.dart';

class SemrehPage extends StatefulWidget {
  const SemrehPage({Key? key}) : super(key: key);

  @override
  State<SemrehPage> createState() => _SemrehPageState();
}

class _SemrehPageState extends State<SemrehPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text('SEMREH CONTROLLER'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                height: 30,
              ),
              MainContainer(),
              SizedBox(
                height: 30,
              ),
              RecommendedSection(),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class InProgressSection extends StatelessWidget {
  const InProgressSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Controle PID',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
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
                    Icons.flash_on_rounded,
                    color: colors.Colors.accentColor,
                    size: 40,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'The Silent Night Vibes',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '2/4 sessions left',
                  style: TextStyle(
                    color: colors.Colors.secondaryTextColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '75%',
                      style: TextStyle(
                        color: colors.Colors.secondaryTextColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: 0.75,
                          color: colors.Colors.accentColor,
                          backgroundColor: colors.Colors.grayColor,
                          minHeight: 10,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
