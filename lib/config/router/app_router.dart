

  import 'package:go_router/go_router.dart';
import 'package:miscelaneus/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),),
      GoRoute(
        path: '/permissions',
        builder: (context, state) => const PermissionsScreen(),)

]);