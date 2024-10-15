import 'dart:async';

import 'package:chairty_platform/Firebase/auth_interface.dart';
import 'package:chairty_platform/Firebase/fire_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/message.dart';
import '../../models/user.dart';
import 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  static StreamSubscription? messageStream;
  MessagesCubit() : super(MessagesInitial()) {
    getOtherUsers();
  }
  void clearState() {
    emit(MessagesInitial());
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
    while (true) {
      if (AuthInterface.getCurrentUser() == null) {
        break;
      }
      await Future.delayed(Duration(seconds: 1));
      final users = await FirestoreInterface.getAllOtherUsers();
      if (users != null) {
        yield users;
      }
      if (messageStream != null) {
        messageStream!.cancel();
        messageStream = null;
      }
    }
  }

  Future<void> getOtherUsers() async {
    emit(MessagesLoading());
    try {
      if (messageStream != null) {
        await messageStream!.cancel();
        messageStream = null;
      }
      messageStream = otherUsersStream().listen((otherUsers) {
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
