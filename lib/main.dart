import 'package:flutter/material.dart';
import 'package:real_sun_sd_closet_app/screens/signup_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url:'https://rzpdbtyudsefwniafsub.supabase.co',
    anonKey:'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ6cGRidHl1ZHNlZnduaWFmc3ViIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzYxODc2MTMsImV4cCI6MjA5MTc2MzYxM30.9ZS1rzuHMpupniykhuqXieL5wZu72OvRa8bv5je4XO4',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SignupScreen()
    );
  }
}



  

  

  

  
       
