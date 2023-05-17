import 'package:go_router/go_router.dart';
import 'package:search_users/features/users/presentation/pages/home_page.dart';
import 'package:search_users/features/users/presentation/pages/new_user_page.dart';

const String _initialLocation = '/home';

final GoRouter router = GoRouter(
  initialLocation: _initialLocation,
  routes: [
    _homeRoute,
    _newUserRoute,
  ],
);

final GoRoute _homeRoute = GoRoute(
  path: '/home',
  builder: (context, state) => const HomePage(),
);

final GoRoute _newUserRoute = GoRoute(
  path: '/new',
  builder: (context, state) => const NewUserPage(),
);
