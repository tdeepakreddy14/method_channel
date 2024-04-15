part of 'contacts_bloc.dart';

@immutable
sealed class ContactsState {}

final class ContactsInitial extends ContactsState {}

final class ContactLoadingState extends ContactsState{}

final class ContactLoadedState extends ContactsState{
  final List<UserModel> users;
  ContactLoadedState({required this.users});
}

final class ContactErrorState extends ContactsState{
  ContactErrorState(this.err);
  final Object err;
}

