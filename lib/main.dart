import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/ui/navigation_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.varelaRoundTextTheme()
      ),
      home: const NavigationContainer(),
    );
  }
}