//main plugin (flutter, firebase)
export 'dart:io';
export 'package:flutter/services.dart';
export 'package:flutter/material.dart';
export 'package:flutter/foundation.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:firebase_messaging/firebase_messaging.dart';


//path_provider
export 'package:path_provider/path_provider.dart';
//auto_size_text
export 'package:auto_size_text/auto_size_text.dart';
//google_fonts
export 'package:google_fonts/google_fonts.dart';
//local_auth
export 'package:local_auth/local_auth.dart';

export 'first_view.dart';

export 'screens/homePage.dart';
export 'screens/money_transfer_page.dart';
export 'screens/profile_page.dart';
export 'screens/qr_payment.dart';
export 'screens/sign_up_page.dart';
export 'screens/transactionHistory/transaction_history.dart';
export 'screens/transactionHistory/txhistroy_test.dart';
export 'screens/transfer/qr_scan.dart';
export 'screens/receive/qr_code_gen.dart';

export 'widgets/provider_widget.dart';
export 'widgets/alert_dialog.dart';
export 'widgets/balance_card.dart';
export 'widgets/title_text.dart';

export 'theme/light_color.dart';
export 'theme/background.dart';

export 'services/auth_service.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

DateTime date = DateTime.now();
String formattedDate = DateFormat('dd-MM-yyyy').format(date);
String? get uid => FirebaseAuth.instance.currentUser!.uid;