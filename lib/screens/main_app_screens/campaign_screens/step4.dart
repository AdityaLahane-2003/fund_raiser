import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Step4 extends StatelessWidget {
  final Function(String, String) onCoverPhotoStoryEntered;
  final Function onRaiseFundPressed;
  final Function onPrevious;

  Step4({
    required this.onCoverPhotoStoryEntered,
    required this.onRaiseFundPressed,
    required this.onPrevious,
  });

  final TextEditingController coverPhotoController = TextEditingController();
  final TextEditingController storyController = TextEditingController();

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
                controller: coverPhotoController,
                decoration: InputDecoration(labelText: 'Cover Photo URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a cover photo URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: storyController,
                maxLines: 5,
                decoration: InputDecoration(labelText: 'Story'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a story';
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
                        onCoverPhotoStoryEntered(coverPhotoController.text, storyController.text);
                        onRaiseFundPressed();
                      }
                    },
                    child: Text('Raise Fund'),
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
