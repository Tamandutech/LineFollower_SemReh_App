import 'package:flutter/material.dart';
import 'package:line_follower_controller/colors.dart' as colors;
import 'package:line_follower_controller/widgets/otp_input.dart';

class SpeedController extends StatefulWidget {
  const SpeedController({Key? key}) : super(key: key);

  @override
  State<SpeedController> createState() => _SpeedController();
}

class _SpeedController extends State<SpeedController> {
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();


  // This is the entered code
  // It will be displayed in a Text widget
  String? _otp;

  List<String> values = ['VALOR 1', 'VALOR 2', 'VALOR 3'];
  String? selectedItem = 'VALOR 1';

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: colors.Colors.contrastColor,
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.flash_on_rounded,
                          color: colors.Colors.primaryColor,
                          size: 40,
                        ),
                      ),
                      Container(
                        width: 150,
                        margin:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: colors.Colors.primaryColor, width: 2),
                        ),
                        child: DropdownButton<String>(
                          borderRadius: BorderRadius.circular(12),
                          value: selectedItem,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.green),
                          style: const TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedItem = newValue!;
                            });
                          },
                          items: values
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OtpInput(_fieldOne, true),
                const SizedBox(
                  width: 10,
                ),
                OtpInput(_fieldTwo, false),
                const SizedBox(
                  width: 10,
                ),
                OtpInput(_fieldThree, false),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _otp = _fieldOne.text +
                      _fieldTwo.text +
                      _fieldThree.text;

                });
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: colors.Colors.contrastColor)),
                ),
              ),
              child: const Text(
                'ENVIAR',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ));
  }
}
