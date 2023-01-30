// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class privacyPolicyPage extends StatefulWidget {
  const privacyPolicyPage({super.key});

  @override
  State<privacyPolicyPage> createState() => _privacyPolicyPageState();
}

class _privacyPolicyPageState extends State<privacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'Privacy Notice',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'We know that you care how information about you is used and shared, and we appreciate your trust that we will do so carefully and sensibly. This Privacy Notice describes how Amazon Seller Services Private Limited and its affiliates including Amazon.com, Inc. (collectively "Amazon") collect and process your personal information through Amazon websites, devices, products, services, online marketplace and applications that reference this Privacy Notice (together "Amazon Services"). By using Amazon Services you agree to our use of your personal information (including sensitive personal information) in accordance with this Privacy Notice, as may be amended from time to time by us at our discretion. You also agree and consent to us collecting, storing, processing, transferring, and sharing your personal information (including sensitive personal information) with third parties or service providers for the purposes set out in this Privacy Notice. Personal information subject to this Privacy Notice will be collected and retained by Amazon, with a registered office at 8th floor, Brigade Gateway 26/1 Dr. Rajkumar Road Bangalore Karnataka 560055 India.',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
