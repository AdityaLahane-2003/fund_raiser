import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/text_filed_area.dart';

import '../../../components/button.dart';

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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormFieldArea(
                prefixIcon: Icons.school_outlined,
                controller: nameController,
                  title: 'School/Hospital Name',
                textInputType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'If not needed Eter NA';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormFieldArea(
                prefixIcon: Icons.location_on_outlined,
                controller: locationController,
                  title: 'Address',
                textInputType: TextInputType.streetAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'If not needed Enter NA';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Button(
                    onTap: () {
                      onPrevious();
                    },
                    title: 'Previous',
                   color: Colors.blue.shade700,
                  ), Button(
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        onSchoolOrHospitalEntered(nameController.text, locationController.text);
                        onNext();
                      }
                    },
                    title: 'Next',
                   color: Colors.green.shade700,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
