import 'package:chairty_platform/components/requests_list/request_item.dart';
import 'package:flutter/material.dart';

class RequestList extends StatefulWidget {
  const RequestList({super.key});

  @override
  State<RequestList> createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (ctx, index) => const RequestItem(
        paitentImgUri: 'assets/images/avatar_placeholder.png',
        paitentReason:
            'but also the leap into electroni960s siandsiandsiandsiiandsiaandsiandsiandsiandsiandsiandsi Ipsum',
        paitentName: 'Belal Salem',
        amountNeeded: 500,
        isCompleted: false,
      ),
    );
  }
}
