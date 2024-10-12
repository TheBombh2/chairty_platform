import 'package:chairty_platform/models/place.dart';
import 'package:chairty_platform/screens/google_map/map_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HospitalDetailsSecion extends StatefulWidget {
  const HospitalDetailsSecion({
    required this.hospitalName,
    required this.hospitalLocation,
    super.key,
  });
  final String hospitalName;
  final PlaceLocation hospitalLocation;

  @override
  State<HospitalDetailsSecion> createState() => _HospitalDetailsSecionState();
}

class _HospitalDetailsSecionState extends State<HospitalDetailsSecion> {
  String get locationImage {
    final lat = widget.hospitalLocation.latitude;
    final lng = widget.hospitalLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=1000x700&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyDxPozXL_FEyJ0tHTz945Ox1Hllw8RGvdg';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 252, 126, 126),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Hospital',
            style: GoogleFonts.varelaRound(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              'Hospital name: ${widget.hospitalName}',
              textAlign: TextAlign.start,
              style: GoogleFonts.varelaRound(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              'Hospital address: ${widget.hospitalLocation.address}',
              textAlign: TextAlign.start,
              style: GoogleFonts.varelaRound(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 400,
            width: double.infinity,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => MapPage(
                      location: widget.hospitalLocation,
                      isSelecting: false,
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  locationImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
