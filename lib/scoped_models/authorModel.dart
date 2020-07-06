import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cooky/models/author.dart';
import 'ConnectedModel.dart';

class AuthorModel extends ConnectedModel {
  List<Author> get get_allAuthor {
    return List.from(author_list);
  }

  Author get get_authorbyName {
    return author;
  }

  Future<Author> getauthorbyName(String authorName) async {
    isLoading = true;
    notifyListeners();
    http.Response response = await http.post(
      'https://firestore.googleapis.com/v1/projects/cooky-e12a6/databases/(default)/documents:runQuery?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4/projects/cooky-e12a6/databases/(default)/documents/India:runQuery?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authenticatedUser.token}'
      },
      body: json.encode({
        "structuredQuery": {
          "from": [
            {"collectionId": "author"}
          ],
          "where": {
            "fieldFilter": {
              "field": {"fieldPath": "Name"},
              "op": "EQUAL",
              "value": {"stringValue": '${authorName}'}
            }
          },
        }
      }),
    );
    var authorDocuments = json.decode(response.body);
    // print("xxxxxxtttttttttttttttttttx");
    // print(authorDocuments);
    Author authorbyName =Author.fromMap(authorDocuments[0]['document']['fields']);
    author = authorbyName;
    isLoading = false;
    notifyListeners();
    return author;
  }

  Future<void> getauthorList() async {
    isLoading = true;
    notifyListeners();
    http.Response response = await http.post(
      'https://firestore.googleapis.com/v1/projects/cooky-e12a6/databases/(default)/documents:runQuery?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4/projects/cooky-e12a6/databases/(default)/documents/India:runQuery?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authenticatedUser.token}'
      },
      body: json.encode({
        "structuredQuery": {
          "from": [
            {"collectionId": "author"}
          ],
        }
      }),
    );
    var authorDocuments = json.decode(response.body);
    print(authorDocuments);
    final List<Author> fetchedauthorList = [];

    for (int i = 0; i < authorDocuments.length; i++) {
      fetchedauthorList
          .add(Author.fromMap(authorDocuments[i]['document']['fields']));
    }

    author_list = fetchedauthorList;

    isLoading = false;
    notifyListeners();
  }
}
