import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final options = DefaultFirebaseOptions.currentPlatform;
  final firebaseConfigured = !_hasPlaceholderOptions(options);

  if (firebaseConfigured) {
    await Firebase.initializeApp(options: options);
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  } else {
    debugPrint(
      '[ShopMate] Firebase não configurado. '
      'Rode "flutterfire configure" para conectar seu projeto Firebase.',
    );
  }

  runApp(const ShopMateApp());
}

bool _hasPlaceholderOptions(FirebaseOptions options) {
  bool hasPlaceholder(String value) {
    return value.contains('YOUR_PROJECT_ID') || value.contains('YOUR_API_KEY');
  }

  return hasPlaceholder(options.projectId) || hasPlaceholder(options.apiKey);
}
