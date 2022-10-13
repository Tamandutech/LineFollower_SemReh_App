

import 'package:flutter/material.dart';
import 'package:line_follower_controller/colors.dart' as colors;
import 'package:line_follower_controller/widgets/otp_input.dart';

class KpController extends StatefulWidget {
  String? pista;

  KpController({Key? key, this.pista}) : super(key: key);

  @override
  State<KpController> createState() => _ContainerControllerState();
}

class _ContainerControllerState extends State<KpController> {
  TextEditingController _fieldOne = TextEditingController(text: '0');
  TextEditingController _fieldTwo = TextEditingController(text: '0');
  TextEditingController _fieldThree = TextEditingController(text: '0');
  TextEditingController _fieldFour = TextEditingController(text: '0');
  TextEditingController _fieldFive = TextEditingController(text: '0');

  String kpRetaValor1 = '00000';
  String kpRetaValor2 = '00000';
  String kpCurvaValor1 = '00000';
  String kpCurvaValor2 = '00000';

  // This is the entered code
  // It will be displayed in a Text widget
  String? _otp = '000000';

  List<String> values = ['VALOR 1', 'VALOR 2'];
  String? selectedItem = 'VALOR 1';



  @override
  Widget build(BuildContext context) {

    exibirValor(String valor) {
      _fieldOne = TextEditingController(text: valor[0]);
      _fieldTwo = TextEditingController(text: valor[1]);
      _fieldThree = TextEditingController(text: valor[2]);
      _fieldFour = TextEditingController(text: valor[3]);
      _fieldFive = TextEditingController(text: valor[4]);
    }

    if (widget.pista == 'Reta') {
      if (selectedItem == 'VALOR 1') {
        exibirValor(kpRetaValor1);
      }
      if (selectedItem == 'VALOR 2'){
        exibirValor(kpRetaValor2);
      }
    }
    if (widget.pista == 'Curva') {
      if (selectedItem == 'VALOR 1') {
        exibirValor(kpCurvaValor1);
      } else {
        exibirValor(kpCurvaValor2);
      }
    }

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
                          'Kp',
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

                  if (widget.pista == 'Reta') {
                    if (selectedItem == 'VALOR 1') {
                      kpRetaValor1 = _otp!;
                      print(kpRetaValor1);
                    }
                    if (selectedItem == 'VALOR 2'){
                      kpRetaValor2 = _otp!;
                      print(kpRetaValor2);
                    }
                  }
                  if (widget.pista == 'Curva') {
                    if (selectedItem == 'VALOR 1') {
                      kpCurvaValor1 = _otp!;
                      print(kpCurvaValor1);
                    }
                    if (selectedItem == 'VALOR 2') {
                      kpCurvaValor2 = _otp!;
                      print(kpCurvaValor2);
                    }
                  }
                  print('ENVIAR');
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
