import 'package:chairty_platform/Firebase/fire_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/message.dart';
import '../../models/user.dart';
import 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(MessagesInitial()){
    getOtherUsers();
  }

  Stream<List<Message>> messagesStream(String patientId, String donaterId) {
    return FirestoreInterface.getMessagesStream(patientId, donaterId).map(
          (snapshot) => snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Message.fromJson(data);
      }).toList(),
    );
  }

  Stream<List<Map<CharityUser?, String>>> otherUsersStream() async* {
    while (true) { // Keep the stream alive
      await Future.delayed(Duration(seconds: 1)); // Adjust as needed
      yield await FirestoreInterface.getAllOtherUsers(); // Emit the latest users
    }
  }

  Future<void> getOtherUsers() async {
    emit(MessagesLoading());
    try {
      // Instead of fetching once, we can use a stream
      otherUsersStream().listen((otherUsers) {
        emit(MessagesLoaded(otherUsers: otherUsers));
      });
    } catch (error) {
      emit(MessagesError(message: error.toString()));
    }
  }

  Future<void> sendMessage(Message message) async {
    try {
      await FirestoreInterface.sendMessage(message);
    } catch (error) {
      emit(MessagesError(message: error.toString()));
    }
  }
}
