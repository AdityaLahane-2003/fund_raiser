import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/text_filed_area.dart';
import 'package:fund_raiser_second/utils/utils_toast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class DonateScreen extends StatefulWidget {
  final String campaignId;
  DonateScreen({required this.campaignId});

  @override
  _DonateScreenState createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _tipController = TextEditingController();
  final Razorpay _razorpay = Razorpay();

  bool _isDonating = false;

  @override
  void initState() {
    super.initState();
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
    print("Payment Success: ${response.paymentId}");

    // Show a success dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Thank You For Donating ! ! !"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                image: AssetImage('assets/thank_you.png'),
              ),
              Text(
                  "Thank you for your generous donation of Rs. ${_amountController.text.trim()}."),
              Text(
                  "Your support means a lot to us and contributes to making a positive impact on our cause."),
            ],
          ),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green[700],
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Navigate back to home screen
              },
              child: Text("Go Back", style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );

    // Update amountRaised and number of donors
    await FirebaseFirestore.instance.collection('campaigns').doc(widget.campaignId).update({
      'amountRaised': FieldValue.increment(
        int.parse(_amountController.text) + (int.parse(_tipController.text.isEmpty ? '0' : _tipController.text)),
      ),
      'amountDonors': FieldValue.increment(1),
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    Utils().toastMessage("Payment Error: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet response
    Utils().toastMessage("External Wallet: ${response.walletName}");
  }

  void _initiatePayment() {
    if (_amountController.text.isEmpty) {
      // Show an error message if the amount is empty
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a valid donation amount.'),
      ));
      return;
    }
int tipAmount = int.parse(_tipController.text.isEmpty ? '0' : _tipController.text);
    int total_amount = int.parse(_amountController.text) + tipAmount;
    var options = {
      'key': 'rzp_test_AY5O7zD0ofIwaU', // Replace with your Razorpay key
      'amount': total_amount * 100, // Convert to smallest currency unit
      'name': 'Fund Raiser',
      'description': 'Donation to the cause',
      'timeout': 60, // in seconds
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error: $e");

      // Show an error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Error initiating payment. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
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
        backgroundColor: Colors.green.shade300,
        title: Text('Donate'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display a random donation-related image
              Image(
                  image: AssetImage('assets/donate_money.png'),
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
              ),
              SizedBox(height: 16),
              TextFormFieldArea(
                prefixIcon: Icons.attach_money,
                controller: _amountController,
                textInputType: TextInputType.number,
                  title: 'Enter Amount',
              ),
              SizedBox(height: 16),
              // Add a TextField for tip amount
              TextFormFieldArea(
                controller: _tipController,
                textInputType: TextInputType.number,
                  title: 'Enter Tip Amount (Optional)',
                prefixIcon: Icons.attach_money,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green[700],
                ),
                onPressed: _isDonating
                    ? null
                    : () async {
                  setState(() {
                    _isDonating = true;
                  });
                  _initiatePayment();
                },
                child: Text('Donate Now', style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
