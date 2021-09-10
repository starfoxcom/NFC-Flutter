import 'package:nfc_flutter/views/views.dart';
import 'package:auto_route/annotations.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(path: "/home", page: HomeView, initial: true),
  ],
)
class $AppRouter {}
