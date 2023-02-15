import 'package:coffee_app/config/services_locator.dart';
import 'package:coffee_app/services/navigation.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config/colors_constants.dart';
import 'models/coffee_item.model.dart';

class CoffeeDetailsPage extends StatefulWidget {
  final CoffeeItem coffee;
  const CoffeeDetailsPage({super.key, required this.coffee});

  @override
  State<CoffeeDetailsPage> createState() => _CoffeeDetailsPageState();
}

class _CoffeeDetailsPageState extends State<CoffeeDetailsPage> {
  late String sizeCoffee;

  @override
  void initState() {
    super.initState();
    sizeCoffee = 'M';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextStyle titleStyle = GoogleFonts.montserrat(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      height: 1,
      color: kTitleColor,
    );
    return Stack(fit: StackFit.expand, clipBehavior: Clip.none, children: [
      _buildBackground(),
      Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            verticalDirection: VerticalDirection.up,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center + Alignment(-.9, -0.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 0, bottom: 32),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kTitleColor,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                          alignment: Alignment.centerLeft,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          locator<NavigationService>().navigateTo(NavigationArguments(
                              coffee: CoffeeItem.mockItems.indexOf(widget.coffee), isSweetTreats: true));
                        },
                        child: Row(
                          children: [
                            Text('Add to cart',
                                style: GoogleFonts.questrial(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              FeatherIcons.chevronsRight,
                              size: 18,
                            )
                          ],
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        FeatherIcons.coffee,
                        color: kTitleColor,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        sizeCoffee == 'M'
                            ? "Basic"
                            : sizeCoffee == 'L'
                                ? "Large"
                                : "Small",
                        style: GoogleFonts.questrial(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: kTitleColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: ['S', 'M', 'L']
                        .map((sizeCoffe) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  sizeCoffee = sizeCoffe;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: sizeCoffee == sizeCoffe ? kTitleColor : Colors.transparent,
                                  border: Border.all(
                                    color: sizeCoffee != sizeCoffe ? kTitleColor : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 300),
                                  style: GoogleFonts.questrial(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: sizeCoffee != sizeCoffe ? kTitleColor : Colors.white,
                                  ),
                                  child: Text(
                                    sizeCoffe,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "${(widget.coffee.price + (sizeCoffee == "M" ? 0 : (sizeCoffee == "L" ? 1.2 : -.8))).toStringAsFixed(2)}€",
                    style: titleStyle),
              ),
              Spacer(),
              Text(
                widget.coffee.description,
                textAlign: TextAlign.left,
                style: GoogleFonts.questrial(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: kTitleColor.withOpacity(0.5),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: size.width * 0.6,
                child: Hero(
                    tag: "coffee_${widget.coffee.id}_name",
                    child: Text(
                      widget.coffee.name,
                      style: titleStyle,
                      textAlign: TextAlign.left,
                    )),
              )
            ],
          ),
        ),
      ),
      Positioned(
        left: size.width * 0.38,
        bottom: -size.height * 0.15,
        width: size.width,
        height: size.height * 0.7,
        child: IgnorePointer(
          ignoring: true,
          child: Hero(
            tag: "coffee_${widget.coffee.id}",
            child: AnimatedScale(
              duration: const Duration(milliseconds: 400),
              scale: sizeCoffee == 'M'
                  ? 1.36
                  : sizeCoffee == 'L'
                      ? 1.5
                      : 1.2,
              curve: Curves.easeOutBack,
              alignment: Alignment.center,
              child: Image.asset(
                widget.coffee.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  _buildBackground() {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
              decoration: BoxDecoration(
            gradient: LinearGradient(
              end: Alignment.topRight,
              begin: Alignment.bottomLeft,
              stops: [0.0, .50],
              colors: [kBrownColor.withOpacity(.7), kBrownColor.withOpacity(0.0)],
            ),
          )),
        ),
        Expanded(
          flex: 1,
          child: Container(
              decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, .4],
              colors: [kBrownColor.withOpacity(.5), kBrownColor.withOpacity(0.0)],
            ),
          )),
        ),
      ],
    );
  }
}
