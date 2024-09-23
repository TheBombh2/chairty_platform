import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HospitalDetailsSecion extends StatefulWidget {
  const HospitalDetailsSecion({
    required this.hospitalName,
    required this.hospitalLocation,
    super.key,
  });
  final String hospitalName;
  final LatLng hospitalLocation;

  @override
  State<HospitalDetailsSecion> createState() => _HospitalDetailsSecionState();
}

class _HospitalDetailsSecionState extends State<HospitalDetailsSecion> {
  // ignore: unused_field
  late GoogleMapController _mapController;
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
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
              widget.hospitalName,
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: GoogleMap(
                gestureRecognizers: {
                  Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer())
                },
                onMapCreated: _onMapCreated,
                initialCameraPosition: const CameraPosition(
                    target: LatLng(31.135797330909583, 30.647989081583237),
                    zoom: 16.0),
                markers: {
                   Marker(
                    markerId: MarkerId(widget.hospitalName),
                    position: widget.hospitalLocation,
                    infoWindow: InfoWindow(
                      title: widget.hospitalName,
                    ),
                  ),
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
