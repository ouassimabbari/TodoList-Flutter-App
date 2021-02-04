import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo_list/api.dart';

class NewNote extends StatelessWidget {
  String userID;
  NewNote(String userID) {
    this.userID = userID;
  }
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'avenir'),
        home: newNote(this.userID),
      ),
      client: client,
    );
  }
}

class newNote extends StatefulWidget {
  String userID;
  newNote(String userID) {
    this.userID = userID;
  }
  @override
  _newNoteState createState() => _newNoteState();
}

class _newNoteState extends State<newNote> {
  final titleController = new TextEditingController();
  final descriptionController = new TextEditingController();
  String userID;
  double pinkBorder = 0;
  double blueBorder = 0;
  double greenBorder = 0;
  double yellowBorder = 0;
  double purpleBorder = 0;
  String theDate;
  String theTime;

  @override
  void initState() {
    super.initState();
    userID = widget.userID;
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat("yyyy-MM-dd");
    final timeFormat = DateFormat("HH:mm");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xfff96060),
        elevation: 0,
        title: Text(
          "Nouvelle Note",
          style: TextStyle(fontSize: 25),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePage(userID)));
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: 30,
              color: Color(0xfff96060),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  color: Colors.white),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.85,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Titre",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.grey.withOpacity(0.2),
                              child: TextField(
                                controller: titleController,
                                decoration: InputDecoration(
                                    hintText: "Titre",
                                    border: InputBorder.none),
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Description",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15)),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.5))),
                              child: TextField(
                                controller: descriptionController,
                                maxLines: 6,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Ajoutez une description ici",
                                ),
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15)),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.5))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.attach_file,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Choisissez la date",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            DateTimeField(
                              format: dateFormat,
                              onShowPicker: (context, currentValue) async {
                                final date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                                var dateArray = date.toString().split(" ");
                                var dateString = dateArray[0];
                                theDate = dateString;
                                return date;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Choisissez l'heure",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            DateTimeField(
                              format: timeFormat,
                              onShowPicker: (context, currentValue) async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      currentValue ?? DateTime.now()),
                                );
                                var timeArray = time.toString().split("(");
                                var newTimeArray = timeArray[1].split(")");
                                var timeStringArray =
                                    newTimeArray[0].split(":");
                                var hour = timeStringArray[0];
                                var minute = timeStringArray[1];
                                theTime = hour + "-" + minute + "-00";
                                return DateTimeField.convert(time);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Couleur",
                              style: TextStyle(fontSize: 18),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (blueBorder == 5) blueBorder = 0;
                                      if (greenBorder == 5) greenBorder = 0;
                                      if (yellowBorder == 5) yellowBorder = 0;
                                      if (purpleBorder == 5) purpleBorder = 0;
                                      pinkBorder == 0
                                          ? pinkBorder = 5
                                          : pinkBorder = 0;
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                            color: Colors.grey,
                                            width: pinkBorder),
                                        color: Colors.pink),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (greenBorder == 5) greenBorder = 0;
                                      if (pinkBorder == 5) pinkBorder = 0;
                                      if (yellowBorder == 5) yellowBorder = 0;
                                      if (purpleBorder == 5) purpleBorder = 0;
                                      blueBorder == 0
                                          ? blueBorder = 5
                                          : blueBorder = 0;
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey,
                                            width: blueBorder),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.blue),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (blueBorder == 5) blueBorder = 0;
                                      if (pinkBorder == 5) pinkBorder = 0;
                                      if (yellowBorder == 5) yellowBorder = 0;
                                      if (purpleBorder == 5) purpleBorder = 0;
                                      greenBorder == 0
                                          ? greenBorder = 5
                                          : greenBorder = 0;
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey,
                                            width: greenBorder),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.green),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (blueBorder == 5) blueBorder = 0;
                                      if (pinkBorder == 5) pinkBorder = 0;
                                      if (greenBorder == 5) greenBorder = 0;
                                      if (purpleBorder == 5) purpleBorder = 0;
                                      yellowBorder == 0
                                          ? yellowBorder = 5
                                          : yellowBorder = 0;
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey,
                                            width: yellowBorder),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Color(0xfff4ca8f)),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (blueBorder == 5) blueBorder = 0;
                                      if (pinkBorder == 5) pinkBorder = 0;
                                      if (yellowBorder == 5) yellowBorder = 0;
                                      if (greenBorder == 5) greenBorder = 0;
                                      purpleBorder == 0
                                          ? purpleBorder = 5
                                          : purpleBorder = 0;
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey,
                                            width: purpleBorder),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Color(0xff3d3a62)),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            InkWell(
                              onTap: createNote,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Color(0xffff96060)),
                                child: Center(
                                  child: Text(
                                    "Ajouter",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void createNote() async {
    print("Hi");
    GraphQLClient client = GraphQLProvider.of(context).value;
    final QueryResult note = await client.mutate(MutationOptions(
      document: gql(createNoteMutation),
      variables: {
        'title': titleController.text,
        'forDate': theDate + "-" + theTime,
        'description': descriptionController.text,
        'color': (pinkBorder == 5)
            ? "pink"
            : (blueBorder == 5)
                ? "blue"
                : (greenBorder == 5)
                    ? "green"
                    : (yellowBorder == 5)
                        ? "yellow"
                        : "purple",
        'userID': userID
      },
    ));
    if (note.data["addNote"]["title"] == titleController.text) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage(userID)));
    }
  }
}
