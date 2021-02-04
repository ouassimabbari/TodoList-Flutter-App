import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo_list/HomePage.dart';
import 'package:todo_list/api.dart';
import 'package:todo_list/onBoarding.dart';
import 'ForgotPassword.dart';
import 'SignUp.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'avenir'),
        home: loginPage(),
      ),
      client: client,
    );
  }
}

class loginPage extends StatefulWidget {
  loginPage({Key key}) : super(key: key);

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoginSuccessful = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                .push(MaterialPageRoute(builder: (context) => OnBoarding()));
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Bienvenue à nouveau!",
              style: TextStyle(fontSize: 35),
            ),
            Text(
              "Connectez-vous pour continuer...",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            !isLoginSuccessful
                ? SizedBox(
                    height: 20,
                    child: Text(
                      "Email ou mot de passe incorrecte",
                      style: TextStyle(fontSize: 16, color: Color(0xfff96060)),
                    ))
                : SizedBox(
                    height: 20,
                  ),
            Text(
              "Email",
              style: TextStyle(fontSize: 23),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: "JohnDoe@example.com",
                  errorText: validateEmail(emailController.text)),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Mot de passe",
              style: TextStyle(fontSize: 23),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: "Saisissez votre mot de passe ici...",
                  errorText: validatePassword(passwordController.text)),
              obscureText: true,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: openForgotPassword,
                  child: Text(
                    "Mot de passe oublié?",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: login,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 130, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color: Color(0xfff96060)),
                  child: Text(
                    "Connexion",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Vous n'avez pas de compte?",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                InkWell(
                  onTap: openSignUp,
                  child: Container(
                    padding: EdgeInsets.only(right: 12),
                    child: Text(
                      "Inscrivez-vous",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xfff96060),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String validatePassword(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "Password should contain more than 5 characters";
    }
    return null;
  }

  String validateEmail(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "Password should contain more than 5 characters";
    }
    return null;
  }

  void openForgotPassword() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ForgotPassword()));
  }

  void openSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignUp()));
  }

  void login() async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    final QueryResult user = await client.query(
      QueryOptions(
          document: gql(getUserByEmailQuery),
          pollInterval: Duration(milliseconds: 2000),
          variables: {
            'email': emailController.text,
          }),
    );
    if (user == null ||
        user.data["userByEmail"]["password"] != passwordController.text) {
      setState(() {
        isLoginSuccessful = false;
      });
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(user.data["userByEmail"]["id"])));
    }
  }
}
