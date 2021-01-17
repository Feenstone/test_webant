import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

import 'features/gallery/presentation/pages/main_screen.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return ProviderScope(
        child: MaterialApp(
          title: 'Gallery',
          home: MainScreen(),
        ),
      );
    }
}