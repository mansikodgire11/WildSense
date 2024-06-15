import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40.0), // Add top padding to center the text
              child: Center(
                child: Text(
                  'Terms and Conditions',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'By using this application, you agree to comply with and be bound by the following terms and conditions:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              '1. Your use of the application is at your sole risk. The application is provided on an "as is" and "as available" basis.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              '2. The content of the application is for general information purposes only and is subject to change without notice.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              '3. We reserve the right to modify or discontinue the application at any time without prior notice.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              '4. You must not misuse the application. Misuse includes, but is not limited to, introducing viruses, trojans, worms, logic bombs, or other material that is malicious or technologically harmful.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              '5. We do not guarantee that the application will be uninterrupted, timely, secure, or error-free.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              '6. Your use of any information or materials on the application is entirely at your own risk, for which we shall not be liable. It shall be your own responsibility to ensure that any products, services, or information available through this application meet your specific requirements.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              '7. Unauthorized use of this application may give rise to a claim for damages and/or be a criminal offense.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              '8. From time to time, this application may also include links to other applications or websites. These links are provided for your convenience to provide further information. They do not signify that we endorse the application(s) or website(s). We have no responsibility for the content of the linked application(s) or website(s).',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

