import 'package:flutter/material.dart';
import 'package:watchlist/widgets/contact_list_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Contacts'),
            titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
            bottom: const TabBar(
              isScrollable: true,
              splashBorderRadius: BorderRadius.all(Radius.circular(50)),
              unselectedLabelColor: Colors.black,
              labelColor: Color.fromARGB(255, 54, 123, 136),
              tabs: [
                Tab(child: Text("Contact 1")),
                Tab(child: Text("Contact 2")),
                Tab(child: Text("Contact 3")),
                Tab(child: Text("Contact 4")),
                Tab(child: Text("Contact 5")),
              ],
            ),
          ),
          body: const TabBarView(children: [
            ContactListPage(startId: 1, endId: 20),
            ContactListPage(startId: 21, endId: 40),
            ContactListPage(startId: 41, endId: 60),
            ContactListPage(startId: 61, endId: 80),
            ContactListPage(startId: 81, endId: 100),
          ]),
        ),
      ),
    );
  }
}
