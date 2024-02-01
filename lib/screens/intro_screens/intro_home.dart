import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/footer.dart';
import 'package:fund_raiser_second/screens/auth_screens/auth_screen1.dart';
import 'package:fund_raiser_second/screens/intro_screens/page1.dart';
import 'package:fund_raiser_second/screens/intro_screens/page2.dart';
import 'package:fund_raiser_second/screens/intro_screens/page3.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import 'package:fund_raiser_second/utils/utils_toast.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../providers/permission_provider.dart';
class IntroHome extends StatefulWidget {
  const IntroHome({super.key});

  @override
  State<IntroHome> createState() => _IntroHomeState();
}

class _IntroHomeState extends State<IntroHome> {

  //Controller to keep count of pages and to check onn which page we are
  PageController controller = PageController();
  bool onLastPage= false;
  bool isCheckboxSelected = false;
  // bool isESPermissionGranted = false;
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
  // isESPermissionGranted = await permissionProvider.requestExternalStoragePermission();
  // if(isESPermissionGranted){
  //   Utils().toastMessage("External Storage Permission granted !");
  // }else{
  //   Utils().toastMessage("External Storage Permission denied !");
  // }
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

  if( !isSmsPermissionGranted || !isNotificationPermissionGranted){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text("Permissions"),
        content: const Text("""Please grant all the permissions to continue.\n\n  Our app needs permission for \n\n 1. Permission for sms for otp based Phone verification \n\n 2. Notifications permission to receive nitifications on creating campaigns \n\n All these permissions are for the purpose of enhancing user experience and providing specific functionalities."""),
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
        titleSpacing: MediaQuery.of(context).size.width/3,
        title: const Text("Welcome",textAlign: TextAlign.center,),
        backgroundColor: greenColor,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (int page){
              if(page == 2){
                setState(() {
                  onLastPage = true;
                });
              }else{
                setState(() {
                  onLastPage = false;
                });
              }
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: const Alignment(0,0.75),
            margin:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height/15),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: onLastPage ? true : false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: isCheckboxSelected,
                        onChanged: (value) {
                          setState(() {
                            isCheckboxSelected = value!;
                          });
                        },
                      ),
                      Text(
                        "I agree to the terms and conditions",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Skip button
                    GestureDetector(
                        onTap: (){
                          controller.jumpToPage(2);
                        },
                        child: const Text("Skip")),
                    //Dot indicators
                    SmoothPageIndicator(
                        controller: controller,
                        count: 3
                    ),
                    onLastPage ?
                    //Next button
                    TextButton(

                        onPressed: (){
                          isCheckboxSelected? Navigator.push(context, MaterialPageRoute(builder: (context)=>const AuthScreen1())):
                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: const Text("Terms and Conditions"),
                              content: const Text("""Please accept the terms and conditions to continue.\n\n'TAARN' collects / transmits / syncs / stores user data, including phone number, email, and name to enable essential app functionalities.\n\n Uses this information for a personalized experience and utilizing email for sending verification links to enhance account security and user authentication. \n\n The information is securely stored to improve the overall user experience and ensure the proper functioning of the app."""),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: const Text("Ok"))
                              ],
                            );
                          });
                        },
                        child: const Text("Done"))
                    // GestureDetector(
                    //     onTap: (){
                    //       Navigator.push(context, MaterialPageRoute(builder: (context)=>const AuthScreen1()));
                    //     },
                    //     child: const Text("Done"))
                        :GestureDetector(
                        onTap: (){
                          controller.nextPage(duration: const Duration(milliseconds: 700), curve: Curves.fastEaseInToSlowEaseOut);
                        },
                        child: const Text("Next")),
                  ],
                ),
              ],
            ),
          )

        ],
      )
    );
  }
}
