
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Step3 extends StatelessWidget {
  final Function(String, String) onSchoolOrHospitalEntered;
  final Function onPrevious;
  final Function onNext;

  Step3({
    required this.onSchoolOrHospitalEntered,
    required this.onPrevious,
    required this.onNext,
  });

  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    onPrevious();
                  },
                  child: Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: () {
                    onSchoolOrHospitalEntered(nameController.text, locationController.text);
                    onNext();
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}