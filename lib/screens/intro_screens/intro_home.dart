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
  bool onLastPage= false;
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
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: const Alignment(0,0.75),
            child:  Row(
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
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const AuthScreen1()));
                    },
                    child: const Text("Done"))
                    :GestureDetector(
                    onTap: (){
                      controller.nextPage(duration: const Duration(milliseconds: 700), curve: Curves.fastEaseInToSlowEaseOut);
                    },
                    child: const Text("Next")),
              ],
            ),
          )

        ],
      )
    );
  }
}