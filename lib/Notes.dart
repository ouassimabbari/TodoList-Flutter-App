import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo_list/api.dart';

class Notes extends StatelessWidget {
  const Notes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'avenir'),
        home: notes(),
      ),
      client: client,
    );
  }
}

class notes extends StatefulWidget {
  notes({Key key}) : super(key: key);

  @override
  _notesState createState() => _notesState();
}

class _notesState extends State<notes> {
  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
            documentNode: gql(getNotesQuery),
            pollInterval: Duration(milliseconds: 2000)),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          return Scaffold(
            body: Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  padding: EdgeInsets.only(
                    left: 15.0,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: result.data['notes'].length,
                  itemBuilder: (context, index) {
                    print(result.data["notes"][index]["title"]);
                    return ListTile(
                      title: result.hasException
                          ? Text(result.exception.toString())
                          : result.isLoading
                              ? CircularProgressIndicator()
                              : Text(result.data["notes"][index]["title"]),
                    );
                  }),
            ),
          );
        });
  }
}
