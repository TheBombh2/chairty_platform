import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RequestHistoryItem extends StatelessWidget {
  final DateTime deadline;
  final int funds;
  final String reason;
  final bool requestCompleted;

  const RequestHistoryItem({
    Key? key,
    required this.deadline,
    required this.funds,
    required this.reason,
    required this.requestCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDeadline = DateFormat('yyyy-MM-dd').format(deadline);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Deadline:",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formattedDeadline,
                  style: const TextStyle(
                    color: Color(0xff034956),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  reason,
                  style: const TextStyle(
                    color: Color(0xff034956),
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Amount needed:',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$$funds',
                  style: GoogleFonts.varelaRound(
                    color: const Color(0xff034956),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Icon(
                  requestCompleted ? Icons.check_circle : Icons.pending,
                  color: requestCompleted ? const Color(0xff034956) : const Color(0xFFF26722),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
