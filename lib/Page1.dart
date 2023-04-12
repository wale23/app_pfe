import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1( this.image, this.heading ,this.text ,this.color, {super.key, });
  final String image;
  final String heading;
  final String text ;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            const SizedBox(height: 80.0),
            Image.asset(image),
            const SizedBox(
              height: 15,
            ),
            Text(
              heading,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 23.9,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
            )


          ],
        ),
      ),
    );
  }
}
