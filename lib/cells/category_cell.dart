import 'package:flutter/material.dart';

import '../models/category.dart';
import '../widgets/utils/he_color.dart';

class CategoryCell extends StatelessWidget {
  final Category category;

  const CategoryCell({ Key? key, required this.category}) : super(key: key);

  /// **********************************************
  /// LIFE CYCLE METHODS
  /// **********************************************

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 100,
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.only(top: 14),
      decoration: BoxDecoration(
        color: HexColor('#FF32A060'),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  category.icon,
                  size: 24,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  category.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                height: 30,
                width: 60,
                decoration: BoxDecoration(
                    color: HexColor('#FF32A060'),
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(10))),
              ),
              Positioned(
                left: 16,
                child: Text(
                  'Spécialité',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
