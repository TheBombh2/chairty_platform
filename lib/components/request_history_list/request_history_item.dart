import 'package:chairty_platform/models/request.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RequestHistoryItem extends StatelessWidget {
  final Request request;

  const RequestHistoryItem({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    String formattedDeadline =
        DateFormat('yyyy-MM-dd').format(request.deadline);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${request.paitent.firstName} ${request.paitent.lastName}",
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
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
                  child: Column(
                    children: [
                      Text(
                        "Reason:",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          request.reason,
                          style: const TextStyle(
                            color: Color(0xff034956),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
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
                      '\$${request.funds}',
                      style: GoogleFonts.varelaRound(
                        color: const Color(0xff034956),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Icon(
                      request.requestCompleted
                          ? Icons.check_circle
                          : Icons.pending,
                      color: request.requestCompleted
                          ? const Color(0xff034956)
                          : const Color(0xFFF26722),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
