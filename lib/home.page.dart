import 'package:coffee_app/config/colors_constants.dart';
import 'package:coffee_app/config/services_locator.dart';
import 'package:coffee_app/models/coffee_item.model.dart';
import 'package:coffee_app/models/treat_item.model.dart';
import 'package:coffee_app/services/navigation.service.dart';
import 'package:coffee_app/widgets/checkout.widget.dart';
import 'package:coffee_app/widgets/intro.widget.dart';
import 'package:coffee_app/widgets/sweet_treats.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'coffe_details.page.dart';
import 'widgets/coffee_list.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              FeatherIcons.chevronLeft,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              locator.get<NavigationService>().navigatorKey.currentState!.pop();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                FeatherIcons.shoppingBag,
                size: 30,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          clipBehavior: Clip.none,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Navigator(
                  key: locator.get<NavigationService>().navigatorKey,
                  observers: [locator.get<NavigationService>().heroController],
                  onGenerateRoute: (settings) {
                    NavigationArguments? args = settings.arguments as NavigationArguments?;
                    late Widget currentPage;
                    bool toHome = false;

                    if (args == null) {
                      if (settings.name == 'home') {
                        toHome = true;
                      }
                      currentPage = settings.name == 'home' ? const CofeeListWidget() : const IntroWidget();
                    } else {
                      currentPage = CoffeeDetailsPage(
                        coffee: CoffeeItem.mockItems[args.coffee],
                      );
                      if (args.isSweetTreats) {
                        currentPage = SweetTreatsWidget(coffee: CoffeeItem.mockItems[args.coffee]);
                      }
                      if (args.isCheckout) {
                        currentPage = CheckoutWidget(
                          coffee: CoffeeItem.mockItems[args.coffee],
                          treat: args.treat != null ? TreatItem.mockItems[args.treat!] : null,
                        );
                      }
                    }

                    return PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: toHome ? 800 : 300),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FadeTransition(
                            opacity: animation,
                            child: Container(color: Colors.white, child: currentPage),
                          );
                        });
                  }),
            ],
          ),
        ));
  }
}
