import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/influencer_provider.dart';
import 'providers/campaign_provider.dart';
import 'routes/app_router.dart';

void main() {
  runApp(const QoruzApp());
}

class QoruzApp extends StatelessWidget {
  const QoruzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => InfluencerProvider()),
        ChangeNotifierProvider(create: (_) => CampaignProvider()),
      ],
      child: MaterialApp.router(
        title: 'Qoruz',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
        debugShowMaterialGrid: false,
      ),
    );
  }
}
