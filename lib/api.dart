import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    link: HttpLink(
      'https://todo-graphql-express.herokuapp.com/graphql/',
    ),
    cache: GraphQLCache(),
  ),
);

final String getNotesQuery = """
query {
  notes {
    id
    title
    description
    user{
      id
      firstName
    }
  }
}
""";

final String getUserByEmailQuery = """
query getUserByEmail(\$email: String!){
  userByEmail(email: \$email) {
    id
    firstName
    lastName
    email
    password
  }
}
""";

final String getUsersQuery = """
query {
  notes {
    id
    title
    description
    user{
      id
      firstName
    }
  }
}
""";

final String createNoteMutation = """
mutation AddNote(\$id: ID!, \$title: String!) {
  addNote(title: \$title, description: \$description, userID: \$userID) {
    id
    title
    user{
      firstName
      id
    }
  }
}
""";
