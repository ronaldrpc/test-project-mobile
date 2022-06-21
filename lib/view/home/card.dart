import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  //const Card({Key? key}) : super(key: key);

  final String title;
  final String description;
  final String price;
  final String img;

  ServiceCard(
      {required this.title,
      required this.description,
      required this.price,
      required this.img});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 25, right: 25, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              Text(description,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500)),
              Text(price,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10),
            /*decoration:
                  BoxDecoration(image: DecorationImage(image: NetworkImage(img)))*/
            child: new Image.asset(
              img,
              height: 60,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
