import 'package:chairty_platform/components/request_details_view/details_section.dart';
import 'package:chairty_platform/components/request_details_view/documents_list_section.dart';
import 'package:chairty_platform/components/request_details_view/donate_section.dart';
import 'package:chairty_platform/components/request_details_view/hospital_secion/hospital_details_secion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RequestViewPage extends StatelessWidget {
  const RequestViewPage({
    required this.name,
    required this.age,
    required this.imageURI,
    super.key,
  });
  final String name;
  final String age;
  final String imageURI;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAF7),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Donate to $name",
          style: GoogleFonts.varelaRound(
            color: const Color(
              0xffE2F1F2,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff034956),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Hero(
                tag: name,
                child:  CircleAvatar(
                  radius: 80,
                  backgroundImage:
                      AssetImage(imageURI),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.varelaRound(
                          color: const Color(
                            0xff034956,
                          ),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      textAlign: TextAlign.end,
                      '$age y.o',
                      style: GoogleFonts.varelaRound(
                          color: const Color(
                            0xff034956,
                          ),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const DetailsSection(
                title: 'Why do I need the donation',
                body:
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
                backgroundColor: Color.fromARGB(255, 247, 224, 157),
              ),
              const SizedBox(
                height: 16,
              ),
              const DetailsSection(
                title: 'The danger that may affect me',
                body:
                    'Lorem Ipsum is simply dummy text of the printing and typesettintypesettingtypesettingtypesettingtypesettingtypesettingtypesettingtypesettingtypesettingtypesettinggtypesettingtypesettingtypesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
                backgroundColor: Color.fromARGB(255, 250, 122, 165),
              ),
              const SizedBox(
                height: 16,
              ),
              const DocumentsListSection(
                documents: [
                  'Medical Report 1',
                  'Medical Report 2',
                  'Medical Report 3',
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const HospitalDetailsSecion(
                hospitalName: 'Al amoma',
                hospitalLocation: LatLng(31.13567354055204, 30.64803319513834),
              ),
              const SizedBox(
                height: 16,
              ),
              const DonateSection(
                amountNeeded: 500,
              ),
              const SizedBox(
                height: 24,
              )
            ],
          ),
        ),
      ),
    );
  }
}
