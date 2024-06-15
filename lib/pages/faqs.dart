import 'package:flutter/material.dart';
import 'help.dart'; // Import the HelpPage

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Text(
                      'FAQs',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              FAQItem(
                question: 'What is Wildlife Conservation AI?',
                answer:
                'Wildlife Conservation AI is an organization that leverages cutting-edge artificial intelligence technology to protect and preserve endangered species and their habitats.',
              ),
              SizedBox(height: 20.0),
              FAQItem(
                question: 'How can I get involved?',
                answer:
                'You can get involved by volunteering, donating, or spreading awareness about our cause. Visit our website for more information.',
              ),
              SizedBox(height: 20.0),
              FAQItem(
                question: 'Where can I find more information?',
                answer:
                'You can find more information on our website or by contacting us directly via email at contact@wildlifeconservationai.org.',
              ),
              SizedBox(height: 20.0),
              FAQItem(
                question: 'Is Wildlife Conservation AI a non-profit organization?',
                answer:
                'Yes, Wildlife Conservation AI is a non-profit organization dedicated to wildlife conservation efforts.',
              ),
              SizedBox(height: 20.0),
              FAQItem(
                question: 'Can I donate to Wildlife Conservation AI?',
                answer:
                'Yes, donations are welcome. Visit our website for more information on how to donate.',
              ),
              SizedBox(height: 20.0),
              FAQItem(
                question: 'How does Wildlife Conservation AI use AI technology?',
                answer:
                'Wildlife Conservation AI uses AI technology for species identification, habitat monitoring, and wildlife protection.',
              ),
              SizedBox(height: 30.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HelpPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo, // Change button color
                    padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0), // Add padding
                  ),
                  child: Text(
                    'Need more help?',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Change text color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({
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
          fontSize: 18.0, // Increase font size
          color: Colors.black, // Change text color
        ),
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            answer,
            style: TextStyle(fontSize: 16.0, color: Colors.black87), // Change text color
          ),
        ),
      ],
    );
  }
}
