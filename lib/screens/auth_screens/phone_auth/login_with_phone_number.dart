import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/text_filed_area.dart';
import 'package:fund_raiser_second/screens/auth_screens/phone_auth/verify_code.dart';
import '../../../components/button.dart';
import '../../../components/round_button.dart';
import '../../../utils/utils_toast.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  final String comingFrom;
  const LoginWithPhoneNumber({Key? key, required this.comingFrom}) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    backgroundImage: const AssetImage('assets/logo.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        showCountryPicker(
                          context: context,
                          //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                          exclude: <String>['KN', 'MF'],
                          favorite: <String>['IN'],
                          //Optional. Shows phone code before the country name.
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            setState(() {
                              selectedCountryCode = '+${country.phoneCode}';
                              selectedCountry = '${country.flagEmoji} ${country.name}';
                            });
                          },
                          // Optional. Sets the theme for the country list picker.
                          countryListTheme: CountryListThemeData(
                            // Optional. Sets the border radius for the bottomsheet.
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            ),
                            // Optional. Styles the search field.
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
                            // Optional. Styles the text in the search field
                            searchTextStyle: const TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(selectedCountry),
                          const SizedBox(width: 8.0,),
                          Text(selectedCountryCode),
                          const SizedBox(width: 8.0,),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormFieldArea(
                    prefixIcon: Icons.phone,
                      controller: phoneNumberController,
                      textInputType: TextInputType.phone,
                        title: 'Enter phone number',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter phone number';
                        }else if(value.length<10){
                          return 'Enter valid phone number';
                        }
                        return null;
                      },
                    ),
                ],
              ),
            ),
                const SizedBox(height: 50,),
                Button(
                  color: Colors.green.shade700,
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
                        Utils().toastMessage(e.toString());
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
                        Utils().toastMessage(e.toString());
                        setState(() {
                          loading = false ;
                        });
                      });
                }})

              ],
            ),
          ),
        ],
      ),
    );
  }
}