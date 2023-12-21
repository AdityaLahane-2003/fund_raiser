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
              TextFormField(
                controller: nameController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: 'School/Hospital Name',
                  floatingLabelStyle: TextStyle(color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'If not needed Eter NA';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: locationController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: 'Address',
                  floatingLabelStyle: TextStyle(color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'If not needed Eeter NA';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () {
                      onPrevious();
                    },
                    child: Text('Previous',style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        onSchoolOrHospitalEntered(nameController.text, locationController.text);
                        onNext();
                      }
                    },
                    child: Text('Next',style: TextStyle(fontSize: 18, color: Colors.white)),
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
