import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/button.dart';
import 'package:fund_raiser_second/screens/intro_screens/media_permission_screen.dart';
import 'package:provider/provider.dart';
import '../../components/footer.dart';
import '../../providers/permission_provider.dart';
import '../../utils/constants/color_code.dart';
import '../../utils/utils_toast.dart';

class NotificationPermissionScreen extends StatefulWidget {
  const NotificationPermissionScreen({super.key});

  @override
  State<NotificationPermissionScreen> createState() => _NotificationPermissionScreenState();
}

class _NotificationPermissionScreenState extends State<NotificationPermissionScreen> {
  bool isNotificationPermissionGranted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  checkPermission() async{
    var permissionProvider = Provider.of<PermissionProvider>(context, listen: false);
  isNotificationPermissionGranted = await permissionProvider.requestNotificationPermission();
    if(isNotificationPermissionGranted){
      Utils().toastMessage("Notifications Permission granted !");
    }else{
      Utils().toastMessage("Notifications Permission denied !");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: const [
        Footer(),
      ],
      appBar: AppBar(
        title: const Text(
          "Notification Permission",
          textAlign: TextAlign.center,
        ),
        backgroundColor: greenColor,
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
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Why we need notification permission ?\n\n When you'll create a campaign, we'll notify you about it, for this we need your permission, please grant us permission for better experience.",
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
                  title: 'Allow',
                  onTap: () async{
                  await checkPermission();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MediaPermissionScreen()));
                  }),
              Button(
                  color: secondColor,
                  title: 'Skip',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MediaPermissionScreen()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
