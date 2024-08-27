import 'package:flutter/material.dart';
import 'package:news_updates/pages/home.dart'; // Make sure this import is correct

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Material(
              elevation: 20,
              borderRadius: BorderRadius.circular(30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  "images/building2.jpg",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.5,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            const Text(
              "News from around the\nworld for you",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Text(
                "News from around the world for you, so take your time to read",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30.0),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Material(
                borderRadius: BorderRadius.circular(30),
                elevation: 20,
                child: InkWell(  // Changed to InkWell for tap detection
                  onTap: () {
                    // Navigate to the Home screen when the button is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.green,
                    ),
                    child: const Center(
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
