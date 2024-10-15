import 'package:chairty_platform/stripe_payment/stripe_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
abstract class PaymentManager {

  static Future<void> makePayment(int amount , String currency ) async{
    try{
      String clintSecret = await getClintSecret((amount*100).toString(), currency);
      await initializePaymebtSheet(clintSecret);
      await Stripe.instance.presentPaymentSheet();
    }
    catch(error){
        throw Exception(error.toString());
    }
}

static Future<void> initializePaymebtSheet (String clintSecret) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clintSecret,
          merchantDisplayName: "A'laa"
        ),
    );
}


static Future<String> getClintSecret (String amount , String currency) async{
    Dio dio = Dio();
   var response =  await dio.post(
       'https://api.stripe.com/v1/payment_intents',
     options: Options(
       headers: {
         'Authorization': 'Bearer ${Keys.secretKey}',
         'Content-Type': 'application/x-www-form-urlencoded'
       }
     ),

     data: {
       "amount" : amount,
       "currency" : currency,
     }
   );
   return response.data["client_secret"];
}
}