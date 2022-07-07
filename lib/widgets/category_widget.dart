import 'package:flutter/material.dart';
import 'package:mero_doctor/models/category.dart';

class CategoryWidget extends StatelessWidget {
final Category category;

const CategoryWidget(this.category):super();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0), color:category.bgColor ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              category.image,
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                category.categoryName,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
          )
        ],
      ),
    );
  }
}
