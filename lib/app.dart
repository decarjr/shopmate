import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/config/theme.dart';
import 'core/constants/app_routes.dart';
import 'features/lists/state/lists_controller.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/onboarding_page.dart';
import 'features/auth/presentation/pages/splash_page.dart';
import 'features/lists/presentation/pages/list_detail_page.dart';
import 'features/lists/presentation/pages/lists_home_page.dart';

class ShopMateApp extends StatelessWidget {
  const ShopMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ListsController.demo(),
      child: MaterialApp(
        title: 'ShopMate',
        theme: buildAppTheme(),
        initialRoute: AppRoutes.splash,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AppRoutes.splash:
              return MaterialPageRoute(builder: (_) => const SplashPage());
            case AppRoutes.login:
              return MaterialPageRoute(builder: (_) => const LoginPage());
            case AppRoutes.onboarding:
              return MaterialPageRoute(builder: (_) => const OnboardingPage());
            case AppRoutes.listsHome:
              return MaterialPageRoute(builder: (_) => const ListsHomePage());
            case AppRoutes.listDetail:
              final args = settings.arguments as Map<String, dynamic>?;
              final listId = args?['id'] as String? ?? '';
              return MaterialPageRoute(
                builder: (_) => ListDetailPage(listId: listId),
              );
          }
          return MaterialPageRoute(builder: (_) => const SplashPage());
        },
      ),
    );
  }
}
