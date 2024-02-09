import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/button.dart';
import 'package:fund_raiser_second/screens/auth_screens/email_auth/login_screen.dart';
import 'package:fund_raiser_second/screens/auth_screens/phone_auth/login_with_phone_number.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/display_campaigns_screen/campaign_list.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/footer.dart';
import '../../providers/permission_provider.dart';
import '../../utils/constants/color_code.dart';
import '../../utils/utils_toast.dart';

class AuthScreen1 extends StatefulWidget {
  const AuthScreen1({super.key});

  @override
  State<AuthScreen1> createState() => _AuthScreen1State();
}

class _AuthScreen1State extends State<AuthScreen1> {
  bool isPhotoPermissionGranted = false;
  bool isVideoPermissionGranted = false;
  bool isSmsPermissionGranted = false;
  bool isNotificationPermissionGranted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPermission();
  }

  checkPermission() async{
    var permissionProvider = Provider.of<PermissionProvider>(context, listen: false);
    isPhotoPermissionGranted = await permissionProvider.requestPhotosPermission();
    if(isPhotoPermissionGranted){
      Utils().toastMessage("Images Permission granted !");
    }else{
      Utils().toastMessage("Images Permission denied !");
    }
    isVideoPermissionGranted = await permissionProvider.requestVideosPermission();
    if(isVideoPermissionGranted){
      Utils().toastMessage("Videos Permission granted !");
    }else{
      Utils().toastMessage("Videos Permission denied !");
    }
    isSmsPermissionGranted = await permissionProvider.requestSmsPermission();
    if(isSmsPermissionGranted){
      Utils().toastMessage("SMS Permission granted !");
    }else{
      Utils().toastMessage("SMS Permission denied !");
    }

    isNotificationPermissionGranted = await permissionProvider.requestNotificationPermission();
    if(isNotificationPermissionGranted){
      Utils().toastMessage("Notifications Permission granted !");
    }else{
      Utils().toastMessage("Notifications Permission denied !");
    }

    if(!isPhotoPermissionGranted || !isVideoPermissionGranted || !isSmsPermissionGranted || !isNotificationPermissionGranted){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: const Text("Permissions"),
          content: const Text("""Please grant all the permissions to continue.\n\n  Our app needs permission for \n\n 1. Permission for sms for otp based Phone verification \n\n 2. Notifications permission to receive nitifications on creating campaigns \n\n 3.Media permission to access media for creating campaigns \n\n All these permissions are for the purpose of enhancing user experience and providing specific functionalities."""),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text("Ok")),
            TextButton(onPressed: (){
              AppSettings.openAppSettings();
            }, child: const Text("Open Settings ! "))
          ],
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: const [
        Footer(),
      ],
      appBar: AppBar(
        titleSpacing: MediaQuery.of(context).size.width / 3,
        title: const Text(
          "Welcome",
          textAlign: TextAlign.center,
        ),
        backgroundColor: greenColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/logo.png",
                height: 100,
                width: 100,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 25,
              ),
              Container(
                height: 140,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/taarn-690cb.appspot.com/o/images%2Fdownload-removebg-preview.png?alt=media&token=202dd953-7f6a-46f0-a001-14f7b0563aac"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 25,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Join TAARN and be part of a community \n that believes in the power of kindness.\n Together, we can bring hope, joy,\n and positive change to countless lives.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Button(
                  color: greenColor,
                  title: 'Raise Fund',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginWithPhoneNumber(
                                comingFrom: "signup")));
                  }),
              Button(
                  color: secondColor,
                  title: 'Donate Now',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CampaignsList()));
                  }),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an acoount?  ",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Click here to read our",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                  TextButton(
                      onPressed: () async{
                        const url = 'https://adityalahane-2003.github.io/PrivacyPolicy_TAARN/';
                        if (await canLaunch(url)) {
                        await launch(url);
                        } else {
                        throw 'Could not launch $url';
                        }
                      },
                      child: Text(
                        "Privacy Policy",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
