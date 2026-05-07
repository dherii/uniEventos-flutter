import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'routes/app_routes.dart';
import 'screens/tela_detalhes.dart';
import 'screens/tela_principal.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const UniEventosApp());
}

class UniEventosApp extends StatefulWidget {
  const UniEventosApp({super.key});

  @override
  State<UniEventosApp> createState() => _UniEventosAppState();
}

class _UniEventosAppState extends State<UniEventosApp> {
  @override
  void initState() {
    super.initState();
    _inicializar();
  }

  Future<void> _inicializar() async {
    await Future.delayed(const Duration(milliseconds: 500));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniEventos',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => const TelaPrincipal(),
        AppRoutes.detalhes: (context) => const TelaDetalhes(),
      },
    );
  }
}
