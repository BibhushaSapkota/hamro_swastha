import 'package:flutter/material.dart';

class Category {
  final String image;
  final String categoryName;
  final Color bgColor;

  Category(this.image, this.categoryName, this.bgColor);
}

class DiseasesCategory {
  final String image;
  final String name;

  DiseasesCategory(this.image, this.name);
}

class TopDoctorCategory {
  final String image;
  final String name;
  final String job;
  final Color bgColor;
  final Color bgColor2;

  TopDoctorCategory(
      this.image, this.name, this.job, this.bgColor, this.bgColor2);
}

class DoctorWidgets {
  final String image;
  final String name;
  final String time;

  DoctorWidgets(this.image, this.name, this.time);
}
