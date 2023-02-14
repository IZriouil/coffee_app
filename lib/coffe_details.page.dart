import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'models/coffee_item.model.dart';

class CoffeeDetailsPage extends StatefulWidget {
  final CoffeeItem coffee;
  const CoffeeDetailsPage({super.key, required this.coffee});

  @override
  State<CoffeeDetailsPage> createState() => _CoffeeDetailsPageState();
}

class _CoffeeDetailsPageState extends State<CoffeeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: const [
          Icon(
            Icons.favorite_border,
            color: Colors.black,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Stack(fit: StackFit.expand, clipBehavior: Clip.none, children: [
        Positioned(
          right: MediaQuery.of(context).size.width * 0.4,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Hero(
            tag: "coffee_${widget.coffee.id}",
            child: Transform.scale(
              scale: 1.36,
              child: Image.asset(
                widget.coffee.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
