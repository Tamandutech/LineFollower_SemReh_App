import 'package:flutter/material.dart';
import 'package:line_follower_controller/colors.dart' as colors;
import 'package:line_follower_controller/components/otp_input.dart';


class SemrehPage extends StatefulWidget {
  const SemrehPage({Key? key}) : super(key: key);

  @override
  State<SemrehPage> createState() => _SemrehPageState();
}

class _SemrehPageState extends State<SemrehPage> {
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();

  // This is the entered code
  // It will be displayed in a Text widget
  String? _otp;

  List<String> values = ['Valor 1', 'Valor 2', 'Valor 3'];
  String? selectedItem = 'Valor 1';
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text('SEMREH CONTROLLER'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            const SizedBox(
              height: 30,
            ),
            // Display the entered OTP code
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
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: colors.Colors.contrastColor,
                              borderRadius: BorderRadius.circular(5)),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Kp',
                            style: TextStyle(
                                color: colors.Colors.primaryColor,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OtpInput(_fieldOne, true),
                      Text('.',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      OtpInput(_fieldTwo, false),
                      OtpInput(_fieldThree, false),
                      OtpInput(_fieldFour, false),
                      OtpInput(_fieldFive, false),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _otp = _fieldOne.text +
                            _fieldTwo.text +
                            _fieldThree.text +
                            _fieldFour.text +
                            _fieldFive.text;
                      });
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ), // Implement 5 input fields
            ),

            InProgressSection(),
          ],
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
                    Icons.dark_mode_outlined,
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
