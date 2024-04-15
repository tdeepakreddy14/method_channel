import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:watchlist/repository/contact_repo.dart';
import 'package:watchlist/model/user_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('fetchData', () {
    test('returns a list of data if the HTTP call completes successfully',
        () async {
      final client = MockClient();
      final repo = ContactRepo();
      final List<Map<String, dynamic>> responseData = [
        {
          'id': 1,
          'name': 'name 1',
          'contact': "1-355-184-1639",
          'url':
              "https://s3.amazonaws.com/uifaces/faces/twitter/jpscribbles/128.jpg"
        },
        {
          'id': 2,
          'name': 'name 2',
          'contact': "262.054.8860 x845",
          'url':
              "https://s3.amazonaws.com/uifaces/faces/twitter/matt3224/128.jpg"
        },
      ];
      when(client.get(Uri.parse(
              'http://5e53a76a31b9970014cf7c8c.mockapi.io/msf/getContacts')))
          .thenAnswer(
              (_) async => http.Response(jsonEncode(responseData), 200));
      expect(await repo.getContacts(1, 2), [
        UserModel(
            id: 1,
            name: 'name 1',
            contact: "1-355-184-1639",
            url:
                "https://s3.amazonaws.com/uifaces/faces/twitter/jpscribbles/128.jpg"),
        UserModel(
            id: 2,
            name: 'name 2',
            contact: "262.054.8860 x845",
            url:
                "https://s3.amazonaws.com/uifaces/faces/twitter/matt3224/128.jpg"),
      ]);
    });

  });
}
