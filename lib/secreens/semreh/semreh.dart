import 'package:flutter/material.dart';
import 'package:line_follower_controller/colors.dart' as colors;
import 'package:line_follower_controller/widgets/main_container.dart';
import 'package:line_follower_controller/widgets/list_cards.dart';
import 'package:line_follower_controller/widgets/otp_input.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:line_follower_controller/widgets/arrow_with_spineer.dart';
import 'dart:typed_data';

class Semreh extends StatefulWidget {
  final BluetoothDevice server;

  const Semreh({required this.server});

  @override
  State<Semreh> createState() => _SemrehPageState();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _SemrehPageState extends State<Semreh> {
  List<String> straight = ['Reta', 'Curva'];
  String? selectedStraight = 'Reta';

  List<String> straightV = ['Reta', 'Curva', 'SM'];
  String? selectedStraightV = 'Reta';

  TextEditingController _fieldOne = TextEditingController(text: '0');
  TextEditingController _fieldTwo = TextEditingController(text: '0');
  TextEditingController _fieldThree = TextEditingController(text: '0');
  TextEditingController _fieldFour = TextEditingController(text: '0');
  TextEditingController _fieldFive = TextEditingController(text: '0');

  TextEditingController _fieldOneKd = TextEditingController(text: '0');
  TextEditingController _fieldTwoKd = TextEditingController(text: '0');
  TextEditingController _fieldThreeKd = TextEditingController(text: '0');
  TextEditingController _fieldFourKd = TextEditingController(text: '0');
  TextEditingController _fieldFiveKd = TextEditingController(text: '0');

  TextEditingController _fieldOneV = TextEditingController(text: '0');
  TextEditingController _fieldTwoV = TextEditingController(text: '0');
  TextEditingController _fieldThreeV = TextEditingController(text: '0');

  String kpRetaValor1 = '00000';
  String kpRetaValor2 = '00000';
  String kpCurvaValor1 = '00000';
  String kpCurvaValor2 = '00000';

  String kdRetaValor1 = '00000';
  String kdRetaValor2 = '00000';
  String kdCurvaValor1 = '00000';
  String kdCurvaValor2 = '00000';

  String vRetaValor1 = '000';
  String vRetaValor2 = '000';
  String vCurvaValor1 = '000';
  String vCurvaValor2 = '000';
  String vSemMapeamento1 = '000';
  String vSemMapeamento2 = '000';

  // This is the entered code
  // It will be displayed in a Text widget
  String? _otp = '000000';
  String? _otpKd = '000000';
  String? _otpV = '000000';

  List<String> values = ['VALOR 1', 'VALOR 2'];
  String? selectedItem = 'VALOR 1';

  List<String> valuesKd = ['VALOR 1', 'VALOR 2'];
  String? selectedItemKd = 'VALOR 1';

  List<String> valuesV = ['VALOR 1', 'VALOR 2'];
  String? selectedItemV = 'VALOR 1';

  // This is the entered code
  // It will be displayed in a Text widget

  static final clientID = 0;
  BluetoothConnection? connection = null;

  List<_Message> messages = <_Message>[];
  String _messageBuffer = '';

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => connection != null;

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection?.input.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final List<Row> list = messages.map((_message) {
    //   return Row(
    //     children: <Widget>[
    //       Container(
    //         child: Text(
    //                 (text) {
    //               return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
    //             }(_message.text.trim()),
    //             style: TextStyle(color: Colors.white)),
    //         padding: EdgeInsets.all(12.0),
    //         margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
    //         width: 222.0,
    //         decoration: BoxDecoration(
    //             color:
    //             _message.whom == clientID ? Colors.blueAccent : Colors.grey,
    //             borderRadius: BorderRadius.circular(7.0)),
    //       ),
    //     ],
    //     mainAxisAlignment: _message.whom == clientID
    //         ? MainAxisAlignment.end
    //         : MainAxisAlignment.start,
    //   );
    // }).toList();

    exibir(String valor, String variavel) {
      if (variavel == "kp") {
        _fieldOne = TextEditingController(text: valor[0]);
        _fieldTwo = TextEditingController(text: valor[1]);
        _fieldThree = TextEditingController(text: valor[2]);
        _fieldFour = TextEditingController(text: valor[3]);
        _fieldFive = TextEditingController(text: valor[4]);
      }
      if (variavel == "kd") {
        _fieldOneKd = TextEditingController(text: valor[0]);
        _fieldTwoKd = TextEditingController(text: valor[1]);
        _fieldThreeKd = TextEditingController(text: valor[2]);
        _fieldFourKd = TextEditingController(text: valor[3]);
        _fieldFiveKd = TextEditingController(text: valor[4]);
      }

      if (variavel == "v") {
        _fieldOneV = TextEditingController(text: valor[0]);
        _fieldTwoV = TextEditingController(text: valor[1]);
        _fieldThreeV = TextEditingController(text: valor[2]);
      }
    }

    if (selectedStraight == 'Reta') {
      // KP

      if (selectedItem == 'VALOR 1') {
        exibir(kpRetaValor1, "kp");
      }
      if (selectedItem == 'VALOR 2') {
        exibir(kpRetaValor2, "kp");
      }

      // KD

      if (selectedItemKd == 'VALOR 1') {
        exibir(kdRetaValor1, "kd");
      }
      if (selectedItemKd == 'VALOR 2') {
        exibir(kdRetaValor2, "kd");
      }
    }

    // VELOCIDADE

    if (selectedStraightV == 'Reta') {
      if (selectedItemV == 'VALOR 1') {
        exibir(vRetaValor1, "v");
      }
      if (selectedItemV == 'VALOR 2') {
        exibir(vRetaValor2, "v");
      }
    }

    if (selectedStraightV == 'Curva') {
      if (selectedItemV == 'VALOR 1') {
        exibir(vCurvaValor1, "v");
      }
      if (selectedItemV == 'VALOR 2') {
        exibir(vCurvaValor2, "v");
      }
    }

    if (selectedStraightV == 'S.M') {
      if (selectedItemV == 'VALOR 1') {
        exibir(vSemMapeamento1, "v");
      }
      if (selectedItemV == 'VALOR 2') {
        exibir(vSemMapeamento2, "v");
      }
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
          // title: const Text('SEMREH CONTROLLER'),
          title: (isConnecting
              ? Text('Conectando bluetooth - ' + widget.server.name + '...')
              : isConnected
                  ? Text('SEMREH CONTROLLER - ' + widget.server.name)
                  : Text('SEMREH CONTROLLER - ' + widget.server.name))),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              SizedBox(
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
                                padding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 15),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0XFF58D68D),
                                      colors.Colors.primaryColor
                                    ]),
                                    borderRadius: BorderRadius.circular(20)),
                                child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(12),
                                  dropdownColor: colors.Colors.primaryColor,
                                  value: selectedStraight,
                                  isExpanded: true,
                                  icon: const Icon(Icons.keyboard_arrow_down,
                                      color: Colors.white),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedStraight = newValue!;
                                    });
                                  },
                                  items: straight.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_forward_rounded,
                                  color: Colors.green)
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.only(left: 15, right: 0),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          Container(
                            width: 340,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                // Controle KP

                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color:
                                                    colors.Colors.contrastColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              'Kp',
                                              style: TextStyle(
                                                  color: colors
                                                      .Colors.primaryColor,
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            width: 174,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 0),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: colors
                                                      .Colors.primaryColor,
                                                  width: 2),
                                            ),
                                            child: DropdownButton<String>(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              value: selectedItem,
                                              isExpanded: true,
                                              icon: const Icon(
                                                  Icons.arrow_drop_down,
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
                                              items: values.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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

                                      //String kp = 'kp;${_otp!}';

                                      if (selectedStraight == 'Reta') {
                                        if (selectedItem == 'VALOR 1') {
                                          kpRetaValor1 = _otp!;
                                          _sendMessage('kpR;${kpRetaValor1!}');

                                          print(kpRetaValor1);
                                        }
                                        if (selectedItem == 'VALOR 2') {
                                          kpRetaValor2 = _otp!;
                                          _sendMessage('kpR;${kpRetaValor2!}');
                                          print(kpRetaValor2);
                                        }
                                      }
                                      if (selectedStraight == 'Curva') {
                                        if (selectedItem == 'VALOR 1') {
                                          kpCurvaValor1 = _otp!;
                                          _sendMessage('kpC;${kpCurvaValor1!}');
                                          print(kpCurvaValor1);
                                        }
                                        if (selectedItem == 'VALOR 2') {
                                          kpCurvaValor2 = _otp!;
                                          _sendMessage('kpC;${kpCurvaValor2!}');
                                          print(kpCurvaValor2);
                                        }
                                      }
                                      print('ENVIAR');
                                    });
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color:
                                                  colors.Colors.contrastColor)),
                                    ),
                                  ),
                                  child: const Text(
                                    'ENVIAR',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),

                          // Controle KD

                          Container(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: colors
                                                      .Colors.contrastColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                'Kd',
                                                style: TextStyle(
                                                    color: colors
                                                        .Colors.primaryColor,
                                                    fontSize: 35,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              width: 174,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 0),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: colors
                                                        .Colors.primaryColor,
                                                    width: 2),
                                              ),
                                              child: DropdownButton<String>(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                value: selectedItemKd,
                                                isExpanded: true,
                                                icon: const Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.green),
                                                style: const TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selectedItemKd = newValue!;
                                                  });
                                                },
                                                items: valuesKd.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      OtpInput(_fieldOneKd, true),
                                      Text('.',
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  colors.Colors.primaryColor)),
                                      OtpInput(_fieldTwoKd, false),
                                      OtpInput(_fieldThreeKd, false),
                                      OtpInput(_fieldFourKd, false),
                                      OtpInput(_fieldFiveKd, false),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  ElevatedButton(
                                    onPressed: () => {
                                      setState(() {
                                        _otpKd = _fieldOneKd.text +
                                            _fieldTwoKd.text +
                                            _fieldThreeKd.text +
                                            _fieldFourKd.text +
                                            _fieldFiveKd.text;

                                        //String kd = 'kd;${_otpKd!}';

                                        if (selectedStraight == 'Reta') {
                                          if (selectedItemKd == 'VALOR 1') {
                                            kdRetaValor1 = _otpKd!;
                                            _sendMessage(
                                                'kdR;${kdRetaValor1!}');
                                            print(kdRetaValor1);
                                          }
                                          if (selectedItemKd == 'VALOR 2') {
                                            kdRetaValor2 = _otpKd!;
                                            _sendMessage(
                                                'kdR;${kdRetaValor2!}');
                                            print(kdRetaValor2);
                                          }
                                        }
                                        if (selectedStraight == 'Curva') {
                                          if (selectedItemKd == 'VALOR 1') {
                                            kdCurvaValor1 = _otpKd!;
                                            _sendMessage(
                                                'kdC;${kdCurvaValor1!}');
                                            print(kdCurvaValor1);
                                          }
                                          if (selectedItemKd == 'VALOR 2') {
                                            kdCurvaValor2 = _otpKd!;
                                            _sendMessage(
                                                'kdC;${kdCurvaValor2!}');
                                            print(kdCurvaValor2);
                                          }
                                        }
                                        print('ENVIAR');
                                      })
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: colors
                                                    .Colors.contrastColor)),
                                      ),
                                    ),
                                    child: const Text(
                                      'ENVIAR',
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                ],
                              )),

                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
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
                          Row(
                            children: [
                              Container(
                                width: 110,
                                height: 35,
                                padding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 15),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0XFF58D68D),
                                      colors.Colors.primaryColor
                                    ]),
                                    borderRadius: BorderRadius.circular(20)),
                                child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(12),
                                  dropdownColor: colors.Colors.primaryColor,
                                  value: selectedStraightV,
                                  isExpanded: true,
                                  icon: const Icon(Icons.keyboard_arrow_down,
                                      color: Colors.white),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedStraightV = newValue!;
                                    });
                                  },
                                  items: straightV
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_forward_rounded,
                                  color: Colors.green),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          // VELOCIDADE

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color:
                                                    colors.Colors.contrastColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            padding: const EdgeInsets.all(10),
                                            child: Icon(
                                              Icons.flash_on_rounded,
                                              color: colors.Colors.primaryColor,
                                              size: 40,
                                            ),
                                          ),
                                          Container(
                                            width: 150,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 0),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: colors
                                                      .Colors.primaryColor,
                                                  width: 2),
                                            ),
                                            child: DropdownButton<String>(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              value: selectedItemV,
                                              isExpanded: true,
                                              icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.green),
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  selectedItemV = newValue!;
                                                });
                                              },
                                              items: valuesV.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    OtpInput(_fieldOneV, true),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    OtpInput(_fieldTwoV, false),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    OtpInput(_fieldThreeV, false),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _otpV = _fieldOneV.text +
                                          _fieldTwoV.text +
                                          _fieldThreeV.text;

                                      //String velocidade = 'v;${_otpV!}';

                                      if (selectedStraightV == 'Reta') {
                                        if (selectedItemV == 'VALOR 1') {
                                          vRetaValor1 = _otpV!;
                                          _sendMessage('vR;${vRetaValor1!}');
                                          print(vRetaValor1);
                                        }
                                        if (selectedItemV == 'VALOR 2') {
                                          vRetaValor2 = _otpV!;
                                          _sendMessage('vR;${vRetaValor2!}');
                                          print(vRetaValor2);
                                        }
                                      }
                                      if (selectedStraightV == 'Curva') {
                                        if (selectedItemV == 'VALOR 1') {
                                          vCurvaValor1 = _otpV!;
                                          _sendMessage('vC;${vCurvaValor1!}');
                                          print(vCurvaValor1);
                                        }
                                        if (selectedItemV == 'VALOR 2') {
                                          vCurvaValor2 = _otpV!;
                                          _sendMessage('vC;${vCurvaValor2!}');
                                          print(vCurvaValor2);
                                        }
                                      }

                                      if (selectedStraightV == 'S.M') {
                                        if (selectedItemV == 'VALOR 1') {
                                          vCurvaValor1 = _otpV!;
                                          _sendMessage('vSM;${vSemMapeamento1!}');
                                          print(vCurvaValor1);
                                        }
                                        if (selectedItemV == 'VALOR 2') {
                                          vCurvaValor2 = _otpV!;
                                          _sendMessage('vSM;${vSemMapeamento2!}');
                                          print(vCurvaValor2);
                                        }
                                      }

                                      print('ENVIAR');
                                  
                                    });
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color:
                                                  colors.Colors.contrastColor)),
                                    ),
                                  ),
                                  child: const Text(
                                    'ENVIAR',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            width: 15,
                          ),

                          Container(
                            width: 250,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Material(
                                elevation: 8,
                                shape: CircleBorder(),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: InkWell(
                                  splashColor: Colors.green,
                                  onTap: () {
                                    print('STOP');
                                    _sendMessage('s');
                                  },
                                  child: Ink.image(
                                    image: AssetImage('images/stop.png'),
                                    height: 180,
                                    width: 180,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            width: 15,
                          ),

                          Container(
                            width: 250,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Material(
                                elevation: 8,
                                shape: CircleBorder(),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: InkWell(
                                  splashColor: Colors.green,
                                  onTap: () {
                                    print('RESET');
                                    _sendMessage('r');
                                  },
                                  child: Ink.image(
                                    image: AssetImage('images/reset.png'),
                                    height: 180,
                                    width: 180,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();

    if (text.length > 0) {
      try {
        // connection.output.add(utf8.encode(text + "\r\n"));
        // await connection.output.allSent;

        List<int> list = text.codeUnits;
        Uint8List bytes = Uint8List.fromList(list);
        connection?.output.add(bytes);
        await connection?.output.allSent;

        setState(() {
          messages.add(_Message(clientID, text));
        });

        Future.delayed(Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }
}

// class InProgressSection extends StatelessWidget {
//   const InProgressSection({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 15, right: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Controle PID',
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                       color: colors.Colors.iconBackgroundColor,
//                       borderRadius: BorderRadius.circular(5)),
//                   padding: const EdgeInsets.all(10),
//                   child: Icon(
//                     Icons.flash_on_rounded,
//                     color: colors.Colors.accentColor,
//                     size: 40,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Text(
//                   'The Silent Night Vibes',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 25,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   '2/4 sessions left',
//                   style: TextStyle(
//                     color: colors.Colors.secondaryTextColor,
//                     fontWeight: FontWeight.normal,
//                     fontSize: 15,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '75%',
//                       style: TextStyle(
//                         color: colors.Colors.secondaryTextColor,
//                         fontWeight: FontWeight.normal,
//                         fontSize: 15,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     Expanded(
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(4),
//                         child: LinearProgressIndicator(
//                           value: 0.75,
//                           color: colors.Colors.accentColor,
//                           backgroundColor: colors.Colors.grayColor,
//                           minHeight: 10,
//                         ),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
