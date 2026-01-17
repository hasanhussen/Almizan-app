import 'package:flutter/material.dart' show Color, Colors;
import 'package:flutter/painting.dart';

Color Orange = const Color(0xffFEB100);
Color LightOrange = const Color(0xffFFBE0B);
Color DarkBlue = const Color(0xff040D8D);
Color Grey = const Color(0xff707070);
Color BlueGrey = const Color(0xff305F72);
Color LightBlue = const Color(0xff6CBBF5);
Color Blue = const Color(0xff5592D9);
Color Green = const Color(0xff2FC75C);


const customBoxDecoration = BoxDecoration(
  image: DecorationImage(
      colorFilter: ColorFilter.mode(Colors.white, BlendMode.softLight),
      image: AssetImage(
        'assets/img/bg.jpg',
      ),
      fit: BoxFit.fill),
);

const customContainerBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.vertical(
    top: Radius.elliptical(50, 30),
  ),
  boxShadow: [
    BoxShadow(color: Colors.black12, spreadRadius: 5, blurRadius: 10),
  ],
);
