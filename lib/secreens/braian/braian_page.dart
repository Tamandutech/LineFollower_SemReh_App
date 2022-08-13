import 'package:flutter/material.dart';

class BraianPage extends StatefulWidget {
  const BraianPage({Key? key}) : super(key: key);

  @override
  State<BraianPage> createState() => _BraianPageState();
}

class _BraianPageState extends State<BraianPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('EM DESENVOLVIMENTO 🛠️', style: TextStyle(color: Colors.red, fontSize: 25),),
            Image.network('https://img.icons8.com/external-flaticons-lineal-color-flat-icons/2x/external-programmer-mobile-app-development-flaticons-lineal-color-flat-icons-3.png', height: 530, ),

          ],
        ),
      ),
    );
  }
}
