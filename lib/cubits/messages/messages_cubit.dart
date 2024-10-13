import 'package:chairty_platform/Firebase/fire_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/message.dart';
import 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(MessagesInitial());

  Stream<List<Message>> messagesStream(String patientId, String donaterId) {
    return FirestoreInterface.getMessagesStream(patientId, donaterId).map(
          (snapshot) => snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Message.fromJson(data);
      }).toList(),
    );
  }


  Future<void> fetchMessages(String patientId, String donaterId) async {
    emit(MessagesLoading());
    try {
      final messagesData = await FirestoreInterface.getMessages(patientId, donaterId);
      final messages = messagesData.map((data) => Message.fromJson(data)).toList();
      emit(MessagesLoaded(messages: messages));
    } catch (error) {
      emit(MessagesError(message: error.toString()));
    }
  }

  Future<void> sendMessage(Message message) async {
    try {
      await FirestoreInterface.sendMessage(message);
      fetchMessages(message.patientId, message.donaterId);
    } catch (error) {
      emit(MessagesError(message: error.toString()));
    }
  }
}
