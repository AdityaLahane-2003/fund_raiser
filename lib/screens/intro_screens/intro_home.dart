import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/footer.dart';
import 'package:fund_raiser_second/screens/auth_screens/auth_screen1.dart';
import 'package:fund_raiser_second/screens/intro_screens/page1.dart';
import 'package:fund_raiser_second/screens/intro_screens/page2.dart';
import 'package:fund_raiser_second/screens/intro_screens/page3.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroHome extends StatefulWidget {
  const IntroHome({super.key});

  @override
  State<IntroHome> createState() => _IntroHomeState();
}

class _IntroHomeState extends State<IntroHome> {
  //Controller to keep count of pages and to check onn which page we are
  PageController controller = PageController();
  bool onLastPage = false;
  bool isCheckboxSelected_1 = false;
  bool isCheckboxSelected_2 = false;

  void showTermsDialog(){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
                "Terms and Conditions"),
            content: const Text(
                """Please accept the terms and conditions to continue.\n\n'TAARN' collects / transmits / syncs / stores user data, including phone number, email, and name to enable essential app functionalities.\n\n Uses this information for a personalized experience and utilizing email for sending verification links to enhance account security and user authentication. \n\n The information is securely stored to improve the overall user experience and ensure the proper functioning of the app."""),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Ok"))
            ],
          );
        });
  }
void showPermissionDialog(){
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
              "Permissions"),
          content:
          const SingleChildScrollView(
            child: Text("""Dear User,

We are excited to welcome you to our app! To provide you with the best experience and ensure seamless functionality, we kindly ask for your permission to access certain features on your device.

1. Photos, Videos, and Files: Our app allows you to create campaigns and share your stories through photos, videos, and documents. To enable this functionality, we require access to your device's external storage to upload and manage these media files. Rest assured, we respect your privacy and will only access files necessary for app usage.

2. SMS Permissions: For security purposes, we use SMS verification to authenticate your account during sign-up and login processes. This ensures that your account remains secure and protected from unauthorized access. We assure you that we will not misuse your phone number or send unsolicited messages.

3. Notifications: Stay updated and informed about your campaigns' progress, donations, and other important updates through notifications. We strive to keep you engaged and informed about activities related to your campaigns and the app.

Your privacy and security are our top priorities. We adhere to strict data protection measures and only collect information essential for app functionality. Your personal data will never be shared with third parties without your consent.

Thank you for choosing our app. By granting these permissions, you allow us to deliver a seamless and personalized experience tailored to your needs. Should you have any concerns or questions regarding permissions or privacy, please feel free to contact us.

Best regards,
TAARN Team"""),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(
                      context);
                },
                child:
                const Text("Ok")),
            TextButton(
                onPressed: () {
                  AppSettings
                      .openAppSettings();
                },
                child: const Text(
                    "Open Settings ! "))
          ],
        );
      });
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
        body: Stack(
          children: [
            PageView(
              controller: controller,
              onPageChanged: (int page) {
                if (page == 2) {
                  setState(() {
                    onLastPage = true;
                  });
                } else {
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
              alignment: const Alignment(0, 0.75),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: onLastPage ? true : false,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Checkbox(
                              value: isCheckboxSelected_1,
                              onChanged: (value) {
                                setState(() {
                                  isCheckboxSelected_1 = value!;
                                });
                              },
                            ),
                            Flexible(
                              child: GestureDetector(
                                child: const Text(
                                  "I agree to the Terms & Conditions (𝑽𝒊𝒆𝒘)",
                                  style: TextStyle(fontSize: 12),
                                ),
                                onTap:(){
                                  showTermsDialog();
                                }
                              ),
                            ),
                            Checkbox(
                              value: isCheckboxSelected_2,
                              onChanged: (value) {
                                setState(() {
                                  isCheckboxSelected_2 = value!;
                                });
                              },
                            ),
                            Flexible(
                              child: GestureDetector(
                                child: const Text(
                                  "I agree to the permissions (𝑽𝒊𝒆𝒘)",
                                  style: TextStyle(fontSize: 12),
                                ),
                                onTap: (){
                                  showPermissionDialog();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Skip button
                      GestureDetector(
                          onTap: () {
                            controller.jumpToPage(2);
                          },
                          child: const Text("Skip")),
                      //Dot indicators
                      SmoothPageIndicator(controller: controller, count: 3),
                      onLastPage
                          ?
                          //Next button
                          TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: greenColor,
                                onSurface: Colors.grey,
                              ),
                              onPressed: () {
                                isCheckboxSelected_1 && isCheckboxSelected_2
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AuthScreen1()))
                                    : !isCheckboxSelected_1 &&
                                            isCheckboxSelected_2
                                        ?
                                showTermsDialog()
                                        : isCheckboxSelected_1 &&
                                                !isCheckboxSelected_2
                                            ? showPermissionDialog()
                                            : showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text("Alert"),
                                                    content: const Text(
                                                        "Please agree to the permissions and terms and conditions to continue, which are necessary for the proper functioning of the app."),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const Text("Ok"))
                                                    ],
                                                  );
                                                });
                              },
                              child: const Text("Get Started"))
                          // GestureDetector(
                          //     onTap: (){
                          //       Navigator.push(context, MaterialPageRoute(builder: (context)=>const AuthScreen1()));
                          //     },
                          //     child: const Text("Done"))
                          : GestureDetector(
                              onTap: () {
                                controller.nextPage(
                                    duration: const Duration(milliseconds: 700),
                                    curve: Curves.fastEaseInToSlowEaseOut);
                              },
                              child: const Text("Next")),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
