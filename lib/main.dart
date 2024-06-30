import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_it_admin_web/controllers/sidebarControllers/sidebar_controller.dart';
import 'package:rent_it_admin_web/controllers/vehiclecarController/car_provider.dart';
import 'package:rent_it_admin_web/firebase_options.dart';
import 'package:rent_it_admin_web/services/firebase/firebase_auth_services.dart';
import 'package:rent_it_admin_web/views/auth/login.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => AuthService(),
    ),
    ChangeNotifierProvider(
      create: (context) => SideBarProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => VehicleCarProvider(),
    ),

  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SignInScreen(),
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
