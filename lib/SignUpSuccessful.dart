import 'package:flutter/material.dart';
import 'package:todo_list/LoginPage.dart';

class SignUpSuccessful extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'avenir'),
      home: signUpSuccessful(),
    );
  }
}

class signUpSuccessful extends StatefulWidget {
  @override
  _signUpSuccessfulState createState() => _signUpSuccessfulState();
}

class _signUpSuccessfulState extends State<signUpSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/success.png"))),
          ),
          Text(
            "Succés!",
            style: TextStyle(fontSize: 35),
          ),
          Text(
            "Votre compte a été crée avec succés. Veuillez vous connecter!",
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 70,
          ),
          Center(
            child: InkWell(
              onTap: openLoginPage,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    color: Color(0xfff96060)),
                child: Text(
                  "Continuer",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openLoginPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
