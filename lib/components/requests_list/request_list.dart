import 'package:chairty_platform/components/requests_list/request_item.dart';
import 'package:chairty_platform/cubits/requests_cubit.dart';
import 'package:chairty_platform/cubits/requests_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestList extends StatelessWidget {
  const RequestList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestsCubit, RequestsState>(builder: (ctx, state) {
      if (state is RequestsLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is RequeststError) {
        return const Center(
          child: Text('Something went wrong!'),
        );
      } else if (state is RequestsLoaded) {
        return ListView.builder(
            itemCount: state.requests.length,
            itemBuilder: (ctx, index) {
              final singleRequest = state.requests[index];

              return RequestItem(
                  paitentImgUri: singleRequest.paitent.imageUrl,
                  paitentReason: singleRequest.reason,
                  paitentName:
                      "${singleRequest.paitent.firstName} ${singleRequest.paitent.lastName}",
                  amountNeeded: singleRequest.funds,
                  isCompleted: singleRequest.requestCompleted);
            });
      } else {
        return const Center(child: Text('No Requests Available.'));
      }
    });
  }
}
