import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/button.dart';
import 'package:fund_raiser_second/screens/auth_screens/auth_screen1.dart';
import 'package:provider/provider.dart';
import '../../components/footer.dart';
import '../../providers/permission_provider.dart';
import '../../utils/constants/color_code.dart';
import '../../utils/utils_toast.dart';

class MediaPermissionScreen extends StatefulWidget {
  const MediaPermissionScreen({super.key});

  @override
  State<MediaPermissionScreen> createState() => _MediaPermissionScreenState();
}

class _MediaPermissionScreenState extends State<MediaPermissionScreen> {
  bool isPhotoPermissionGranted = false;
  bool isVideoPermissionGranted = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: const [
        Footer(),
      ],
      appBar: AppBar(
        title: const Text(
          "Media Permission",
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
                  "Why we need Photos/videos permission ?\n\nOur app allows you to create campaigns and share your stories through photos, videos, and documents. To enable this functionality, we require access to your device's external storage to upload and manage these media files. Also, for profile picture photo is needed ! \n\nPlease grant us permission for better experience.",
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
                            builder: (context) => const AuthScreen1()));
                  }),
              Button(
                  color: secondColor,
                  title: 'Skip',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuthScreen1()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
