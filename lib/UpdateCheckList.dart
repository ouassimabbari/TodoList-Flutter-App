import 'package:flutter/material.dart';
import 'package:todo_list/api.dart';
import 'HomePage.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UpdateCheckList extends StatelessWidget {
  double pinkBorder;
  double blueBorder;
  double greenBorder;
  double yellowBorder;
  double purpleBorder;
  String title;
  bool isCompleted;
  String id;
  String date;
  String time;
  String color;
  String userID;
  UpdateCheckList(
      double pinkBorder,
      double blueBorder,
      double greenBorder,
      double yellowBorder,
      double purpleBorder,
      String title,
      bool isCompleted,
      String id,
      String date,
      String time,
      String color,
      String userID) {
    this.pinkBorder = pinkBorder;
    this.blueBorder = blueBorder;
    this.greenBorder = greenBorder;
    this.yellowBorder = yellowBorder;
    this.purpleBorder = purpleBorder;
    this.title = title;
    this.isCompleted = isCompleted;
    this.id = id;
    this.date = date;
    this.time = time;
    this.color = color;
    this.userID = userID;
  }
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'avenir'),
          home: updateCheckList(
            this.pinkBorder,
            this.blueBorder,
            this.greenBorder,
            this.yellowBorder,
            this.purpleBorder,
            this.title,
            this.isCompleted,
            this.id,
            this.date,
            this.time,
            this.color,
            this.userID,
          ),
        ),
        client: client);
  }
}

class updateCheckList extends StatefulWidget {
  double pinkBorder;
  double blueBorder;
  double greenBorder;
  double yellowBorder;
  double purpleBorder;
  String title;
  bool isCompleted;
  String id;
  String date;
  String time;
  String color;
  String userID;
  updateCheckList(
      double pinkBorder,
      double blueBorder,
      double greenBorder,
      double yellowBorder,
      double purpleBorder,
      String title,
      bool isCompleted,
      String id,
      String date,
      String time,
      String color,
      String userID) {
    this.pinkBorder = pinkBorder;
    this.blueBorder = blueBorder;
    this.greenBorder = greenBorder;
    this.yellowBorder = yellowBorder;
    this.purpleBorder = purpleBorder;
    this.title = title;
    this.isCompleted = isCompleted;
    this.id = id;
    this.date = date;
    this.time = time;
    this.color = color;
    this.userID = userID;
  }
  @override
  _updateCheckListState createState() => _updateCheckListState();
}

class _updateCheckListState extends State<updateCheckList> {
  final titreController = new TextEditingController();
  double pinkBorder;
  double blueBorder;
  double greenBorder;
  double yellowBorder;
  double purpleBorder;
  String title;
  bool isCompleted;
  String id;
  List<String> dateArray;
  List<String> timeArray;
  String color;
  String userID;
  int year;
  int month;
  int day;
  int hour;
  int minute;
  DateTime dateTime;
  String theDate;
  String theTime;
  @override
  void initState() {
    super.initState();
    pinkBorder = widget.pinkBorder;
    blueBorder = widget.blueBorder;
    greenBorder = widget.greenBorder;
    yellowBorder = widget.yellowBorder;
    purpleBorder = widget.purpleBorder;
    title = widget.title;
    titreController.text = title;
    isCompleted = widget.isCompleted;
    id = widget.id;
    dateArray = widget.date.split("-");
    timeArray = widget.time.split(":");
    color = widget.color;
    userID = widget.userID;
    year = int.parse(dateArray[0]);
    month = int.parse(dateArray[1]);
    day = int.parse(dateArray[2]);
    hour = int.parse(timeArray[0]);
    minute = int.parse(timeArray[1]);
    dateTime = new DateTime(year, month, day, hour, minute);
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
          "Modeifiez la todo",
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
                                controller: titreController,
                                decoration: InputDecoration(
                                    hintText: "Titre",
                                    border: InputBorder.none),
                                style: TextStyle(fontSize: 18),
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
                                var date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? dateTime,
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
                                      currentValue ?? dateTime),
                                );
                                var timeArray = time.toString().split("(");
                                var newTimeArray = timeArray[1].split(")");
                                var timeStringArray =
                                    newTimeArray[0].split(":");
                                var hour = timeStringArray[0];
                                var minute = timeStringArray[1];
                                theTime = hour + "-" + minute + "-00";
                                print(time.toString());
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
                              onTap: () async {
                                if (blueBorder == 5) color = "blue";
                                if (purpleBorder == 5) color = "purple";
                                if (yellowBorder == 5) color = "yellow";
                                if (greenBorder == 5) color = "green";
                                if (pinkBorder == 5) color = "pink";
                                print(id);
                                print(title);
                                print(theDate + "-" + theTime);
                                print(isCompleted);
                                print(color);
                                print(userID);
                                GraphQLClient client =
                                    GraphQLProvider.of(context).value;
                                var todo = await client.mutate(MutationOptions(
                                  document: gql(updateTodoMutation),
                                  variables: {
                                    'id': id,
                                    'title': titreController.text,
                                    'forDate': theDate + "-" + theTime,
                                    'isCompleted': isCompleted,
                                    'color': color,
                                    'userID': userID
                                  },
                                ));
                                if (todo != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomePage(userID)));
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Color(0xffff96060)),
                                child: Center(
                                  child: Text(
                                    "Enregistrer",
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
}
