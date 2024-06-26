import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneus/config/config.dart';
import 'package:miscelaneus/presentation/providers/providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState ();
}

class MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver{


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ref.read( permissionsProvider.notifier ).checkPermissions();
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    ref.read(appStateProvider.notifier).state = state;
    if( state == AppLifecycleState.resumed ){
      ref.read( permissionsProvider.notifier ).checkPermissions();
    }
    super.didChangeAppLifecycleState(state);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: AppTheme().getTheme(),
      routerConfig: appRouter,
    );
  }
}