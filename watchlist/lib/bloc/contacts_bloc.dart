import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:watchlist/repository/contact_repo.dart';
import 'package:watchlist/model/user_model.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(ContactsInitial()) {
    on<LoadContactEvents>(_onLoadContactEvents);
  }

  void _onLoadContactEvents(
      LoadContactEvents event, Emitter<ContactsState> emit) async {
    emit(ContactLoadingState());
    try {
      final users = await ContactRepo().getContacts(event.startId, event.endId);
      emit(ContactLoadedState(users: users));
    } catch (e) {
      emit(ContactErrorState(e.toString()));
    }
  }
}
