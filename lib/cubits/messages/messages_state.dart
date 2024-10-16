import 'package:chairty_platform/models/user.dart';


abstract class MessagesState {}

class MessagesInitial extends MessagesState {}


class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final List<Map<CharityUser?,String>> otherUsers;

  MessagesLoaded({required this.otherUsers});
}

class MessagesError extends MessagesState {
  final String message;

  MessagesError({required this.message});

}
