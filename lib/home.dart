import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/auth_screens/auth_screen1.dart';
import 'package:fund_raiser_second/screens/auth_screens/login.dart';
import 'package:fund_raiser_second/screens/intro_screens/page1.dart';
import 'package:fund_raiser_second/screens/intro_screens/page2.dart';
import 'package:fund_raiser_second/screens/intro_screens/page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //Controller to keep count of pages and to ckeck onn which page we are
  PageController controller = PageController();
  bool onLastPage= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            alignment: Alignment(0,0.75),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Skip button
                GestureDetector(
                    onTap: (){
                      controller.jumpToPage(2);
                    },
                    child: Text("Skip")),
                //Dot indicators
                SmoothPageIndicator(
                    controller: controller,
                    count: 3
                ),
                onLastPage ?
                //Next button
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthScreen1()));
                    },
                    child: Text("Done"))
                    :GestureDetector(
                    onTap: (){
                      controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                    },
                    child: Text("Next")),
              ],
            ),
          )

        ],
      )
    );
  }
}