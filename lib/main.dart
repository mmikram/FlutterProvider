import 'package:flutter/material.dart';
import 'package:item_tracker/item_provider.dart';
import 'package:item_tracker/mobile_layout.dart';
import 'package:item_tracker/responsive_screen.dart';
import 'package:item_tracker/web_layout.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ItemProvider())],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ResponsiveScreen(
          mobileLayout: MobileLayout(),
          webLayout: WebLayout(),
        ),
      ),
    );
  }
}
