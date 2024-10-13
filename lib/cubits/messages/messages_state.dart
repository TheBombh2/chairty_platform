import 'package:chairty_platform/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/message.dart';

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
