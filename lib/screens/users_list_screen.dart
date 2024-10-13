import 'package:chairty_platform/Firebase/auth_interface.dart';
import 'package:chairty_platform/Firebase/fire_store.dart';
import 'package:chairty_platform/models/request.dart';
import 'package:chairty_platform/models/user.dart';
import 'package:chairty_platform/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/requests_list/request_item.dart';
import '../cubits/requests/requests_cubit.dart';
import '../cubits/requests/requests_state.dart';

class UsersListScreen extends StatelessWidget {
  UsersListScreen({super.key});

  CharityUser user = AuthInterface.getCurrentCharityUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color(0xffE2F1F2),
        title: Text(
          (user.userType == UserType.donator) ? 'Patients' : 'Donators',
          style: GoogleFonts.varelaRound(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff034956),
      ),
      body: BlocBuilder<RequestsCubit, RequestsState>(builder: (ctx, state) {
        if (state is RequestsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RequeststError) {
          return const Center(
            child: Text('Something went wrong!'),
          );
        } else if (state is RequestsLoaded) {
          Map<String, List<Request>> otherTypeRequestsMap = {};
          print(user.userType==UserType.donator);
          if(user.userType==UserType.donator){
            for (var request in state.completedRequests) {
            if (request.donaterId == FirebaseAuth.instance.currentUser?.uid) {
              final patientId = request.patientId;
              if (!otherTypeRequestsMap.containsKey(patientId)) {
                otherTypeRequestsMap[patientId] = [];
              }
              otherTypeRequestsMap[patientId]!.add(request);
            }
          }
          }
          else{
            for (var request in state.completedRequests) {
              if (request.patientId == FirebaseAuth.instance.currentUser?.uid) {
                final donaterId = request.donaterId;
                if (!otherTypeRequestsMap.containsKey(donaterId)) {
                  otherTypeRequestsMap[donaterId!] = [];
                }
                otherTypeRequestsMap[donaterId]!.add(request);
              }
            }
          }


          return ListView.builder(
            itemCount: otherTypeRequestsMap.length,
            itemBuilder: (ctx, index) {
              final patientId = otherTypeRequestsMap.keys.elementAt(index);
              final requests = otherTypeRequestsMap[patientId]!;
              final singleRequest = requests[0];
              CharityUser otherUser=(user.userType==UserType.donator)?singleRequest.paitent:singleRequest.donater;
              return Card(
                surfaceTintColor: Color(0xffE2F1F2),
                shadowColor: Color(0xff034956),
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.white,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          user: otherUser,
                          viewOnly: true,
                          patientId: singleRequest.patientId,
                          donaterId: singleRequest.donaterId!,
                        ),
                      ),
                    );
                  },
                  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(otherUser.imageUrl),
                  ),
                  title: Text(
                    "${otherUser.firstName} ${otherUser.lastName}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff034956),
                    ),
                  ),
                  subtitle: Text(
                    "${requests.length} request${requests.length > 1 ? 's' : ''} in common",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blueAccent,
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('No Requests Available.'));
        }
      }),
    );
  }
}
