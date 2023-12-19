import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Step1 extends StatelessWidget {
  final Function(String) onCategorySelected;
  final Function(String, String) onNameEmailEntered;
  final Function onNext;

  Step1({
    required this.onCategorySelected,
    required this.onNameEmailEntered,
    required this.onNext,
  });

  final List<String> categories = ['Medical', 'Education', 'Memorial', 'Others'];
  late String selectedCategory='Medical';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: selectedCategory,
              hint: Text('Select Category'),
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                onCategorySelected(value!);
                selectedCategory = value;
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              keyboardType:TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                onNameEmailEntered(nameController.text, emailController.text);
                onNext();
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}