import 'dart:math';

class TreatItem {
  final String id;
  final String name;
  final String description;
  final String colories;
  final String image;
  final double price;

  TreatItem(
      {required this.id,
      required this.name,
      required this.colories,
      required this.description,
      required this.image,
      required this.price});

  // mock data
  // 7 items
  static List<TreatItem> mockItems = [
    TreatItem(
        id: '1',
        name: 'New York Cheesecake',
        description: 'One of the creamiest cheesecakes you\'ll ever taste with a crumbly biscuit base.',
        image: 'assets/images/treat/TREAT_0.png',
        colories: '2195 kJ',
        price: 6.34),
    TreatItem(
        id: '2',
        name: 'Strawberry Jam Filled Donut',
        description:
            'A traditional soft and tasy donut, iced with strawberry glaze and filled with strawberry jam. ',
        image: 'assets/images/treat/TREAT_1.png',
        colories: '1292 kJ',
        price: 4.23),
    TreatItem(
        id: '3',
        name: 'Chocolate Jam Filled Donut',
        description:
            'A traditional soft and tasy donut, iced with chocolate glaze and filled with strawberry jam.',
        image: 'assets/images/treat/TREAT_2.png',
        colories: '1207 kJ',
        price: 3.23),
    TreatItem(
        id: '4',
        name: 'Galaxy Donut',
        description:
            'A traditional soft and delicious donut iced with either pink or blue galaxy style glaze.',
        image: 'assets/images/treat/TREAT_3.png',
        colories: '1252 kJ',
        price: 5.38),
    TreatItem(
        id: '5',
        name: 'Chocolate Raspberry Mudcake',
        description:
            'A dense and decadently rich flourless chocolate cake made completely from plant-based ingredients',
        image: 'assets/images/treat/TREAT_4.png',
        colories: '2916 kJ',
        price: 6.69),
    TreatItem(
        id: '6',
        name: 'Donut Cookie',
        description: 'Colourful shortbread cookies in fun, novelty shapes of donuts.',
        image: 'assets/images/treat/TREAT_5.png',
        colories: '705 kJ',
        price: 3.13),
    TreatItem(
      id: '7',
      name: 'Chocolate Chip Cookie',
      description:
          'Baked to perfection by one of Melbourne’s best small-batch bakehouses with generous chunks of milk chocolate. So soft, so chewy, so snackable!',
      image: 'assets/images/treat/TREAT_6.png',
      colories: '978 kJ',
      price: 5.13,
    ),
  ];
}
