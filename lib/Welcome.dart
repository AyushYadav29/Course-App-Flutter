import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [Colors.blue, Colors.cyan],
          ),
          image: DecorationImage(
              image: AssetImage('assets/images/bg card.png'),
              alignment: Alignment.bottomCenter),
        ),
        child: Center(
          child:  Text(
                "To join the Course please click on the link : \n https://meet.google.com/cif-udba-ajv",
                
            style: TextStyle(color: Colors.white, fontSize: 20),
                ),
          ),
        );
  }
}
