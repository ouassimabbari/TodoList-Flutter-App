import 'package:flutter/material.dart';
import 'package:todo_list/LoginPage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo_list/api.dart';
import 'SignUpSuccessful.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'avenir',
        ),
        home: signUp(),
      ),
      client: client,
    );
  }
}

class signUp extends StatefulWidget {
  signUp({Key key}) : super(key: key);

  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
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
        child: ListView(
          children: [
            Text(
              "Bienvenue!",
              style: TextStyle(fontSize: 35),
            ),
            Text(
              "Inscrivez-vous pour continuer...",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Nom",
              style: TextStyle(fontSize: 23),
            ),
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(hintText: "Nom"),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Prénom",
              style: TextStyle(fontSize: 23),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(hintText: "Prénom"),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Email",
              style: TextStyle(fontSize: 23),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: "JohnDoe@example.com"),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Mot de passe",
              style: TextStyle(fontSize: 23),
            ),
            TextField(
              controller: passwordController,
              decoration:
                  InputDecoration(hintText: "Saisissez votre mot de passe ici"),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: signUp,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color: Color(0xfff96060)),
                  child: Text(
                    "Créez votre compte",
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
                Text(
                  "Vous avez déja un compte?",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                InkWell(
                  onTap: openSignIn,
                  child: Text(
                    "Connexion",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xfff96060),
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

  void signUp() async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    final QueryResult user = await client.mutate(MutationOptions(
      document: gql(createUserMutation),
      variables: {
        'email': emailController.text,
        'password': passwordController.text,
        'lastName': lastNameController.text,
        'firstName': firstNameController.text
      },
    ));
    if (user.data["addUser"]["firstName"] == firstNameController.text) {
      openSuccess();
    }
  }

  void openSignIn() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void openSuccess() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignUpSuccessful()));
  }
}
