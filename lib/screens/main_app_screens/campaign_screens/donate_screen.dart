import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/text_filed_area.dart';
import 'package:fund_raiser_second/providers/donationData_Provider.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/display_campaigns_screen/campaign_list.dart';
import 'package:fund_raiser_second/screens/main_app_screens/home_dashboard.dart';
import 'package:fund_raiser_second/utils/utils_toast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../components/button.dart';
import '../../../firebase_services/campaign_services/donation_services.dart';
import '../../../utils/constants/color_code.dart';

class DonateScreen extends StatefulWidget {
  final String campaignId;

  const DonateScreen({super.key, required this.campaignId});

  @override
  _DonateScreenState createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  late TextEditingController _amountController;
  late TextEditingController _tipController;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final Razorpay _razorpay = Razorpay();
  final _formKey = GlobalKey<FormState>();
  late DonationService donationService;
  DonationData donationData = DonationData();
  int? _selectedAmount = 2000;
  double? _selectedTipPercentage = 0.1;
  bool isAnonymous = false;
  bool isUserLoggedIn = false;
  late User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    isUserLoggedIn = currentUser != null;
    _amountController = TextEditingController(text: _selectedAmount.toString());
    _tipController = TextEditingController(
        text: (_selectedAmount! * _selectedTipPercentage!).toStringAsFixed(0));
    donationService = DonationService(widget.campaignId);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Handle payment success
    Utils().toastMessage("Payment Success: ${response.paymentId}");
    donationData.phone = phoneController.text.trim();
    donationData.email = emailController.text.trim();
    donationData.name = nameController.text.trim();
    donationData.address = addressController.text.trim();
    donationData.amountDonated = int.parse(_amountController.text);
    donationData.tipDonated =
        int.parse(_tipController.text.isEmpty ? '0' : _tipController.text);
    await donationService.createDonation(donationData);
    isUserLoggedIn
        ? Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomeDashboard()))
        : Navigator.push(
            context, MaterialPageRoute(builder: (context) => const CampaignsList()));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Transaction Successful ! ! !"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Image(
                image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/taarn-690cb.appspot.com/o/images%2FDonation_Successful_screen.jpeg-removebg-preview.png?alt=media&token=89768ad1-8185-4b14-b098-5a3d877de1d7"),
              ),
              Text(
                  "Thank you for your generous donation of Rs. ${_amountController.text.trim()}."),
              const Text(
                  "Your support means a lot to us and contributes to making a positive impact on our cause.\n Congratulations! Your donation has been successfully processed."),
            ],
          ),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: secondColor,
              ),
              onPressed: () {
                isUserLoggedIn
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeDashboard()))
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CampaignsList()));
              },
              child: const Text(
                "Go Back",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    Utils()
        .toastMessage("Payment Error: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet response
    Utils().toastMessage("External Wallet: ${response.walletName}");
  }

  void _initiatePayment() {
    int tipAmount =
        int.parse(_tipController.text.isEmpty ? '0' : _tipController.text);
    int totalAmount = int.parse(_amountController.text) + tipAmount;
    var options = {
      'key': 'rzp_test_AY5O7zD0ofIwaU', // Replace with your Razorpay key
      'amount': totalAmount * 100, // Convert to smallest currency unit
      'name': 'Fund Raiser',
      'description': 'Donation to the cause',
      'timeout': 60, // in seconds
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      Utils().toastMessage("Error Occured ! Please try after some time !");
      // Utils().toastMessage("Error: $e");

      // Show an error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Error initiating payment. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        title: const Text('Donate'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display a random donation-related image
                Image(
                  height: 200,
                  image: const NetworkImage("https://firebasestorage.googleapis.com/v0/b/taarn-690cb.appspot.com/o/images%2Fdonate_money-removebg-preview.png?alt=media&token=8ac697d2-ce9e-4ce8-ac6f-02a9c6c55df2"),
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      activeColor: greenColor,
                      value: isAnonymous,
                      onChanged: (value) {
                        setState(() {
                          isAnonymous = value ?? false;
                          // If anonymous is selected, clear the name field
                          if (isAnonymous) {
                            nameController.text = 'Anonymous';
                          } else {
                            nameController.clear();
                          }
                        });
                      },
                    ),
                    const Text('Donate Anonymously'),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormFieldArea(
                  enabled: !isAnonymous,
                  prefixIcon: Icons.person,
                  controller: nameController,
                  textInputType: TextInputType.text,
                  title: 'Enter Name',
                  validator: (value) {
                    if (value!.isEmpty && !isAnonymous) {
                      return 'Please enter your name';
                    } else if (isAnonymous) {
                      return null;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormFieldArea(
                  prefixIcon: Icons.email,
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  title: 'Enter Email',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email';
                    } else if (!value.contains('@')) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormFieldArea(
                  prefixIcon: Icons.phone,
                  controller: phoneController,
                  textInputType: TextInputType.number,
                  title: 'Enter Phone',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone';
                    } else if (value.length < 10) {
                      return 'Please enter valid phone';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormFieldArea(
                  prefixIcon: Icons.location_city,
                  controller: addressController,
                  textInputType: TextInputType.streetAddress,
                  title: 'Enter Address',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Donation Amount:',style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),),
                    const SizedBox(width: 16),
                    DropdownButton<int>(
                      value: _selectedAmount,
                      onChanged: (value) {
                        setState(() {
                          _selectedAmount = value;
                          _amountController.text = value.toString();
                          _tipController.text =
                              (value! * _selectedTipPercentage!)
                                  .toStringAsFixed(0);
                        });
                      },
                      items: [1000, 2000, 5000].map((amount) {
                        return DropdownMenuItem<int>(
                          value: amount,
                          child: Text('$amount INR'),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  onChanged: (amount) {
                    // Calculate tip based on the entered amount
                    double enteredAmount = double.tryParse(amount) ?? 0.0;
                    double tipPercentage = _selectedTipPercentage ?? 0.0;
                    double calculatedTip = enteredAmount * tipPercentage;
                    // Update the tip amount in the tip controller
                    setState(() {
                      _tipController.text = calculatedTip.toStringAsFixed(0);
                    });
                  },
                  decoration: InputDecoration(
                    // errorStyle: const TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
                    // hintStyle: const TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                    labelText: 'Enter Amount',
                    prefixIcon: const Icon(Icons.currency_rupee),
                    floatingLabelStyle: TextStyle(color: greenColor),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 2.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 2.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Add a DropdownButton for tip percentage
                Row(
                  children: [
                    const Text('Support Surcharge: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Support Surcharge'),
                              content: const Text(
                                  'Consider adding a little extra as a "Support Surcharge" to help sustain our platform and extend our impact even further. Your additional contribution will play a crucial role in supporting ongoing initiatives and ensuring the success of future campaigns.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                        child: const Icon(Icons.info_outline,
                            color: Colors.grey, size: 16)),
                    const SizedBox(width: 16),
                    DropdownButton<double>(
                      value: _selectedTipPercentage,
                      onChanged: (value) {
                        setState(() {
                          _selectedTipPercentage = value;
                          _tipController.text =
                              (int.parse(_amountController.text) * value!)
                                  .toStringAsFixed(0);
                        });
                      },
                      items: [0.0, 0.02, 0.05, 0.1, 0.18, 0.25]
                          .map((tipPercentage) {
                        return DropdownMenuItem<double>(
                          value: tipPercentage,
                          child: Text('${(tipPercentage * 100).toInt()}% Tip'),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormFieldArea(
                  controller: _tipController,
                  textInputType: TextInputType.number,
                  title: 'Enter Tip Amount (Optional)',
                  prefixIcon: Icons.currency_rupee,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter tip amount';
                    } else if (int.parse(value) < 10) {
                      return "Please give at least 10 Rs. Tip";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Button(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _initiatePayment();
                    }
                  },
                title: 'Donate Now',
                  color: secondColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
