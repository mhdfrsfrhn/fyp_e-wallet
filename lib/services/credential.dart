import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../imports.dart';
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
String? get currentEmail => _firebaseAuth.currentUser!.email;
      ///SEND AUTOMATED EMAIL
      Future sendEmail(context, amount, receiveremail) async {

        final email = 'ewalletfyp@gmail.com';
        final password = 'ewallet123';
        final smtpServer = gmail(email, password);

        final message = Message()
          ..from = Address(email, 'Z-Wallet App')
          ..recipients.add(receiveremail)
          ..subject = 'Payment Received!'
          ..text = "You have received RM${amount} from ${currentEmail}";

        try {
          await send(message, smtpServer);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('sent email successful!')));
        } on MailerException catch (e) {
          print(e);
        }
      }
