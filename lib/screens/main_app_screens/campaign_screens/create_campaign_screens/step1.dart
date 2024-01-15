import 'package:flutter/material.dart';
import 'package:fund_raiser_second/components/text_filed_area.dart';
import 'package:fund_raiser_second/providers/fundRaiserData_Provider.dart';
import 'package:fund_raiser_second/providers/fundraiser_data_provider.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import 'package:provider/provider.dart';

import '../../../../components/button.dart';

class Step1 extends StatefulWidget {
  final Function(String) onCategorySelected;
  final Function(String) onStatusSelected;
  final Function(String, String, int, DateTime) onNameEmailEntered;
  final Function onNext;

  const Step1({super.key,
    required this.onStatusSelected,
    required this.onCategorySelected,
    required this.onNameEmailEntered,
    required this.onNext,
  });

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  final List<String> categories = ['Medical', 'Education', 'Memorial', 'Others'];
  final List<String> statuses = ['Urgent Need of Funds',
    'Needs funds for the near future',
  'Need funds for the upcoming event'];

  late String selectedCategory = 'Medical';
  late String selectedStatus = 'Urgent Need of Funds';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  DateTime? selectedDate;
  FundraiserData fundraiserData = FundraiserData();
  late FundraiserDataProvider fundraiserDataProvider;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    fundraiserDataProvider = Provider.of<FundraiserDataProvider>(context, listen: false);
    selectedCategory = fundraiserDataProvider.fundraiserData.category;
    selectedStatus = fundraiserDataProvider.fundraiserData.status;
    selectedDate = fundraiserDataProvider.fundraiserData.dateEnd;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Consumer<FundraiserDataProvider>(
            builder: (context, fundRaiserData, child) {
              WidgetsBinding.instance.addPostFrameCallback((_){
                nameController.text = fundRaiserData.fundraiserData.name;
                emailController.text = fundRaiserData.fundraiserData.email;
                amountController.text =
                    fundRaiserData.fundraiserData.amountGoal.toString();
              });
              return  Column(
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

                const SizedBox(height: 16), const Text(
                  'Select Status of your Financial Need',
                ),
                DropdownButton<String>(
                  borderRadius: BorderRadius.circular(12.0),
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 36.0,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  value: selectedStatus,
                  hint: const Text('Select Category'),
                  isExpanded: true,
                  items: statuses.map((category) {
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
                    setState(() {
                      selectedStatus = value;
                    });
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
                  onChanged: (value) {
                    fundRaiserData.updateName(value);
                  },
                ),
                const SizedBox(height: 16),
                TextFormFieldArea(
                  prefixIcon: Icons.phone,
                  controller: emailController,
                  textInputType: TextInputType.number,
                    title: 'Phone Number',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone';
                    } else if (value.length != 10) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    fundRaiserData.updateEmail(value);
                  },
                ),
                const SizedBox(height: 16),
                TextFormFieldArea(
                  prefixIcon: Icons.currency_rupee,
                  controller: amountController,
                  textInputType: TextInputType.number,
                    title: 'Rs. Amount',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter amount';
                    }else if (int.parse(value) < 1) {
                      return 'Please enter a valid amount';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    fundRaiserData.updateAmount(int.parse(value));
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Button(
                      onTap: () => _selectDate(context),
                      title: 'Select End Date',
                      color: secondColor,
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Text(
                        selectedDate != null
                            ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                            : 'Select date till\nwhich you need funds',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                        )
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
               Button(
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      fundRaiserData.updateFundraiserDataStep1(
                          nameController.text,
                          selectedDate ?? DateTime.now().add(const Duration(days: 30)),
                          selectedCategory,
                          selectedStatus,);
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
                  color: greenColor,
                ),
              ],
            );
            },
          ),
        ),
      ),
    );
  }
}
