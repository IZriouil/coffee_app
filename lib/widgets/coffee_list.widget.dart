import 'package:coffee_app/config/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/colors_constants.dart';
import '../config/scroll_config.dart';
import '../models/coffee_item.model.dart';
import '../services/navigation.service.dart';

class CofeeListWidget extends StatefulWidget {
  const CofeeListWidget({super.key});

  @override
  State<CofeeListWidget> createState() => _CofeeListWidgetState();
}

class _CofeeListWidgetState extends State<CofeeListWidget> {
  late final PageController _coffeController;
  late final PageController _headingController;
  late double _currentPosition;
  late int _currentHeading;

  void _navigationListener() {
    setState(() {
      _currentPosition = _coffeController.page!;
      // print(_currentPosition);
      if (_currentPosition.round() != _currentHeading) {
        _currentHeading = _currentPosition.round();
        _headingController.animateToPage(_currentHeading,
            duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _coffeController = PageController(viewportFraction: 0.4, initialPage: 4);
    _headingController = PageController(viewportFraction: 1, initialPage: 4);
    _currentPosition = _coffeController.initialPage.toDouble();
    _currentHeading = _headingController.initialPage;
    _coffeController.addListener(_navigationListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _coffeController.removeListener(_navigationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ..._buildBackground(),
        Transform.scale(
          alignment: Alignment.bottomCenter,
          scale: 2.3,
          child: PageView.builder(
              controller: _coffeController,
              itemCount: 10,
              clipBehavior: Clip.none,
              scrollBehavior: WindowsScrollBehaviour(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                if (index == 0) {
                  // HEADINGS HERE Would be great
                  return const SizedBox.shrink();
                }
                // we need to know how much index is far from the current page to scale it
                final double distance = (_currentPosition - index + 1).abs();
                final isNotOnScreen = (_currentPosition - index + 1) > 0;
                final double scale = 1 - distance * .345 * (isNotOnScreen ? 1 : -1);
                final double translateY = (1 - scale).abs() * MediaQuery.of(context).size.height / 1.5 +
                    20 * (distance - 1).clamp(0.0, 1);
                return Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .1),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..translate(0.0, !isNotOnScreen ? 0.0 : translateY)
                      ..scale(scale),
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        locator<NavigationService>().navigateTo(
                          NavigationArguments(
                            coffee: index - 1,
                          ),
                        );
                      },
                      child: Hero(
                        flightShuttleBuilder: (
                          BuildContext flightContext,
                          Animation<double> animation,
                          HeroFlightDirection flightDirection,
                          BuildContext fromHeroContext,
                          BuildContext toHeroContext,
                        ) {
                          late Widget hero;
                          if (flightDirection == HeroFlightDirection.push) {
                            hero = fromHeroContext.widget;
                          } else {
                            hero = toHeroContext.widget;
                          }
                          return hero;
                        },
                        tag: "coffee_${CoffeeItem.mockItems[index - 1].id}",
                        child: Image.asset(
                          CoffeeItem.mockItems[index - 1].image,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
        Container(
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [.6, 1],
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0.0),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                  child: PageView.builder(
                      controller: _headingController,
                      itemCount: CoffeeItem.mockItems.length,
                      scrollBehavior: WindowsScrollBehaviour(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final CoffeeItem item = CoffeeItem.mockItems[index];
                        final TextStyle titleStyle = GoogleFonts.montserrat(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          height: 1,
                          color: kTitleColor,
                        );
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: Center(
                            child: Hero(
                              tag: "coffee_${item.id}_name",
                              child: Text(
                                item.name,
                                style: titleStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    "${CoffeeItem.mockItems[_currentHeading.clamp(0, CoffeeItem.mockItems.length - 1)].price.toStringAsFixed(2)}€",
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      height: 1,
                      color: kTitleColor,
                    ),
                  ),
                ),
              ],
            )),
        ..._buildOverlays(),
      ],
    );
  }

  List<Widget> _buildBackground() {
    return [
      Align(
        alignment: Alignment.bottomCenter + const Alignment(0, .7),
        child: Container(
          width: MediaQuery.of(context).size.width * .5,
          height: MediaQuery.of(context).size.width * .5,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: kBrownColor,
              blurRadius: 90,
              spreadRadius: 90,
              offset: Offset.zero,
            ),
          ], shape: BoxShape.circle),
        ),
      ),
      Align(
        alignment: Alignment.centerLeft + const Alignment(-0.35, -.5),
        child: Container(
          width: 60,
          height: 200,
          decoration: const BoxDecoration(
            // color: kBrownColor,
            boxShadow: [
              BoxShadow(
                color: kBrownColor,
                blurRadius: 50,
                spreadRadius: 20,
                offset: Offset(5, 0),
              ),
            ],
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomRight + const Alignment(5.8, -0.45),
        child: SizedBox(
            width: 350,
            height: 350,
            child: DecoratedBox(
              decoration: BoxDecoration(
                // color: kBrownColor,
                boxShadow: [
                  BoxShadow(
                    color: kBrownColor.withOpacity(.4),
                    blurRadius: 60,
                    spreadRadius: 20,
                    offset: Offset(5, 0),
                  ),
                ],
                shape: BoxShape.circle,
              ),
            )),
      )
    ];
  }

  List<Widget> _buildOverlays() {
    return [
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 115,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                kBrownColor.withRed(170).withOpacity(.6),
                kBrownColor.withOpacity(0.0),
              ],
            ),
          ),
        ),
      )
    ];
  }
}
