import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/configs/multiprovider.dart';
import 'package:translator/configs/routes/navigation_service.dart';
import 'package:translator/configs/routes/routes_manager.dart';
import 'package:translator/feature/noInternet/view_model/no_internet_view_model.dart';
import 'package:translator/feature/splashScreen/view/splash_screen.dart';
import 'package:translator/feature/translator/view/screen/translator_screen.dart';

void main() {
  runApp(const MyAppMultiProvider(
    myApp: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<NoInternetViewModel>().internetConnection(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Translator App',
      theme: ThemeData(primarySwatch: Colors.blue),
      navigatorKey: NavigationService.navigatorKey,
      home: SplashScreen(),
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}
