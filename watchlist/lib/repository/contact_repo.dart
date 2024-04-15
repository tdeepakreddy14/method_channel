import 'dart:convert';

import 'package:watchlist/model/user_model.dart';
import 'package:http/http.dart' as http;

class ContactRepo {
  Future<List<UserModel>> getContacts(int startId, int endId) async {
    String url = 'http://5e53a76a31b9970014cf7c8c.mockapi.io/msf/getContacts';
    final response = await http.get(Uri.parse(url));
    //print(response.statusCode);
    //print(response.body);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final List<UserModel> contacts = (result as List)
          .map(
            (e) {
              final id = int.parse(e['id']);
              if (id >= startId && id <= endId) {
                return UserModel(
                    name: e['name'], contact: e['Contacts'], url: e['url']);
              } else {
                return UserModel(name: '', contact: '', url: '');
              }
            },
          )
          .where((element) =>
              element.name.isNotEmpty && element.contact.isNotEmpty)
          .toList();
      return contacts;
    } else {
      throw Exception(response.reasonPhrase);   //provides a short textual description
    }
  }
}
