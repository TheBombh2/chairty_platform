import 'package:chairty_platform/models/request.dart';
import 'package:chairty_platform/screens/request_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:chairty_platform/components/style.dart';

class RequestItemPaitent extends StatelessWidget {
  final Request request;
  const RequestItemPaitent({
    required this.request,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => RequestViewScreen(request: request),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 2,
                        color: request.requestCompleted
                            ? Colors.green
                            : Colors.red),
                    color: lightColor),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: deepOrange),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        "${request.funds}\$",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Title : ${request.reason}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: darkColor,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Description : ${request.danger}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            Positioned(
              right: 10,
              top: -15,
              child: GestureDetector(
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor:
                      request.requestCompleted ? Colors.green : Colors.red,
                  child: Icon(
                    request.requestCompleted ? Icons.check : Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
