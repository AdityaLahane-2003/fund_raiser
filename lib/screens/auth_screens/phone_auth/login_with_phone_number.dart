import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/footer.dart';
import 'package:fund_raiser_second/components/text_filed_area.dart';
import 'package:fund_raiser_second/screens/auth_screens/email_auth/signup_screen.dart';
import 'package:fund_raiser_second/screens/auth_screens/phone_auth/verify_code.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
// import 'package:provider/provider.dart';
import '../../../components/button.dart';
// import '../../../providers/permission_provider.dart';
import '../../../utils/utils_toast.dart';
import '../email_auth/login_screen.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  final String comingFrom;
  const LoginWithPhoneNumber({super.key, required this.comingFrom});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {

  bool loading = false ;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance ;
  String selectedCountryCode = '+91'; // Default country code
  String selectedCountry = 'India'; // Default country code
  final _formKey = GlobalKey<FormState>();
  bool isSmsPermissionGranted = false;

  void initState() {
    super.initState();
    // requestSmsPermission();
  }

  // Future<void> requestSmsPermission() async {
  //   var permissionProvider = Provider.of<PermissionProvider>(context, listen: false);
  //   isSmsPermissionGranted = await permissionProvider.smsPermissionGranted;
  //   if(!isSmsPermissionGranted){
  //     Utils().toastMessage("SMS Permission Not granted !");
  //     await permissionProvider.requestSmsPermission();
  //   }
  // }

  String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        return 'Invalid verification code.';
      case 'ERROR_SESSION_EXPIRED':
        return 'Session expired. Please try again.';
      case 'ERROR_QUOTA_EXCEEDED':
        return 'Quota exceeded. Please try again later.';
      default:
        return 'An error occurred. Please try again.';
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: const [
        Footer(),
      ],
      appBar: AppBar(
        backgroundColor: greenColor,
        title: Text( widget.comingFrom=='signup'?"SignUp":'Login'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
            Column(
              children: [
                const SizedBox(height: 80,),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/logo.png'),
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Combined Country Picker and Text Field
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  // Country Picker
                                  GestureDetector(
                                    onTap: () {
                                      showCountryPicker(
                                        context: context,
                                        exclude: <String>['KN', 'MF'],
                                        favorite: <String>['IN'],
                                        showPhoneCode: true,
                                        onSelect: (Country country) {
                                          setState(() {
                                            selectedCountryCode = '+${country.phoneCode}';
                                            selectedCountry = '${country.countryCode}';
                                          });
                                        },
                                        countryListTheme: CountryListThemeData(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(40.0),
                                            topRight: Radius.circular(40.0),
                                          ),
                                          inputDecoration: InputDecoration(
                                            labelText: 'Search',
                                            hintText: 'Start typing to search',
                                            prefixIcon: const Icon(Icons.search),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: const Color(0xFF8C98A8).withOpacity(0.2),
                                              ),
                                            ),
                                          ),
                                          searchTextStyle: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 18,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                      child: Row(
                                        children: [
                                          Text(selectedCountryCode),
                                          const SizedBox(width: 8.0),
                                          Text(selectedCountry),
                                          const Icon(Icons.arrow_drop_down),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Vertical line separator
                                  Container(
                                    width: 1,
                                    height: 40, // Adjust the height as needed
                                    color: Colors.grey, // You can change the color as needed
                                  ),
                                  // Text Field
                                  Expanded(
                                    child: TextFormField(
                                      controller: phoneNumberController,
                                      keyboardType: TextInputType.phone,
                                      decoration: const InputDecoration(
                                        hintText: '  Enter phone number',
                                        border: InputBorder.none,
                                      ),
                                        validator:  (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter phone number';
                                        } else if (value.length < 10) {
                                          return 'Enter valid phone number';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                const SizedBox(height: 50,),
                Button(
                    color: greenColor,
                    title: widget.comingFrom=='signup'?"SignUp":'Login',
                    loading: loading, onTap: (){
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      loading = true ;
                    });
                    auth.verifyPhoneNumber(
                        phoneNumber: selectedCountryCode+phoneNumberController.text,
                        verificationCompleted: (_){
                          setState(() {
                            loading = false ;
                          });
                        },
                        verificationFailed: (e){
                          setState(() {
                            loading = false ;
                          });
                          Utils().toastMessage(getErrorMessage(e.code));
                        },
                        codeSent: (String verificationId , int? token){
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => VerifyCodeScreen(verificationId:verificationId ,phone:phoneNumberController.text.trim(),comingFrom: widget.comingFrom,)));
                          setState(() {
                            loading = false ;
                          });
                        },
                        codeAutoRetrievalTimeout: (e){
                          Utils().toastMessage("Code autoretrieval timeout occured");
                          setState(() {
                            loading = false ;
                          });
                        });
                  }}),
                const SizedBox(height: 15,),
                widget.comingFrom=='signup'?Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an acoount?"),
                    TextButton(onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder:(context) => const LoginWithPhoneNumber(comingFrom: "login",))
                      );
                    },
                        child: Text('Login',style: TextStyle(fontSize:17,color: Colors.blue.shade700),))
                  ],
                ):
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginWithPhoneNumber(comingFrom: "signup",)));
                        },
                        child: Text('Sign up',style: TextStyle(fontSize:18.0,color: Colors.blue.shade700),))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                widget.comingFrom=='signup'?Button(
                  title: '   SignUp With Email   ',
                  color: secondColor,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                  },):Button(
                  title: '   Login With Email   ',
                  color: secondColor,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },),
              ],
            ),
          ),
        ],
      ),
    );
  }
}