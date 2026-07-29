import 'dart:async';
import 'package:flutter/material.dart';
import 'dashboard_screen.dart'; // Ab ye Dashboard ko connect karega

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 3 seconds ka timer
    Timer(const Duration(seconds: 3), () {
      // Ab ye seedha Dashboard Screen par le jayega
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.deepPurple, // Aapka favorite theme color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Career Icon
            Icon(Icons.auto_stories, size: 80, color: Colors.white),
            SizedBox(height: 20),
            // App Name
            Text(
              "CAREER ROUTE",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 30),
            // Loading Circle jo aapne manga tha
            CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}