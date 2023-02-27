/* 
 @authors:
 Abdul Wahhab Alfaghiri Al Anzi   01524445
 Nouzad Mohammad                  00820679
*/
import 'package:flutter/material.dart';
import 'DachCalender.dart';
import 'Dashhome.dart';
import 'responsive.dart';
import 'header.dart';
class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        child: Column(
          children: [
            Container(
              /* padding: EdgeInsets.all(10), */
              height: double.maxFinite,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Header(), Dashhome()],
              ),
            )
          ],
        ),
      ),
    );
  }
}
