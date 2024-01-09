import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fund_raiser_second/providers/campaigns_provider.dart';
import 'package:fund_raiser_second/providers/fundraiser_data_provider.dart';
import 'package:fund_raiser_second/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => FundraiserDataProvider()),
          ChangeNotifierProvider(create: (_) => CampaignProvider()),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        )),
  );
}
