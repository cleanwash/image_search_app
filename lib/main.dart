import 'package:flutter/material.dart';

import 'package:image_search_app/data/photo_provider.dart';
import 'package:image_search_app/data/pixabay_api.dart';
import 'package:image_search_app/ui/home_screen.dart';
import 'package:image_search_app/ui/home_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PhotoProvider(
        viewModel: HomeViewModel(
          PixabayApi(),
        ),
        child: HomeScreen(),
      ),
    );
  }
}
