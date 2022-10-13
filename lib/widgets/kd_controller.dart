import 'package:flutter/material.dart';
import 'package:line_follower_controller/colors.dart' as colors;
import 'package:line_follower_controller/widgets/otp_input.dart';
import 'package:line_follower_controller/widgets/arrow_with_spineer.dart';

class KdController extends StatefulWidget {
  String? pista;

  KdController({Key? key, this.pista}) : super(key: key);

  @override
  State<KdController> createState() => _KdController();
}

class _KdController extends State<KdController> {
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();

  // This is the entered code
  // It will be displayed in a Text widget
  String? _otp;

  List<String> values = ['VALOR 1', 'VALOR 2', 'VALOR 3'];
  String? selectedItem = 'VALOR 1';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
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
                        child: Text(
                          'Kd',
                          style: TextStyle(
                              color: colors.Colors.primaryColor,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: 174,
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 0),
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
                  const SizedBox(
                    height: 20,
                  ),
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
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: colors.Colors.primaryColor)),
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
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: colors.Colors.contrastColor)),
                ),
              ),
              child: const Text(
                'ENVIAR',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ));
  }
}
