import 'package:flutter/material.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';

class TextFormFieldArea extends StatelessWidget {
  final String title;
  final Color color;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? suffix;
  final bool obscureText;
  final bool enabled;
  final void Function(String)? onChanged;
  final int maxLines;

  const TextFormFieldArea({
    super.key,
    required this.title,
    required this.controller,
    required this.textInputType,
    this.color = Colors.orange,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.obscureText=false,
    this.enabled=true,
    this.onChanged,
    this.maxLines=1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        suffix: suffix,
        errorStyle: const TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
        hintStyle: const TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
        labelText: title,
        floatingLabelStyle: TextStyle(color: greenColor),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.black, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
      validator: validator,
      onChanged: onChanged,
      maxLines: maxLines,
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // margin: const EdgeInsets.only(bottom:5.0),
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.11),
//             spreadRadius: 0.0,
//             blurRadius: 40,
//             // offset: const Offset(0, 0.5), // changes position of shadow
//           ),
//         ],
//       ),
//       child: TextFormField(
//         enabled: enabled,
//         controller: controller,
//         keyboardType: textInputType,
//         obscureText: obscureText,
//         cursorColor: Colors.black,
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.white,
//           prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
//           suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
//           suffix: suffix,
//           errorStyle: const TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
//           hintStyle: const TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
//           labelText: title,
//           floatingLabelStyle: TextStyle(color: greenColor),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15.0),
//             borderSide: BorderSide.none,
//           ),
//           // focusedBorder: OutlineInputBorder(
//           //   borderRadius: BorderRadius.circular(12.0),
//           //   borderSide: const BorderSide(color: Colors.black, width: 2.0),
//           // ),
//           // enabledBorder: OutlineInputBorder(
//           //   borderRadius: BorderRadius.circular(12.0),
//           //   borderSide: const BorderSide(color: Colors.black, width: 1.5),
//           // ),
//           // errorBorder: OutlineInputBorder(
//           //   borderRadius: BorderRadius.circular(12.0),
//           //   borderSide: const BorderSide(color: Colors.red, width: 2.0),
//           // ),
//           // focusedErrorBorder: OutlineInputBorder(
//           //   borderRadius: BorderRadius.circular(12.0),
//           //   borderSide: const BorderSide(color: Colors.red, width: 2.0),
//           // ),
//         ),
//         validator: validator,
//         onChanged: onChanged,
//         maxLines: maxLines,
//       ),
//     );
//   }
// }
