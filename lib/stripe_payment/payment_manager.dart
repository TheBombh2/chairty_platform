import 'package:chairty_platform/stripe_payment/stripe_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

abstract class PaymentManager {
  static Future<void> makePayment(
      int amount, String currency, BuildContext context) async {
    try {
      String clintSecret =
          await getClintSecret((amount * 100).toString(), currency);
      await initializePaymebtSheet(clintSecret);
      await Stripe.instance.presentPaymentSheet();
      //Successful payment
      
    } on StripeException catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.error.message!)));
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }

  static Future<void> initializePaymebtSheet(String clintSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clintSecret, merchantDisplayName: "A'laa"),
    );
  }

  static Future<String> getClintSecret(String amount, String currency) async {
    Dio dio = Dio();
    var response = await dio.post('https://api.stripe.com/v1/payment_intents',
        options: Options(headers: {
          'Authorization': 'Bearer ${Keys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        }),
        data: {
          "amount": amount,
          "currency": currency,
        });
    return response.data["client_secret"];
  }
}
