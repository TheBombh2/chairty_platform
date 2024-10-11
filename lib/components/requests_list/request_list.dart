import 'package:chairty_platform/Firebase/fire_store.dart';
import 'package:chairty_platform/components/requests_list/request_item.dart';
import 'package:flutter/material.dart';

class RequestList extends StatefulWidget {
  const RequestList({super.key});

  @override
  State<RequestList> createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  void initState() {
    super.initState();
    FirestoreInterface.init("9As0D631chVeNZrcGuBD60MJWiB2").then((_)=>setState(() {
      
    }));//uid
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: FirestoreInterface.allRequests.length,
      itemBuilder: (ctx, index) => RequestItem(
        paitentImgUri: FirestoreInterface.patients[index].imageUrl,
        paitentReason:
            FirestoreInterface.allRequests[index].reason,
        paitentName: "${FirestoreInterface.patients[index].firstName} ${FirestoreInterface.patients[index].lastName}",
        amountNeeded: FirestoreInterface.allRequests[index].funds,
        isCompleted: FirestoreInterface.allRequests[index].requestCompleted,
      ),
    );
  }
}
