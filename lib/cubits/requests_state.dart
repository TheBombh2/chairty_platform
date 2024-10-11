import 'package:chairty_platform/models/request.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class RequestsState {}

class RequestsInital extends RequestsState {}

class RequestsLoading extends RequestsState {}

class RequestsLoaded extends RequestsState {
  final List<Request> requests;
  final List<Request> completedRequests;
  final List<Request> uncompletedRequsts;

  RequestsLoaded({
    required this.requests,
    required this.completedRequests,
    required this.uncompletedRequsts,
  });
}

class RequeststError extends RequestsState {
  final String message;
  RequeststError({required this.message});
}
