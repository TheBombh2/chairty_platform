import 'package:chairty_platform/models/request.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../stripe_payment/payment_manager.dart';

class DonateSection extends StatefulWidget {
  const DonateSection({
    required this.request,
    super.key,
  });
  final Request request;

  @override
  State<DonateSection> createState() => _DonateSectionState();
}

class _DonateSectionState extends State<DonateSection> {
  bool isPaying = false;
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
            'Donate \$${widget.request.funds}?',
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
              onPressed: isPaying
                  ? null
                  : () {
                      setState(() {
                        isPaying = true;
                      });
                      PaymentManager.makePayment(
                          widget.request, "USD", context);
                      setState(() {
                        isPaying = false;
                      });
                    },
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
