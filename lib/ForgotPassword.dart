import 'package:flutter/material.dart';
import 'package:todo_list/LoginPage.dart';

import 'ResetPassword.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "avenir",
      ),
      home: forgotPassword(),
    );
  }
}

class forgotPassword extends StatefulWidget {
  forgotPassword({Key key}) : super(key: key);

  @override
  _forgotPasswordState createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Mot de passe oublié",
              style: TextStyle(fontSize: 35),
            ),
            Text(
              "Veuillez saisir votre email pour recevoir votre code et réinitialiser le mot de passe",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Email",
              style: TextStyle(fontSize: 23),
            ),
            TextField(
              decoration: InputDecoration(hintText: "john@example.com"),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: InkWell(
                onTap: openResetPassword,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color: Color(0xfff96060)),
                  child: Text(
                    "Envoyer",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void openResetPassword() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ResetPassword()));
  }
}
