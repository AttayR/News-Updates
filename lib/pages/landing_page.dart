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
      body: Stack(
        children: [
          // Full background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/building4.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content on top of the background image
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5), // Adding a semi-transparent overlay for better readability
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, // Align content to the bottom
              children: [
                // Add Spacer to push content to the bottom
                Spacer(),
                const Text(
                  "Stay Informed with the Latest News",
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Text(
                    "Explore the most recent updates and in-depth stories from around the globe. Your next favorite article is just a tap away.",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Material(
                    borderRadius: BorderRadius.circular(30),
                    elevation: 10,
                    color: Colors.transparent, // Set Material color to transparent
                    child: InkWell(
                      onTap: () {
                        // Navigate to the Home screen when the button is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.orange,
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
                const SizedBox(height: 50.0), // Adjust space as necessary
              ],
            ),
          ),
        ],
      ),
    );
  }
}
