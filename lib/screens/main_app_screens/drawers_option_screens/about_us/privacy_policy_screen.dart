import 'package:flutter/material.dart';

import '../../../../components/footer.dart';
import '../../../../models/expandable_item.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold( persistentFooterButtons: [
      Footer(),
    ],
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: const Text('Privacy Policy'),
      ),
      body: ListView.builder(
        itemCount: expandableItems.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            leading: Text(
              '${index + 1} .',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            // backgroundColor: Colors.green.shade100,
            title: Text(expandableItems[index].title),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onExpansionChanged: (isExpanded) {
              setState(() {
                _expandedIndex = isExpanded ? index : null;
              });
            },
            initiallyExpanded: index == _expandedIndex,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(expandableItems[index].description),
              ),
              const Divider(thickness: 1,)
            ],
          );
        },
      ),
    );
  }
}

final List<ExpandableItem> expandableItems = [
  ExpandableItem(
    title: 'Collection of Personally Identifiable Information and other Information',
    subtitle: 'Subtitle 1',
    description: 'Description for Item 1...',
  ),
  ExpandableItem(
    title: 'Use of Demographic / Profile Data / Your Information',
    subtitle: 'Subtitle 2',
    description: 'Description for Item 2...',
  ),
  ExpandableItem(
      title: "Sharing of personal information",
      subtitle: 'Subtitle 3',
      description:"3"
  ),
  ExpandableItem(
      title: "Links to Other Sites",
      subtitle: 'Subtitle 3',
      description:"3"
  ),
  ExpandableItem(
      title: "Security Precautions / Security Breach",
      subtitle: 'Subtitle 3',
      description:"3"
  ),
  ExpandableItem(
      title: "Review of Information / Account Deactivation / Removal of Information",
      subtitle: 'Subtitle 3',
      description:"3"
  ),
  ExpandableItem(
      title: "Advertisements on Hrtaa.org",
      subtitle: 'Subtitle 3',
      description:"3"
  ),
  ExpandableItem(
      title: "Your Consent",
      subtitle: 'Subtitle 3',
      description:"3"
  ),
  ExpandableItem(
      title: "Retention of Information",
      subtitle: 'Subtitle 3',
      description:"3"
  ),
  // Add more items as needed
];
