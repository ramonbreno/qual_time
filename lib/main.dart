import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qual_time/app/core/services/local_storage_service_interface.dart';
import 'package:qual_time/app/core/services/shared_preferences_local_storage_service.dart';
import 'package:qual_time/app/routes/app_pages.dart';
import 'package:qual_time/app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  Get.put<ILocalStorageService>(
    LocalStorageService(preferences),
    permanent: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Next Team',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      getPages: AppPages.pages,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        useMaterial3: true,
      ),
    );
  }
}
