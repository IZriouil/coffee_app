import 'package:coffee_app/models/coffee_item.model.dart';
import 'package:coffee_app/models/treat_item.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/colors_constants.dart';

class CheckoutWidget extends StatelessWidget {
  final CoffeeItem coffee;
  final TreatItem? treat;
  const CheckoutWidget({super.key, required this.coffee, this.treat});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildBackground(),
        Hero(
          tag: "coffee_${coffee.id}",
          child: Image.asset(
            coffee.image,
            fit: BoxFit.contain,
          ),
        ),
        if (treat != null)
          Align(
            alignment: Alignment(2, 0.5),
            child: SizedBox(
              width: size.width * 0.8,
              child: Hero(
                tag: "treat_${treat!.id}",
                child: Image.asset(
                  treat!.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("My Order",
                    style: GoogleFonts.montserrat(
                        fontSize: 30, fontWeight: FontWeight.w700, height: 1, color: kTitleColor)),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(coffee.name,
                          style: GoogleFonts.questrial(
                              fontSize: 18,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                              color: kTitleColor)),
                    ),
                    Text("${coffee.price}€",
                        style: GoogleFonts.questrial(
                            fontSize: 18,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w700,
                            color: kTitleColor.withOpacity(.7))),
                  ],
                ),
                if (treat != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(treat!.name,
                              style: GoogleFonts.questrial(
                                  fontSize: 18,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500,
                                  color: kTitleColor)),
                        ),
                        Text("${treat!.price}€",
                            style: GoogleFonts.questrial(
                                fontSize: 18,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w700,
                                color: kTitleColor.withOpacity(.7))),
                      ],
                    ),
                  ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kTitleColor,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Text("Checkout (${(coffee.price + (treat?.price ?? 0)).toStringAsFixed(2)}€)"),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

_buildBackground() {
  return Column(
    children: [
      Expanded(
        flex: 1,
        child: Container(
            decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter,
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, .4],
            colors: [kBrownColor.withOpacity(.5), kBrownColor.withOpacity(0.0)],
          ),
        )),
      ),
    ],
  );
}
