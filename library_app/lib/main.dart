import 'package:flutter/material.dart';
import 'package:library_app/ui/navigation/router.dart';
import 'package:library_app/wiring/injection_container.dart';

void main() {
  initDI();
  runApp(const LibraryApp());
}

class LibraryApp extends StatelessWidget {
  const LibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
    return MaterialApp.router(
      routerConfig: router,
      title: 'CSE Library App',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        scaffoldBackgroundColor: colorScheme.background,
      ),
    );
  }
}
