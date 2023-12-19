import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Step2 extends StatelessWidget {
  final Function(String) onRelationSelected;
  final Function(String, String, String, String) onPersonalInfoEntered;
  final Function onPrevious;
  final Function onNext;

  Step2({
    required this.onRelationSelected,
    required this.onPersonalInfoEntered,
    required this.onPrevious,
    required this.onNext,
  });

  final List<String> relations = ['Myself', 'My Family', 'My Friend', 'Other'];
  late String selectedRelation = 'Myself';

  final TextEditingController photoUrlController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

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
              DropdownButton<String>(
                value: selectedRelation,
                hint: Text('Select Relation'),
                items: relations.map((relation) {
                  return DropdownMenuItem<String>(
                    value: relation,
                    child: Text(relation),
                  );
                }).toList(),
                onChanged: (value) {
                  onRelationSelected(value!);
                  selectedRelation = value;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: photoUrlController,
                decoration: InputDecoration(labelText: 'Photo URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a photo URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Age'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: genderController,
                decoration: InputDecoration(labelText: 'Gender'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a gender';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a city';
                  }
                  return null;
                },
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
                      if (_formKey.currentState?.validate() ?? false) {
                        onPersonalInfoEntered(
                          photoUrlController.text,
                          ageController.text,
                          genderController.text,
                          cityController.text,
                        );
                        onNext();
                      }
                    },
                    child: Text('Next'),
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
