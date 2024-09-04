
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch the current theme data
    final theme = Theme.of(context);

    return Scaffold(
     appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Privacy",
                style: TextStyle(
                  color: Colors.white, // White color for "World"
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              TextSpan(
                text: "Policy",
                style: TextStyle(
                  color: Colors.orange, // Orange color for "Pulse"
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 80, 2, 2),
        iconTheme: IconThemeData(
          color:
              Colors.white, // This will change the color of the icons to white
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textAlign: TextAlign.center,
              'World Pulse',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              '1. Introduction',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Welcome to WorldPulse. We are committed to protecting your personal information and your right to privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application, WorldPulse. Please read this policy carefully.',
            ),
            SizedBox(height: 16.0),
            Text(
              '2. Information We Collect',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              '2.1. Personal Information\n\n'
              'We do not collect personally identifiable information from you unless you voluntarily provide it. The types of personal information you might provide include:\n\n'
              '• Contact details (e.g., email address)\n'
              '• User feedback and support requests\n',
            ),
            SizedBox(height: 8.0),
            Text(
              '2.2. Usage Data\n\n'
              'We may collect information about how you use our app, including:\n\n'
              '• Device information (e.g., operating system, device type)\n'
              '• Usage data (e.g., pages visited, features used)\n'
              '• Location data (if you have enabled location services)\n',
            ),
            SizedBox(height: 16.0),
            Text(
              '3. How We Use Your Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              '• Provide, operate, and maintain our app\n'
              '• Improve, personalize, and expand our app\n'
              '• Understand and analyze how you use our app\n'
              '• Communicate with you, including responding to your inquiries and providing customer support\n'
              '• Send you updates, newsletters, and other information related to WorldPulse\n',
            ),
            SizedBox(height: 16.0),
            Text(
              '4. Data Security',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'We implement reasonable security measures to protect your personal information from unauthorized access, use, or disclosure. However, no method of transmission over the Internet or electronic storage is 100% secure, and we cannot guarantee absolute security.',
            ),
            SizedBox(height: 16.0),
            Text(
              '5. Sharing Your Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'We do not sell, trade, or otherwise transfer your personal information to outside parties. We may share your information with:\n\n'
              '• Service providers who assist us in operating our app (e.g., analytics providers)\n'
              '• Law enforcement or government agencies if required by law\n'
              '• Third parties in connection with a business transfer, such as a merger or acquisition\n',
            ),
            SizedBox(height: 16.0),
            Text(
              '6. Your Choices',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'You have the right to:\n\n'
              '• Access and update your personal information\n'
              '• Request the deletion of your personal information\n'
              '• Opt-out of receiving promotional communications from us\n',
            ),
            SizedBox(height: 16.0),
            Text(
              '7. Children\'s Privacy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'WorldPulse is not intended for children under the age of 13. We do not knowingly collect personal information from children under 13. If we become aware that we have collected personal information from a child under 13, we will take steps to delete that information.',
            ),
            SizedBox(height: 16.0),
            Text(
              '8. Changes to This Privacy Policy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new policy on this page. You are advised to review this Privacy Policy periodically for any changes.',
            ),
            SizedBox(height: 16.0),
            Text(
              '9. Contact Us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'If you have any questions or concerns about this Privacy Policy or our practices, please contact us at:\n\n'
              '**Thrilling Tech Pvt Ltd**\n'
              'Email: thrillingtechpvtltd@icloud.com\n',
            ),
          ],
        ),
      ),
    );
  }
}