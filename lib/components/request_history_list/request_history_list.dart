import 'package:chairty_platform/components/request_history_list/request_history_item.dart';
import 'package:flutter/material.dart';

class RequestHistoryList extends StatefulWidget {
  const RequestHistoryList({super.key});

  @override
  State<RequestHistoryList> createState() => _RequestHistoryListState();
}

class _RequestHistoryListState extends State<RequestHistoryList> {
  List myList = [
    RequestHistoryItem(
      deadline: DateTime(2023, 05, 15),
      funds: 7000,
      reason: "Brain Tumor",
      requestCompleted: false,
    ),
    RequestHistoryItem(
      deadline: DateTime(2023, 06, 10),
      funds: 3000,
      reason: "Medical Equipment",
      requestCompleted: true,
    ),
    RequestHistoryItem(
      deadline: DateTime(2023, 07, 20),
      funds: 4500,
      reason: "Patient Care Support",
      requestCompleted: true,
    ),
    RequestHistoryItem(
      deadline: DateTime(2023, 08, 30),
      funds: 6000,
      reason: "Research Funding",
      requestCompleted: true,
    ),
    RequestHistoryItem(
      deadline: DateTime(2023, 09, 25),
      funds: 5500,
      reason: "Clinical Trials",
      requestCompleted: true,
    ),
    RequestHistoryItem(
      deadline: DateTime(2023, 10, 15),
      funds: 8000,
      reason: "Awareness Campaign",
      requestCompleted: true,
    ),
    RequestHistoryItem(
      deadline: DateTime(2023, 11, 05),
      funds: 3500,
      reason: "Family Support",
      requestCompleted: true,
    ),
    RequestHistoryItem(
      deadline: DateTime(2023, 12, 01),
      funds: 5000,
      reason: "Rehabilitation Program",
      requestCompleted: true,
    ),
    RequestHistoryItem(
      deadline: DateTime(2024, 01, 10),
      funds: 9000,
      reason: "Nutritional Support",
      requestCompleted: true,
    ),
    RequestHistoryItem(
      deadline: DateTime(2024, 02, 20),
      funds: 4000,
      reason: "Patient Transportation",
      requestCompleted: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: myList.length,
        itemBuilder: (context,index){
      return myList[index];
    });
  }
}
