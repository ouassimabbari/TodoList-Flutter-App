import 'package:flutter/material.dart';
import 'package:todo_list/UpdateCheckList.dart';
import 'package:todo_list/updateNote.dart';
import 'CheckList.dart';
import 'NewTask.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'NewNote.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo_list/api.dart';

class HomePage extends StatelessWidget {
  String userID;
  HomePage(String userID) {
    this.userID = userID;
  }
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'avenir'),
          home: homePage(userID),
        ),
        client: client);
  }
}

class homePage extends StatefulWidget {
  String userID;
  homePage(String userID) {
    this.userID = userID;
  }
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String userID;
  String forDate;
  int currentIndex;
  String filterType = "Aujourd'hui";
  DateTime today;
  String taskPop = "fermer";
  var monthNames = [
    "JAN",
    "FEV",
    "MARS",
    "AVR",
    "MAY",
    "JUIN",
    "JUL",
    "AOU",
    "SEPT",
    "OCT",
    "NOV",
    "DEC"
  ];
  CalendarController ctrlr = new CalendarController();

  @override
  void initState() {
    super.initState();
    today = new DateTime.now();

    currentIndex = 0;
    forDate = today.year.toString() +
        "-" +
        (today.month).toString() +
        "-" +
        today.day.toString();
    print(forDate);
    userID = widget.userID;
    print(userID);
  }

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
            document: (currentIndex == 0)
                ? gql(getTodosByDateAndUserQuery)
                : gql(getNotesByDateAndUserQuery),
            pollInterval: Duration(milliseconds: 1000),
            variables: {
              "userID": userID,
              "forDate": today.year.toString() +
                  "-" +
                  (today.month).toString() +
                  "-" +
                  today.day.toString()
            }),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          return result.hasException
              ? Text(result.exception.toString())
              : result.isLoading
                  ? loadingPage()
                  : Scaffold(
                      floatingActionButton: FloatingActionButton(
                        onPressed: openTaskPop,
                        child: Icon(Icons.add),
                        backgroundColor: Colors.red,
                      ),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.endDocked,
                      bottomNavigationBar: BubbleBottomBar(
                        opacity: 0.2,
                        backgroundColor: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.0),
                        ),
                        currentIndex: currentIndex,
                        hasInk: true,
                        inkColor: Colors.black12,
                        hasNotch: true,
                        fabLocation: BubbleBottomBarFabLocation.end,
                        onTap: changePage,
                        items: [
                          BubbleBottomBarItem(
                            backgroundColor: (currentIndex == 0)
                                ? Colors.red
                                : Colors.indigo,
                            icon: Icon(
                              Icons.check_circle,
                              color: Colors.black,
                            ),
                            activeIcon: Icon(
                              Icons.check_circle,
                              color: (currentIndex == 0)
                                  ? Colors.red
                                  : Colors.indigo,
                            ),
                            title: Text('Todos'),
                          ),
                          BubbleBottomBarItem(
                            backgroundColor: (currentIndex == 1)
                                ? Colors.red
                                : Colors.indigo,
                            icon: Icon(
                              Icons.folder_open,
                              color: Colors.black,
                            ),
                            activeIcon: Icon(
                              Icons.folder_open,
                              color: (currentIndex == 1)
                                  ? Colors.red
                                  : Colors.indigo,
                            ),
                            title: Text('Notes'),
                          ),
                          BubbleBottomBarItem(
                            backgroundColor: Colors.deepPurple,
                            icon: Icon(
                              IconData(0xe8c4, fontFamily: 'MaterialIcons'),
                              color: Colors.black,
                            ),
                            activeIcon: Icon(
                              IconData(0xe8c4, fontFamily: 'MaterialIcons'),
                              color: Colors.deepPurple,
                            ),
                            title: Text('Taches'),
                          ),
                        ],
                      ),
                      body: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppBar(
                                backgroundColor: Color(0xfff96060),
                                elevation: 0,
                                title: Text(
                                  (currentIndex == 0) ? "Todos" : "Notes",
                                  style: TextStyle(fontSize: 30),
                                ),
                                actions: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      (currentIndex == 0)
                                          ? Icons.check_circle
                                          : Icons.folder_open,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                height: 70,
                                color: Color(0xfff96060),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            changeFilter("Aujourd'hui");
                                          },
                                          child: Text(
                                            "Aujourd'hui",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 4,
                                          width: 120,
                                          color: (filterType == "Aujourd'hui")
                                              ? Colors.white
                                              : Colors.transparent,
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            changeFilter("mois");
                                          },
                                          child: Text(
                                            "Mois",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 4,
                                          width: 120,
                                          color: (filterType == "mois")
                                              ? Colors.white
                                              : Colors.transparent,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              (filterType == "mois")
                                  ? TableCalendar(
                                      calendarController: ctrlr,
                                      startingDayOfWeek:
                                          StartingDayOfWeek.monday,
                                      initialCalendarFormat:
                                          CalendarFormat.week,
                                      locale: 'fr_FR',
                                    )
                                  : Container(),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Aujourd'hui ${monthNames[today.month - 1]}, ${today.day}/${today.year}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey),
                                          )
                                        ],
                                      ),
                                    ),
                                    (currentIndex == 0)
                                        ? (result.data["todosByDayAndUser"] ==
                                                null)
                                            ? Text("Pas de todos aujourd'hui")
                                            : ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: result
                                                    .data["todosByDayAndUser"]
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  var forDateArray = result
                                                      .data["todosByDayAndUser"]
                                                          [index]["forDate"]
                                                      .toString()
                                                      .split("T");
                                                  var timeArray =
                                                      forDateArray[1]
                                                          .split(":");
                                                  var timeString =
                                                      timeArray[0] +
                                                          ":" +
                                                          timeArray[1];
                                                  print(timeString);
                                                  print(result
                                                      .data["todosByDayAndUser"]
                                                          [index]["forDate"]
                                                      .toString());
                                                  var color = (result.data["todosByDayAndUser"]
                                                                  [index]
                                                              ["color"] ==
                                                          "pink")
                                                      ? Color(0xfff96060)
                                                      : (result.data["todosByDayAndUser"]
                                                                      [index]
                                                                  ["color"] ==
                                                              "blue")
                                                          ? Colors.blue
                                                          : (result.data["todosByDayAndUser"]
                                                                          [index]
                                                                      [
                                                                      "color"] ==
                                                                  "green")
                                                              ? Colors.green
                                                              : (result.data["todosByDayAndUser"]
                                                                              [index]
                                                                          ["color"] ==
                                                                      "yellow")
                                                                  ? Color(0xfff4ca8f)
                                                                  : Color(0xff3d3a62);
                                                  return taskWidget(
                                                      color,
                                                      result.data[
                                                              "todosByDayAndUser"]
                                                          [index]["title"],
                                                      timeString,
                                                      result.data[
                                                              "todosByDayAndUser"]
                                                          [
                                                          index]["isCompleted"],
                                                      result.data[
                                                              "todosByDayAndUser"]
                                                          [index]["id"],
                                                      forDateArray[0]);
                                                })
                                        : (result.data["notesByDayAndUser"] ==
                                                null)
                                            ? Text("Pas de notes aujourd'hui")
                                            : ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: result
                                                    .data["notesByDayAndUser"]
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  var forDateArray = result
                                                      .data["notesByDayAndUser"]
                                                          [index]["forDate"]
                                                      .toString()
                                                      .split("T");
                                                  var timeArray =
                                                      forDateArray[1]
                                                          .split(":");
                                                  var timeString =
                                                      timeArray[0] +
                                                          ":" +
                                                          timeArray[1];
                                                  print(timeString);
                                                  print(result
                                                      .data["notesByDayAndUser"]
                                                          [index]["forDate"]
                                                      .toString());
                                                  var color = (result.data["notesByDayAndUser"]
                                                                  [index]
                                                              ["color"] ==
                                                          "pink")
                                                      ? Color(0xfff96060)
                                                      : (result.data["notesByDayAndUser"]
                                                                      [index]
                                                                  ["color"] ==
                                                              "blue")
                                                          ? Colors.blue
                                                          : (result.data["notesByDayAndUser"]
                                                                          [index]
                                                                      [
                                                                      "color"] ==
                                                                  "green")
                                                              ? Colors.green
                                                              : (result.data["notesByDayAndUser"]
                                                                              [index]
                                                                          ["color"] ==
                                                                      "yellow")
                                                                  ? Color(0xfff4ca8f)
                                                                  : Color(0xff3d3a62);
                                                  return noteWidget(
                                                      color,
                                                      result.data[
                                                              "notesByDayAndUser"]
                                                          [index]["title"],
                                                      timeString,
                                                      result.data[
                                                              "notesByDayAndUser"]
                                                          [
                                                          index]["description"],
                                                      result.data[
                                                              "notesByDayAndUser"]
                                                          [index]["id"],
                                                      forDateArray[0]);
                                                }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: (taskPop == "open")
                                ? InkWell(
                                    onTap: closeTaskPop,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.black.withOpacity(0.3),
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: Colors.white),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                height: 1,
                                              ),
                                              InkWell(
                                                onTap: openNewTask,
                                                child: Container(
                                                  child: Text(
                                                    "Ajouter une Tache",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 1,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 30),
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                              ),
                                              InkWell(
                                                onTap: openNewNote,
                                                child: Container(
                                                  child: Text(
                                                    "Ajouter une Note",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 1,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 30),
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                              ),
                                              InkWell(
                                                onTap: openNewCheckList,
                                                child: Container(
                                                  child: Text(
                                                    "Ajouter une Todo",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          )
                        ],
                      ),
                    );
        });
  }

  Scaffold loadingPage() {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: openTaskPop,
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BubbleBottomBar(
          opacity: 0.2,
          backgroundColor: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0),
          ),
          currentIndex: currentIndex,
          hasInk: true,
          inkColor: Colors.black12,
          hasNotch: true,
          fabLocation: BubbleBottomBarFabLocation.end,
          onTap: changePage,
          items: [
            BubbleBottomBarItem(
              backgroundColor: (currentIndex == 0) ? Colors.red : Colors.indigo,
              icon: Icon(
                Icons.check_circle,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.check_circle,
                color: (currentIndex == 0) ? Colors.red : Colors.indigo,
              ),
              title: Text('Todos'),
            ),
            BubbleBottomBarItem(
              backgroundColor: (currentIndex == 1) ? Colors.red : Colors.indigo,
              icon: Icon(
                Icons.folder_open,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.folder_open,
                color: (currentIndex == 1) ? Colors.red : Colors.indigo,
              ),
              title: Text('Notes'),
            ),
            BubbleBottomBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(
                IconData(0xe8c4, fontFamily: 'MaterialIcons'),
                color: Colors.black,
              ),
              activeIcon: Icon(
                IconData(0xe8c4, fontFamily: 'MaterialIcons'),
                color: Colors.deepPurple,
              ),
              title: Text('Taches'),
            ),
          ],
        ),
        body: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AppBar(
              backgroundColor: Color(0xfff96060),
              elevation: 0,
              title: Text(
                (currentIndex == 0) ? "Todos" : "Notes",
                style: TextStyle(fontSize: 30),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    (currentIndex == 0)
                        ? Icons.check_circle
                        : Icons.folder_open,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              ],
            ),
            Container(
              height: 70,
              color: Color(0xfff96060),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          changeFilter("Aujourd'hui");
                        },
                        child: Text(
                          "Aujourd'hui",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 4,
                        width: 120,
                        color: (filterType == "Aujourd'hui")
                            ? Colors.white
                            : Colors.transparent,
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          changeFilter("mois");
                        },
                        child: Text(
                          "Mois",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 4,
                        width: 120,
                        color: (filterType == "mois")
                            ? Colors.white
                            : Colors.transparent,
                      )
                    ],
                  )
                ],
              ),
            ),
            (filterType == "mois")
                ? TableCalendar(
                    calendarController: ctrlr,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    initialCalendarFormat: CalendarFormat.week,
                    locale: 'fr_FR',
                  )
                : Container(),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Aujourd'hui ${monthNames[today.month - 1]}, ${today.day}/${today.year}",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        CircularProgressIndicator()
                      ],
                    ),
                  ),
                ]))
          ])
        ]));
  }

  changePage(int index) {
    if (index != 2) {
      setState(() {
        print(index);
        currentIndex = index;
      });
    }
  }

  openTaskPop() {
    taskPop = "open";
    setState(() {});
  }

  closeTaskPop() {
    taskPop = "close";
    setState(() {});
  }

  changeFilter(String filter) {
    filterType = filter;
    setState(() {});
  }

  Slidable taskWidget(Color color, String title, String time, bool isCompleted,
      String id, String date) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.3,
      child: InkWell(
        onTap: () async {
          var theColor;
          var timeArray = time.split(":");
          if (color == Color(0xfff96060)) {
            theColor = "pink";
          }
          if (color == Colors.blue) {
            theColor = "blue";
          }
          if (color == Colors.green) {
            theColor = "green";
          }
          if (color == Color(0xfff4ca8f)) {
            theColor = "yellow";
          }
          if (color == Color(0xff3d3a62)) {
            theColor = "purple";
          }
          bool theIsCompleted;
          if (isCompleted) {
            theIsCompleted = false;
          } else {
            theIsCompleted = true;
          }
          setState(() {
            isCompleted = theIsCompleted;
          });
          GraphQLClient client = GraphQLProvider.of(context).value;
          await client.mutate(MutationOptions(
            document: gql(updateTodoMutation),
            variables: {
              'id': id,
              'title': title,
              'forDate': date + "-" + timeArray[0] + "-" + timeArray[1] + "-00",
              'isCompleted': theIsCompleted,
              'color': theColor,
              'userID': userID
            },
          ));
        },
        child: Container(
          height: 80,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.03),
                offset: Offset(0, 9),
                blurRadius: 20,
                spreadRadius: 1)
          ]),
          child: Row(
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: color, width: 4)),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: isCompleted
                          ? Center(
                              child: Icon(
                                Icons.check,
                                color: color,
                              ),
                            )
                          : Container())
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Text(
                    time,
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  )
                ],
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                height: 50,
                width: 5,
                color: color,
              )
            ],
          ),
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          caption: "Modifier",
          color: Colors.white,
          icon: Icons.edit,
          onTap: () {
            var theColor;
            double pinkBorder;
            double blueBorder;
            double purpleBorder;
            double yellowBorder;
            double greenBorder;
            if (color == Color(0xfff96060)) {
              theColor = "pink";
              pinkBorder = 5;
              blueBorder = 0;
              purpleBorder = 0;
              yellowBorder = 0;
              greenBorder = 0;
            }
            if (color == Colors.blue) {
              theColor = "blue";
              pinkBorder = 0;
              blueBorder = 5;
              purpleBorder = 0;
              yellowBorder = 0;
              greenBorder = 0;
            }
            if (color == Colors.green) {
              theColor = "green";
              pinkBorder = 0;
              blueBorder = 0;
              purpleBorder = 0;
              yellowBorder = 0;
              greenBorder = 5;
            }
            if (color == Color(0xfff4ca8f)) {
              theColor = "yellow";
              pinkBorder = 0;
              blueBorder = 0;
              purpleBorder = 0;
              yellowBorder = 5;
              greenBorder = 0;
            }
            if (color == Color(0xff3d3a62)) {
              theColor = "purple";
              pinkBorder = 0;
              blueBorder = 0;
              purpleBorder = 5;
              yellowBorder = 0;
              greenBorder = 0;
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateCheckList(
                        pinkBorder,
                        blueBorder,
                        greenBorder,
                        yellowBorder,
                        purpleBorder,
                        title,
                        isCompleted,
                        id,
                        date,
                        time,
                        theColor,
                        userID)));
          },
        ),
        IconSlideAction(
          caption: "Supprimer",
          color: color,
          icon: Icons.delete,
          onTap: () async {
            GraphQLClient client = GraphQLProvider.of(context).value;
            await client.mutate(MutationOptions(
              document: gql(deleteTodoMutation),
              variables: {
                'id': id,
              },
            ));
          },
        )
      ],
    );
  }

  Slidable noteWidget(Color color, String title, String time,
      String description, String id, String date) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.3,
      child: InkWell(
        onTap: () async {
          var theColor;
          var timeArray = time.split(":");
          if (color == Color(0xfff96060)) {
            theColor = "pink";
          }
          if (color == Colors.blue) {
            theColor = "blue";
          }
          if (color == Colors.green) {
            theColor = "green";
          }
          if (color == Color(0xfff4ca8f)) {
            theColor = "yellow";
          }
          if (color == Color(0xff3d3a62)) {
            theColor = "purple";
          }
        },
        child: Container(
          height: 80,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.03),
                offset: Offset(0, 9),
                blurRadius: 20,
                spreadRadius: 1)
          ]),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    time,
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  )
                ],
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                height: 50,
                width: 5,
                color: color,
              )
            ],
          ),
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          caption: "Modifier",
          color: Colors.white,
          icon: Icons.edit,
          onTap: () {
            var theColor;
            double pinkBorder;
            double blueBorder;
            double purpleBorder;
            double yellowBorder;
            double greenBorder;
            if (color == Color(0xfff96060)) {
              theColor = "pink";
              pinkBorder = 5;
              blueBorder = 0;
              purpleBorder = 0;
              yellowBorder = 0;
              greenBorder = 0;
            }
            if (color == Colors.blue) {
              theColor = "blue";
              pinkBorder = 0;
              blueBorder = 5;
              purpleBorder = 0;
              yellowBorder = 0;
              greenBorder = 0;
            }
            if (color == Colors.green) {
              theColor = "green";
              pinkBorder = 0;
              blueBorder = 0;
              purpleBorder = 0;
              yellowBorder = 0;
              greenBorder = 5;
            }
            if (color == Color(0xfff4ca8f)) {
              theColor = "yellow";
              pinkBorder = 0;
              blueBorder = 0;
              purpleBorder = 0;
              yellowBorder = 5;
              greenBorder = 0;
            }
            if (color == Color(0xff3d3a62)) {
              theColor = "purple";
              pinkBorder = 0;
              blueBorder = 0;
              purpleBorder = 5;
              yellowBorder = 0;
              greenBorder = 0;
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateNote(
                        pinkBorder,
                        blueBorder,
                        greenBorder,
                        yellowBorder,
                        purpleBorder,
                        title,
                        description,
                        id,
                        date,
                        time,
                        theColor,
                        userID)));
          },
        ),
        IconSlideAction(
          caption: "Supprimer",
          color: color,
          icon: Icons.delete,
          onTap: () async {
            GraphQLClient client = GraphQLProvider.of(context).value;
            await client.mutate(MutationOptions(
              document: gql(deleteNoteMutation),
              variables: {
                'id': id,
              },
            ));
          },
        )
      ],
    );
  }

  openNewTask() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewTask(userID)));
  }

  openNewNote() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewNote(userID)));
  }

  openNewCheckList() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CheckList(userID)));
  }
}
