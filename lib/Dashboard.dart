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
