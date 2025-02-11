import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:replica_list_moteis/views/motel_list_screen.dart';
import './providers/motel_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MotelProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MotelListScreen(),
    );
  }
}
