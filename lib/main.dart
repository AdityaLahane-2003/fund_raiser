import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fund_raiser_second/providers/campaigns_provider.dart';
import 'package:fund_raiser_second/providers/fundraiser_data_provider.dart';
import 'package:fund_raiser_second/providers/permission_provider.dart';
import 'package:fund_raiser_second/screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  TextTheme _customTextTheme = GoogleFonts.poppinsTextTheme();

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => FundraiserDataProvider()),
          ChangeNotifierProvider(create: (_) => CampaignProvider()),
          ChangeNotifierProvider(create: (_) => PermissionProvider()),
        ],
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            textTheme:_customTextTheme
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        )),
  );
}
