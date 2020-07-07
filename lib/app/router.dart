import 'package:auto_route/auto_route_annotations.dart';

import 'package:log_location/ui/views/home/home_view.dart';
import 'package:log_location/ui/views/login/login_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: HomeView),
    MaterialRoute(page: LoginView, initial: true),
  ],
)
class $Router {}
