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

final String getTodosByDateAndUserQuery = """
query getTodosBydayAndUser(\$forDate: String!, \$userID: ID!){
  todosByDayAndUser(forDate: \$forDate, userID: \$userID) {
    id
    title
    isCompleted
    forDate
    color
  }
}
""";

final String getNotesByDateAndUserQuery = """
query getNotesBydayAndUser(\$forDate: String!, \$userID: ID!){
  notesByDayAndUser(forDate: \$forDate, userID: \$userID) {
    id
    title
    description
    forDate
    color
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
mutation AddNote(\$title: String!, \$forDate: String!, \$description: String!, \$color: String!, \$userID: ID!) {
  addNote(title: \$title, description: \$description, userID: \$userID, color: \$color, forDate: \$forDate) {
    id
    title
    forDate
    description
    color
  }
}
""";

final String createUserMutation = """
mutation AddUser(\$firstName: String!, \$lastName: String!, \$email: String!, \$password: String!) {
  addUser(firstName: \$firstName, lastName: \$lastName, email: \$email, password: \$password) {
    id
    firstName
    lastName
    email
    password
  }
}
""";

final String createTodoMutation = """
mutation AddTodo(\$title: String!, \$forDate: String!, \$isCompleted: Boolean!, \$color: String!, \$userID: ID!) {
  addTodo(title: \$title, forDate: \$forDate, isCompleted: \$isCompleted, color: \$color, userID: \$userID) {
    id
    title
    forDate
    isCompleted
  }
}
""";

final String updateTodoMutation = """
mutation UpdateTodo(\$id: ID!, \$title: String!, \$forDate: String!, \$isCompleted: Boolean!, \$color: String!, \$userID: ID!) {
  updateTodo(id: \$id, title: \$title, forDate: \$forDate, isCompleted: \$isCompleted, color: \$color, userID: \$userID) {
    id
    title
    forDate
    isCompleted
  }
}
""";

final String updateNoteMutation = """
mutation UpdateNote(\$id: ID!, \$title: String!, \$forDate: String!, \$description: String!, \$color: String!, \$userID: ID!) {
  updateNote(id: \$id, title: \$title, description: \$description, userID: \$userID, color: \$color, forDate: \$forDate) {
    id
    title
    forDate
    description
    color
  }
}
""";
final String deleteNoteMutation = """
mutation DeleteNote(\$id: ID!) {
  deleteNote(id: \$id) {
    id
  }
}
""";
final String deleteTodoMutation = """
mutation DeleteTodo(\$id: ID!) {
  deleteTodo(id: \$id) {
    id
  }
}
""";
