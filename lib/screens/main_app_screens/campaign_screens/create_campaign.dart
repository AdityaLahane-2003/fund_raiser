import 'package:flutter/material.dart';

class CampaignCreation extends StatefulWidget {
  const CampaignCreation({super.key});

  @override
  State<CampaignCreation> createState() => _CampaignCreationState();
}

class _CampaignCreationState extends State<CampaignCreation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campaign Creation'),
      ),
      body: Center(
        child: Text('Campaign Creation'),
      ),
    );
  }
}
