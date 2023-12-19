
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
  late String selectedRelation='Myself';

  final TextEditingController photoUrlController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
            TextField(
              controller: photoUrlController,
              decoration: InputDecoration(labelText: 'Photo URL'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: genderController,
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'City'),
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
                    onPersonalInfoEntered(
                      photoUrlController.text,
                      ageController.text,
                      genderController.text,
                      cityController.text,
                    );
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