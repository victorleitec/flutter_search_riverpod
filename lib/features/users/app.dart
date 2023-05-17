import 'package:flutter/material.dart';
import 'package:search_users/core/routes/routes.dart';
import 'package:search_users/core/themes/theme.dart';

class SearchApp extends StatelessWidget {
  const SearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Search App',
      theme: themeData,
      routerConfig: router,
    );
  }
}
