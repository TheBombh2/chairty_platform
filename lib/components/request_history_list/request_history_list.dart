import 'package:chairty_platform/Firebase/fire_store.dart';
import 'package:chairty_platform/components/request_history_list/request_history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Firebase/auth_interface.dart';
import '../../cubits/requests/requests_cubit.dart';
import '../../cubits/requests/requests_state.dart';

class RequestHistoryList extends StatelessWidget {
  const RequestHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestsCubit, RequestsState>(
      builder: (ctx, state) {
        if (state is RequestsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RequeststError) {
          return const Center(
            child: Text('Something went wrong!'),
          );
        } else if (state is RequestsLoaded) {
          final donaterRequests = state.requests
              .where((ele) =>
          ele.donaterId == AuthInterface.getCurrentUser()!.uid)
              .toList();
          return ListView.builder(
              itemCount: donaterRequests.length,
              itemBuilder: (ctx, index) {
                final singleRequest = donaterRequests[index];
                return RequestHistoryItem(
                  request: singleRequest,
                );
              });
        } else {
          return const Center(child: Text('No Requests Available.'));
        }
      },
    );
  }
}
