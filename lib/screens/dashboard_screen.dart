import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'roadmap_detail_screen.dart';
import 'ai_assistant_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkMode = false;
  String searchQuery = "";

  final List<Map<String, dynamic>> allCourses = [
    {"title": "Software Eng", "icon": Icons.code, "color": Colors.blue, "tag": "Popular"},
    {"title": "App Dev", "icon": Icons.android, "color": Colors.green, "tag": "Trending"},
    {"title": "AI & ML", "icon": Icons.smart_toy, "color": Colors.deepPurple, "tag": "Hot"},
    {"title": "UI/UX Design", "icon": Icons.brush, "color": Colors.orange, "tag": "Creative"},
    {"title": "Data Science", "icon": Icons.analytics, "color": Colors.indigo, "tag": "New"},
    {"title": "Cyber Security", "icon": Icons.security, "color": Colors.red, "tag": "Secure"},
    {"title": "Cloud Computing", "icon": Icons.cloud, "color": Colors.lightBlue, "tag": "Cloud"},
    {"title": "Video Editing", "icon": Icons.movie, "color": Colors.redAccent, "tag": "Skill"},
    {"title": "3D Animation", "icon": Icons.animation, "color": Colors.pink, "tag": "Visual"},
    {"title": "Game Design", "icon": Icons.sports_esports, "color": Colors.cyan, "tag": "Fun"},
    {"title": "CA / Finance", "icon": Icons.account_balance, "color": Colors.teal, "tag": "Govt"},
    {"title": "Stock Market", "icon": Icons.trending_up, "color": Colors.greenAccent, "tag": "Money"},
    {"title": "Digital Marketing", "icon": Icons.campaign, "color": Colors.purple, "tag": "Ads"},
    {"title": "MBA", "icon": Icons.business_center, "color": Colors.brown, "tag": "Leader"},
    {"title": "Medical / NEET", "icon": Icons.medical_services, "color": Colors.pinkAccent, "tag": "Health"},
    {"title": "UPSC / Civil", "icon": Icons.gavel, "color": Colors.orangeAccent, "tag": "IAS"},
    {"title": "Law / LLB", "icon": Icons.balance, "color": Colors.black87, "tag": "Legal"},
    {"title": "Teaching", "icon": Icons.school, "color": Colors.amber, "tag": "Education"},
    {"title": "Psychology", "icon": Icons.psychology, "color": Colors.deepOrange, "tag": "Mind"},
    {"title": "Foreign Lang", "icon": Icons.language, "color": Colors.blueGrey, "tag": "Global"},
  ];

  void _showAdvancedProfile(User? user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Colors.deepPurple, Colors.purpleAccent]),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3)),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: Text(user?.email?[0].toUpperCase() ?? "U",
                          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(user?.email ?? "Guest User",
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  const Text("Premium Member", style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Course Progress", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("72%", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const LinearProgressIndicator(
                      value: 0.72,
                      backgroundColor: Colors.black12,
                      color: Colors.deepPurple,
                      minHeight: 10,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const ListTile(
                    leading: Icon(Icons.stars, color: Colors.amber),
                    title: Text("Achievement: Career Explorer"),
                    dense: true,
                  ),
                  const Divider(),
                  const ListTile(
                    leading: Icon(Icons.verified, color: Colors.blue),
                    title: Text("Profile Verified"),
                    dense: true,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("CLOSE", style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    String displayName = user?.email?.split('@')[0].toUpperCase() ?? "GUEST";

    // Filter logic based on the state variable 'searchQuery'
    final filteredCourses = allCourses.where((course) {
      return course['title'].toString().toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Theme(
      data: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        backgroundColor: isDarkMode ? Colors.black : Colors.grey[50],
        appBar: AppBar(
          title: const Text("Career Route", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          leading: const Icon(Icons.rocket_launch, color: Colors.white),
          actions: [
            IconButton(
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode, color: Colors.white),
              onPressed: () => setState(() => isDarkMode = !isDarkMode),
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu, color: Colors.white, size: 28),
              onSelected: (value) async {
                if (value == 'profile') {
                  _showAdvancedProfile(user);
                } else if (value == 'logout') {
                  await FirebaseAuth.instance.signOut();
                  if (mounted) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  }
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: 'profile',
                  child: ListTile(
                    leading: Icon(Icons.account_circle, color: Colors.deepPurple),
                    title: Text('View Profile'),
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'logout',
                  child: ListTile(
                    leading: Icon(Icons.power_settings_new, color: Colors.red),
                    title: Text('Sign Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 35),
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello, $displayName!", style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  const Text("Find your professional path today", style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 25),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))],
                    ),
                    child: TextField(
                      onChanged: (value) => setState(() => searchQuery = value),
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: "Search career roadmaps...",
                        prefixIcon: Icon(Icons.search, color: Colors.deepPurple),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Row(
                children: [
                  Text("Career Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Icon(Icons.filter_list, size: 20, color: Colors.grey),
                ],
              ),
            ),
            Expanded(
              child: filteredCourses.isEmpty
                  ? const Center(child: Text("No courses found!"))
                  : GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 0.9,
                ),
                itemCount: filteredCourses.length,
                itemBuilder: (context, index) => _buildModernBox(context, filteredCourses[index], isDarkMode),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AIAssistantScreen())),
          label: const Text("AI GUIDE", style: TextStyle(fontWeight: FontWeight.bold)),
          icon: const Icon(Icons.auto_awesome),
          backgroundColor: Colors.deepPurple,
        ),
      ),
    );
  }

  Widget _buildModernBox(BuildContext context, Map<String, dynamic> course, bool dark) {
    Color color = course['color'];
    return InkWell(
      // ✅ FIX: Removed 'const' because constructor logic is now non-const
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RoadmapDetailScreen(careerTitle: course['title']))),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: dark ? [Colors.grey[900]!, Colors.black] : [Colors.white, Colors.grey[100]!],
            begin: Alignment.topLeft, end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
          boxShadow: [BoxShadow(color: color.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10, right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                child: Text(course['tag'], style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
                    child: Icon(course['icon'], size: 42, color: color),
                  ),
                  const SizedBox(height: 12),
                  Text(course['title'], textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: dark ? Colors.white : Colors.black87)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}