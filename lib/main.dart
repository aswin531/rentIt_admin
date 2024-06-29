import 'package:flutter/material.dart';import 'package:provider/provider.dart';
import 'package:rent_it_admin_web/controllers/sidebarControllers/sidebar_controller.dart';
import 'package:rent_it_admin_web/views/sidebar/sidebar.dart';
void main() {
  runApp(MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => SideBarProvider()),
    ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SideBarWidgetTest(),
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
