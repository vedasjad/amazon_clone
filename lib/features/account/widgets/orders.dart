import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List list = [
    'https://i.pinimg.com/originals/cf/47/fd/cf47fd982fbc6507429a4b17f60373d5.jpg',
    'https://i.pinimg.com/originals/cf/47/fd/cf47fd982fbc6507429a4b17f60373d5.jpg',
    'https://i.pinimg.com/originals/cf/47/fd/cf47fd982fbc6507429a4b17f60373d5.jpg',
    'https://i.pinimg.com/originals/cf/47/fd/cf47fd982fbc6507429a4b17f60373d5.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: const Text(
                'Your Orders',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                'See all',
                style: TextStyle(
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            )
          ],
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(
            left: 0,
            right: 0,
            top: 20,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: ((context, index) {
              return SingleProduct(
                image: list[index],
              );
            }),
          ),
        )
      ],
    );
  }
}
