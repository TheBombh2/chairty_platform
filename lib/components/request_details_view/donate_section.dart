import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DonateSection extends StatelessWidget {
  const DonateSection({
    required this.amountNeeded,
    super.key,
  });
  final int amountNeeded;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 6, 144, 168),
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Text(
            'Donate \$$amountNeeded?',
            style: GoogleFonts.varelaRound(
                color: const Color(0xFFF6FAF7),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: FilledButton.icon(
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.payment),
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFF26722),
              ),
              label: Text(
                'Donate',
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
