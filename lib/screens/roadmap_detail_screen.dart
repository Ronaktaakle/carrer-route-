import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RoadmapDetailScreen extends StatelessWidget {
  final String careerTitle;

  // Final Fix: Removed 'const' to stop constructor errors
  RoadmapDetailScreen({super.key, required this.careerTitle});

  final Map<String, String> careerVideos = {
    "Software Eng": "https://www.youtube.com/watch?v=zOjov-2OZ0E",
    "App Dev": "https://www.youtube.com/watch?v=fis26HvvDII",
    "AI & ML": "https://www.youtube.com/watch?v=GwIo3gDZCVQ",
    "UI/UX Design": "https://www.youtube.com/watch?v=c9Wg6ndoxag",
    "Data Science": "https://www.youtube.com/watch?v=ua-CiDNNj30",
    "Cyber Security": "https://www.youtube.com/watch?v=dz7Ntp7KQ_8",
  };

  @override
  Widget build(BuildContext context) {
    final String finalVideoUrl = careerVideos[careerTitle] ??
        "https://www.youtube.com/results?search_query=$careerTitle+roadmap";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("$careerTitle Roadmap"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(16), // Step 3 Fix: Removed 'const'
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.deepPurple, Colors.indigo]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.play_circle_fill, color: Colors.white, size: 40),
                const SizedBox(width: 15),
                const Expanded(child: Text("Expert Video Guide", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                ElevatedButton(
                  onPressed: () => _launchURL(finalVideoUrl),
                  child: const Text("WATCH"),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView(
              children: [
                _buildStep(1, "Phase 1: Fundamentals"),
                _buildStep(2, "Phase 2: Core Skills"),
                _buildStep(3, "Phase 3: Building Projects"),
                _buildStep(4, "Phase 4: Interview Prep"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(int num, String title) {
    return ListTile(
      leading: CircleAvatar(child: Text("$num")),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Error launching $url");
    }
  }
}