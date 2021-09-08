
import 'package:coffee_custom/pojo/coffee.dart';
import 'package:coffee_custom/util/dio_app.dart';
import 'package:flutter/material.dart';

import 'coffee_order_page.dart';

class CoffeeItem extends StatelessWidget {
  final Coffee coffee;

  CoffeeItem(this.coffee);

  @override
  Widget build(BuildContext context) {
    return _buildCoffeeCard(context, coffee);
  }
}

Widget _buildCoffeeCard(
  BuildContext context,
  Coffee coffee,
) {
  return Card(
    child: Container(
      padding: const EdgeInsets.all(8.0),
      width: 300,
      height: 300,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 200,
                child: Image.network(
                  imageUrl(coffee.coffeeUrl),
                  fit: BoxFit.fitHeight,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 23),
                  Container(
                    child: Text(
                      coffee.coffeeName ?? '',
                      style: Theme.of(context).textTheme.button,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    coffee.coffeePrice == null ? '' : "￥${coffee.coffeePrice}",
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () async {
                showCoffeeEdit(context, coffee);
              },
            ),
          ),
        ],
      ),
    ),
  );
}

Future<bool> showCoffeeEdit(context, Coffee coffee) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      child: SizedBox(
        width: 600,
        height: 600,
        child: CoffeeOrderPage(coffee),
      ),
    ),
  );
}
