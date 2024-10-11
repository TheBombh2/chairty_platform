import 'package:chairty_platform/Firebase/fire_store.dart';
import 'package:chairty_platform/cubits/requests_state.dart';
import 'package:chairty_platform/models/request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit() : super(RequestsInital()) {
    getRequests();
  }

  void getRequests() async {
    emit(RequestsLoading());
    List<Request> loadedRequests = [];
    try {
      FirestoreInterface.firebaseInstance
          .collection('requests')
          .snapshots()
          .listen((event) async {
        for (var element in event.docs) {
          final request = Request.fromJson(element.data(), element.id);
          await request.initializePatient();
          loadedRequests.add(request);
        }

        emit(RequestsLoaded(requests: loadedRequests));
      });
    } catch (error) {
      emit(RequeststError(message: error.toString()));
    }
  }
}
