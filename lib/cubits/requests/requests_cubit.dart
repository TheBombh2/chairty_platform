import 'package:chairty_platform/Firebase/fire_store.dart';
import 'package:chairty_platform/cubits/requests/requests_state.dart';
import 'package:chairty_platform/models/request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit() : super(RequestsInital()) {
    getRequests();
  }

  void getRequests() async {
    emit(RequestsLoading());
    try {
      FirestoreInterface.firebaseInstance
          .collection('requests')
          .snapshots()
          .listen((event) async {
        List<Request> loadedRequests = [];
        List<Request> completedRequests = [];
        List<Request> uncompletedRequsts = [];

        for (var element in event.docs) {
          final request = Request.fromJson(element.data(), element.id);
          await request.initializePatient();
          loadedRequests.add(request);
          if (request.requestCompleted ) {
            await request.initializeDonater();
            completedRequests.add(request);
          } else if(!request.requestCompleted && !request.requestExpired){
            uncompletedRequsts.add(request);
          }
        }

        emit(RequestsLoaded(
          requests: loadedRequests,
          completedRequests: completedRequests,
          uncompletedRequsts: uncompletedRequsts,
        ));
      });
    } catch (error) {
      emit(RequeststError(message: error.toString()));
    }
  }
}
