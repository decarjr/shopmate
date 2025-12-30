import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();
  
  runApp(const ShopMateApp());
}

class ShopMateApp extends StatelessWidget {
  const ShopMateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopMate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            const Text(
              'ShopMate',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Sua lista inteligente de compras',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
