import 'package:clean_stock_app/data/source/local/company_listing_entity.dart';
import 'package:clean_stock_app/presentation/company_listings/company_listings_screen.dart';
import 'package:flutter/material.dart';

import 'util/color_schemes.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  // hive_generator build_runner 실행 이후 설정
  Hive.registerAdapter(CompanyListingEntityAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      themeMode: ThemeMode.system,
      home: const CompanyListingsScreen(),
    );
  }
}
