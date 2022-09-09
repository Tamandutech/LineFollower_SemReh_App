import 'package:flutter/material.dart';
import 'package:line_follower_controller/secreens/braian/braian_page.dart';
import 'package:line_follower_controller/secreens/semreh/semreh_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color boxColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image(image: AssetImage('images/logo_tamandutech.png')),
        title: Text('TAMANDUTECH'),
      ),
      body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Material(
                color: Colors.green[300],
                elevation: 10,
                borderRadius: BorderRadius.all(Radius.circular(40)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  splashColor: Colors.greenAccent,
                  onTap: () {
                    Future.delayed(Duration(milliseconds: 500), (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SemrehPage()));
                    });
                  },
                  child: Ink.image(
                    image: AssetImage('images/semreh.png'),
                    height: 180,
                    width: 180,
                  ),
                ),
              ),
              // ------------ REFATORAR ----------------
              Material(
                color: Colors.green[300],
                elevation: 10,
                borderRadius: BorderRadius.all(Radius.circular(40)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  splashColor: Colors.greenAccent,
                  onTap: () {
                    Future.delayed(Duration(milliseconds: 500), (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BraianPage()));
                    });
                  },
                  child: Ink.image(
                    image: AssetImage('images/braia.png'),
                    height: 180,
                    width: 180,
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
