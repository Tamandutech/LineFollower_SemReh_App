import 'package:flutter/material.dart';

class StopButton extends StatefulWidget {
  const StopButton({Key? key}) : super(key: key);


  @override
  State<StopButton> createState() => _StopButton();
}

class _StopButton extends State<StopButton> {



  @override
  Widget build(BuildContext context) {
    return Container(
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
    );

    // child: Ink.image(
    //   image: AssetImage('images/stop.png'),
    //   width: 100,
    //   height: 100,
    //   child: InkWell(
    //
    //   ),
    // ),
  }
}
