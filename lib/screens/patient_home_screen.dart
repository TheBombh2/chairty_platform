import 'package:chairty_platform/Firebase/auth_interface.dart';
import 'package:chairty_platform/components/drawer/drawer_menu.dart';
import 'package:chairty_platform/components/paitent_home_screen/request_item_paitent.dart';
import 'package:chairty_platform/components/style.dart';
import 'package:chairty_platform/cubits/requests/requests_cubit.dart';
import 'package:chairty_platform/cubits/requests/requests_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubits/messages/messages_cubit.dart';
import 'inbox_screen.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Posts",
          style: GoogleFonts.varelaRound(
            color: const Color(
              0xffE2F1F2,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff034956),
        actions: [
          IconButton(
              onPressed: () {
                final messagesCubit = context.read<MessagesCubit>();
                messagesCubit.getOtherUsers();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InboxScreen()));
              },
              icon: const Icon(
                Icons.inbox_rounded,
                size: 30,
                color: Colors.white,
              )),
         
        ],
        leading: Builder(builder: (ctx) {
          return IconButton(
            onPressed: () {
              Scaffold.of(ctx).openDrawer();
            },
            icon: const Icon(
              Icons.menu_rounded,
              size: 40,
              color: Color(
                0xffE2F1F2,
              ),
            ),
          );
        }),
      ),
      drawer: const DrawerMenu(
        showHistory: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/PatientRequest");
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: darkColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocBuilder<RequestsCubit, RequestsState>(
        builder: (ctx, state) {
          if (state is RequestsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RequeststError) {
            return const Center(
              child: Text('Something went wrong!'),
            );
          } else if (state is RequestsLoaded) {
            final paitentRequests = state.requests
                .where((ele) =>
                    ele.patientId == AuthInterface.getCurrentUser()!.uid)
                .toList();
            return ListView.builder(
                itemCount: paitentRequests.length,
                itemBuilder: (ctx, index) {
                  final singleRequest = paitentRequests[index];
                  return RequestItemPaitent(
                    request: singleRequest,
                  );
                });
          } else {
            return const Center(child: Text('No Requests Available.'));
          }
        },
      ),
    );
  }
}
