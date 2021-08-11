import 'package:auto_route/auto_route.dart';

import '../../presentation/core/hero_empty_router_page.dart';
import '../../presentation/details/details_page.dart';
import '../../presentation/home/home_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      initial: true,
      name: 'HomeRouter',
      page: HeroEmptyRouterPage,
      children: [
        AutoRoute(path: '', page: HomePage),
        AutoRoute(path: 'details', page: DetailsPage),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
  ],
)
class $AppRouter {}
