// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// class DonateScreen extends StatefulWidget {
//   @override
//   _DonateScreenState createState() => _DonateScreenState();
// }
//
// class _DonateScreenState extends State<DonateScreen> {
//   final TextEditingController _amountController = TextEditingController();
//   final Razorpay _razorpay = Razorpay();
//
//   @override
//   void initState() {
//     super.initState();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     // Handle payment success
//     print("Payment Success: ${response.paymentId}");
//
//     // Show a success dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Success'),
//           content: Text('Payment successful!'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//                 Navigator.of(context).pop(); // Navigate back to home screen
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     // Handle payment failure
//     print("Payment Error: ${response.code} - ${response.message}");
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     // Handle external wallet response
//     print("External Wallet: ${response.walletName}");
//   }
//
//   void _initiatePayment() {
//     if (_amountController.text.isEmpty) {
//       // Show an error message if the amount is empty
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Please enter a valid donation amount.'),
//       ));
//       return;
//     }
//
//     var options = {
//       'key': 'rzp_test_yxBdIWmOnnZi4S', // Replace with your Razorpay key
//       'amount': int.parse(_amountController.text) * 100, // Convert to smallest currency unit
//       'name': 'Fund Raiser',
//       'description': 'Donation to the cause',
//       'timeout': 60, // in seconds
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Donate'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _amountController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Enter Amount'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: (){},
//               child: Text('Donate'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// //rzp_test_yxBdIWmOnnZi4S ID
// // qA03DmjLPLeqNUN9oehOmwti Secret