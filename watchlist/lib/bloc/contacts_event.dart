part of 'contacts_bloc.dart';

@immutable
sealed class ContactsEvent {}

class LoadContactEvents extends ContactsEvent{
  final int startId;
  final int endId;
  LoadContactEvents({required this.startId ,required this.endId});
}


