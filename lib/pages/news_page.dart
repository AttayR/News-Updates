import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "News",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              TextSpan(
                text: " Article",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(
            255, 80, 2, 2), // You can change this color to be more colorful

        iconTheme: IconThemeData(
          color:
              Colors.white, // This will change the color of the icons to white
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // News Image
              Image.network(
                'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8bmV3c3xlbnwwfHwwfHx8MA%3D%3D',
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16.0),
              // News Title
              Text(
                'Today\'s Trending News: Global Economy and Tech Giants',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 16.0),
              // News Content
              Text(
                'As we move forward in 2024, several key topics have dominated the global headlines:',
                style: TextStyle(
                  fontSize: 16.0,
                  color: isDarkMode ? Colors.grey[300] : Colors.black,
                ),
              ),
              SizedBox(height: 16.0),
              // Bullet Points
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBulletPoint(
                    isDarkMode,
                    '🔸 **Global Economy:** The global economy continues to face challenges, with inflation rates affecting multiple countries, prompting central banks to take various measures to stabilize markets.',
                  ),
                  _buildBulletPoint(
                    isDarkMode,
                    '🔸 **Tech Giants:** Major technology companies are pushing the boundaries of AI, with new advancements being announced daily. The focus remains on ethical AI and ensuring data privacy for users worldwide.',
                  ),
                  _buildBulletPoint(
                    isDarkMode,
                    '🔸 **Climate Change:** Climate change remains a pressing issue, with governments and organizations around the world intensifying efforts to reduce carbon emissions and promote sustainable practices.',
                  ),
                  _buildBulletPoint(
                    isDarkMode,
                    '🔸 **Global Health:** The ongoing focus on global health initiatives, particularly in the wake of the pandemic, continues to highlight the importance of international cooperation and preparedness.',
                  ),
                  _buildBulletPoint(
                    isDarkMode,
                    '🔸 **Geopolitical Tensions:** Various geopolitical tensions have arisen, with countries negotiating to maintain peace and stability in different regions.',
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Stay tuned to World Pulse for more updates on these and other important global topics.',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.orange : Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(bool isDarkMode, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.0,
          color: isDarkMode ? Colors.grey[300] : Colors.black,
        ),
      ),
    );
  }
}
