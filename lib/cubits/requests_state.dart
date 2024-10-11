import 'package:chairty_platform/models/request.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class RequestsState {}

class RequestsInital extends RequestsState {}

class RequestsLoading extends RequestsState {}

class RequestsLoaded extends RequestsState {
  final List<Request> requests;
  RequestsLoaded({required this.requests});
}

class RequeststError extends RequestsState {
  final String message;
  RequeststError({required this.message});
}
