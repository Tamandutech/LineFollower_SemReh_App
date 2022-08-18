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
              // ------------ REFATORAR ----------------
              InkWell(
                highlightColor: Colors.green.withOpacity(0.5),
                splashColor: Colors.greenAccent,
                borderRadius: BorderRadius.all(Radius.circular(50)),
                onTap: () {
                  setState(() {
                    boxColor = Colors.green;
                    Future.delayed(Duration(seconds: 1), (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SemrehPage()));
                    });
                  }
                  );
                },
                child: Ink(
                  height: MediaQuery.of(context).size.height*0.22, // 180
                  width: MediaQuery.of(context).size.height*0.22, // 180
                  decoration: BoxDecoration(color: boxColor, borderRadius: BorderRadius.circular(30)),
                  child: Image(image: NetworkImage('https://img.icons8.com/3d-fluency/344/3d-fluency-blue-car.png')),
                ),
              ),
              InkWell(
                highlightColor: Colors.green.withOpacity(0.5),
                splashColor: Colors.greenAccent,
                borderRadius: BorderRadius.all(Radius.circular(50)),
                onTap: () {
                  setState(() {
                    boxColor = Colors.green;
                    Future.delayed(Duration(seconds: 1), (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BraianPage()));
                    });
                  });
                },
                child: Ink(
                  height: MediaQuery.of(context).size.height*0.22, // 180
                  width: MediaQuery.of(context).size.height*0.22, // 180
                  decoration: BoxDecoration(color: boxColor, borderRadius: BorderRadius.circular(30)),
                  child: Image(image: NetworkImage('https://img.icons8.com/emoji/344/oncoming-automobile.png')),
                ),
              ),
            ],
          )
      ),
    );
  }
}
