import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/text_filed_area.dart';

import '../../../../components/button.dart';

class Step1 extends StatefulWidget {
  final Function(String) onCategorySelected;
  final Function(String, String, int, DateTime) onNameEmailEntered;
  final Function onNext;

  const Step1({super.key,
    required this.onCategorySelected,
    required this.onNameEmailEntered,
    required this.onNext,
  });

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  final List<String> categories = ['Medical', 'Education', 'Memorial', 'Others'];

  late String selectedCategory = 'Medical';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  DateTime? selectedDate; // Add DateTime variable

  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

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
              const Text(
                'Select Cause',
              ),
              DropdownButton<String>(
                borderRadius: BorderRadius.circular(12.0),
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 36.0,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                value: selectedCategory,
                hint: const Text('Select Category'),
                isExpanded: true,
                items: categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Center(
                      child: Text(
                        category,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  widget.onCategorySelected(value!);
                  selectedCategory = value;
                  setState(() {});
                },
              ),

              const SizedBox(height: 16),
              TextFormFieldArea(
                prefixIcon: Icons.person,
                controller: nameController,
                  title: 'Name',
                textInputType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormFieldArea(
                prefixIcon: Icons.email,
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                  title: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  } else if (!RegExp(
                      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormFieldArea(
                prefixIcon: Icons.money,
                controller: amountController,
                textInputType: TextInputType.number,
                  title: 'Rs. Amount',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Button(
                    onTap: () => _selectDate(context),
                    title: 'Select End Date',
                    color: Colors.blue.shade700,
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Text(
                      selectedDate != null
                          ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                          : 'No Date Selected',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
             Button(
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    widget.onNameEmailEntered(
                      nameController.text,
                      emailController.text,
                      int.parse(amountController.text),
                      selectedDate ?? DateTime.now().add(const Duration(days: 30)),
                    );
                    widget.onNext();
                  }
                },
                title: 'Next',
                color: Colors.green.shade700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
