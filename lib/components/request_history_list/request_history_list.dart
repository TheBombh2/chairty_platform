import 'package:chairty_platform/Firebase/fire_store.dart';
import 'package:chairty_platform/components/request_history_list/request_history_item.dart';
import 'package:flutter/material.dart';

class RequestHistoryList extends StatefulWidget {
  const RequestHistoryList({super.key});

  @override
  State<RequestHistoryList> createState() => _RequestHistoryListState();
}

class _RequestHistoryListState extends State<RequestHistoryList> {
  @override
  void initState() {
    super.initState();
    FirestoreInterface.init("hZTgPOEhOgXiGa1EEdZhmKUlGE32");//uid {patient}
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: FirestoreInterface.requests.length,
        itemBuilder: (context,index){
      return RequestHistoryItem(requestCompleted: FirestoreInterface.requests[index].requestCompleted,reason: FirestoreInterface.requests[index].reason,funds: FirestoreInterface.requests[index].funds,deadline: FirestoreInterface.requests[index].deadline,);
    });
  }
}
