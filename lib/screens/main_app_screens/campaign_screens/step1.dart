import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Step1 extends StatefulWidget {
  final Function(String) onCategorySelected;
  final Function(String, String, int, DateTime) onNameEmailEntered;
  final Function onNext;

  Step1({
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
              Text(
                'Select Cause',
              ),
              DropdownButton<String>(
                borderRadius: BorderRadius.circular(12.0),
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 36.0,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                value: selectedCategory,
                hint: Text('Select Category'),
                isExpanded: true,
                items: categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
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

              SizedBox(height: 16),
              TextFormField(
                controller: nameController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: 'Name',
                  floatingLabelStyle: TextStyle(color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: 'Email',
                  floatingLabelStyle: TextStyle(color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
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
              SizedBox(height: 16),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: 'Rs. Amount',
                  floatingLabelStyle: TextStyle(color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () => _selectDate(context),
                    child: Text('Select End Date', style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                  SizedBox(width: 16),
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
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    widget.onNameEmailEntered(
                      nameController.text,
                      emailController.text,
                      int.parse(amountController.text),
                      selectedDate ?? DateTime.now().add(Duration(days: 30)),
                    );
                    widget.onNext();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
