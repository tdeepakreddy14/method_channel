import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/bloc/contacts_bloc.dart';

import 'package:flutter/material.dart';
import 'package:watchlist/model/user_model.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage(
      {super.key, required this.startId, required this.endId});
  final int startId;
  final int endId;

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  ContactsBloc contactbloc = ContactsBloc();
  @override
  void initState() {
    contactbloc
        .add(LoadContactEvents(startId: widget.startId, endId: widget.endId));
    super.initState();
  }

  String selectedOption = 'Ascending';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
      bloc: contactbloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (ContactLoadingState):
            return const Center(
              child: CircularProgressIndicator(),
            );
          case const (ContactLoadedState):
            final successState = state as ContactLoadedState;
            List<UserModel> contactList = (selectedOption == 'Ascending')
                ? successState.users
                : successState.users.reversed.toList();

            return Scaffold(
              body: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DropdownButton<String>(
                          value: selectedOption,
                          onChanged: (String? newValue) {
                            selectedOption = newValue!;
                            contactbloc.add(LoadContactEvents(
                                startId: widget.startId, endId: widget.endId));
                          },
                          items: const [
                            DropdownMenuItem<String>(
                              value: 'Ascending',
                              child: Text('Ascending'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Descending',
                              child: Text('Descending'),
                            )
                          ]),
                      IconButton(
                        onPressed: () {
                          selectedOption = (selectedOption == 'Ascending')
                              ? 'Descending'
                              : 'Ascending';
                          contactbloc.add(LoadContactEvents(
                              startId: widget.startId, endId: widget.endId));
                        },
                        icon: const Icon(Icons.sort),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      color: const Color.fromARGB(255, 75, 169, 188),
                      child: ListView.builder(
                        itemCount: contactList.length,
                        itemBuilder: (context, index) {
                          final contact = contactList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Card(
                              child: ListTile(
                                leading: const CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 75, 169, 188),
                                  // child:
                                  //     Image(image: NetworkImage(contact.url)),
                                ),
                                title: Text(
                                  contact.name,
                                ),
                                subtitle: Text(contact.contact),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          case const (ContactErrorState):
            final errState = state as ContactErrorState;
            return Center(
              child: Text(
                (errState.err) as String,
                style: const TextStyle(fontSize: 26, color: Colors.red),
              ), // Display the error message.
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
