
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: coverPhotoController,
              decoration: InputDecoration(labelText: 'Cover Photo URL'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: storyController,
              maxLines: 5,
              decoration: InputDecoration(labelText: 'Story'),
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
                    onCoverPhotoStoryEntered(coverPhotoController.text, storyController.text);
                    onRaiseFundPressed();
                  },
                  child: Text('Raise Fund'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
