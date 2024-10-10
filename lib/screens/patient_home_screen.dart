import 'package:chairty_platform/components/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/images/avatar_placeholder.png"),
            ),
            Spacer(),
            Text("Your Posts"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
              Navigator.pushNamed(context, "/PatientRequest");
          },
        child: Icon(Icons.add, color: Colors.white,),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: darkColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body:ListView(
         children: [
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30),
             child: Stack(
               clipBehavior: Clip.none,
               children: [
                 Container(
                     padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                     width: double.infinity,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                         border: Border.all(
                             width: 2,
                             color: Colors.red
                         ),
                         color: lightColor
                     ),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Container(
                           decoration:BoxDecoration(
                               borderRadius: BorderRadius.circular(20),
                               color: deepOrange
                           ),
                           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                           child: Text(
                             "100\$",
                             style: TextStyle(
                                 color: Colors.white
                             ),
                           ),
                         ),
                         SizedBox(width: 25,),
                         Column(
                           mainAxisSize: MainAxisSize.min,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               "Title : ............",
                               style: TextStyle(
                                 color: darkColor,
                                 fontSize: 20,
                               ),
                             ),
                             Text(
                               "Description : ............",
                               style: TextStyle(
                                 color: Colors.grey.shade700,
                                 fontSize: 20,
                               ),
                             ),
                           ],
                         )
                       ],
                     )
                 ),
                 Positioned(
                   right: 10,
                   top: -15,
                   child: GestureDetector(
                     child: CircleAvatar(
                       radius: 15,
                       backgroundColor: Colors.red,
                       child: Icon(Icons.close,color: Colors.white,),
                     ),
                   ),
                 )
               ],
             ),
           ),

           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30),
             child: Stack(
               clipBehavior: Clip.none,
               children: [
                 Container(
                     padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                     width: double.infinity,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                         border: Border.all(
                             width: 2,
                             color: darkColor
                         ),
                         color: lightColor
                     ),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Container(
                           decoration:BoxDecoration(
                               borderRadius: BorderRadius.circular(20),
                               color: Colors.green
                           ),
                           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                           child: Text(
                             "100\$",
                             style: TextStyle(
                                 color: Colors.white
                             ),
                           ),
                         ),
                         SizedBox(width: 25,),
                         Column(
                           mainAxisSize: MainAxisSize.min,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               "Title : ............",
                               style: TextStyle(
                                 color: darkColor,
                                 fontSize: 20,
                               ),
                             ),
                             Text(
                               "Description : ............",
                               style: TextStyle(
                                 color: Colors.grey.shade700,
                                 fontSize: 20,
                               ),
                             ),
                           ],
                         )
                       ],
                     )
                 ),
                 Positioned(
                   right: 10,
                   top: -15,
                   child: GestureDetector(
                     child: CircleAvatar(
                       radius: 15,
                       backgroundColor: Colors.green,
                       child: Icon(Icons.check,color: Colors.white,),
                     ),
                   ),
                 )
               ],
             ),
           ),
         ],
      )
    );
  }
}
