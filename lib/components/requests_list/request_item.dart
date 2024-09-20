import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neon_widgets/neon_widgets.dart';

class RequestItem extends StatelessWidget {
  const RequestItem({
    super.key,
    required this.paitentImgUri,
    required this.paitentName,
    required this.amountNeeded,
    required this.paitentReason,
    required this.isCompleted
  });
  final String paitentName;
  final String paitentImgUri;
  final String paitentReason;
  final int amountNeeded;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return NeonContainer(
      containerColor: const Color(0xffE2F1F2),
      borderColor: const Color(0xffE2F1F2),
      lightBlurRadius: 16,
      spreadColor: isCompleted ? Colors.green : Colors.pink,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      padding: const EdgeInsets.all(16),
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Column(
        children: [
          Row(
            children: [
               CircleAvatar(
                radius: 30,
                backgroundImage:
                    AssetImage(paitentImgUri),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  paitentName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.varelaRound(
                      color: const Color(
                        0xff034956,
                      ),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              Column(
                children: [
                  Text(
                    'Amount needed:',
                    style: GoogleFonts.varelaRound(
                      color: const Color.fromARGB(255, 10, 25, 27),
                    ),
                  ),
                  Text(
                    '$amountNeeded\$',
                    style: GoogleFonts.varelaRound(
                        color: const Color(
                          0xff034956,
                        ),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  paitentReason,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: GoogleFonts.varelaRound(
                      color: const Color(
                        0xff034956,
                      ),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.read_more_outlined),
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFF26722),
              ),
              label: Text(
                'Read more',
                style: GoogleFonts.varelaRound(
                  color: const Color(
                    0xffE2F1F2,
                  ),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
