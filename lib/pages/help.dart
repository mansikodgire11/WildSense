import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HelpItem(
              question: 'How do I use the app?',
              answer:
              'You can start by navigating through the different sections using the navigation bar at the bottom of the screen. If you have any specific questions or issues, feel free to contact us.',
            ),
            SizedBox(height: 20.0),
            HelpItem(
              question: 'What if I encounter a problem with the app?',
              answer:
              'If you encounter any problems or bugs while using the app, please reach out to our support team for assistance. We are here to help!',
            ),
            SizedBox(height: 20.0),
            HelpItem(
              question: 'Where can I provide feedback?',
              answer:
              'We value your feedback! You can provide feedback directly through the app or by contacting us via email. Your input helps us improve the app for everyone.',
            ),
            SizedBox(height: 20.0),
            HelpItem(
              question: 'Is there a user guide available?',
              answer:
              'Yes, you can access the user guide by tapping on the "Help" section in the app. It provides detailed instructions on using various features.',
            ),
            SizedBox(height: 20.0),
            HelpItem(
              question: 'How do I reset my password?',
              answer:
              'To reset your password, go to the login screen and click on the "Forgot Password" link. Follow the instructions to reset your password.',
            ),
            SizedBox(height: 20.0),
            HelpItem(
              question: 'Are there any tutorials available?',
              answer:
              'Yes, we offer tutorials on our website and in the app to help you learn how to use different features and functionalities.',
            ),
          ],
        ),
      ),
    );
  }
}

class HelpItem extends StatelessWidget {
  final String question;
  final String answer;

  const HelpItem({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            answer,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }
}
