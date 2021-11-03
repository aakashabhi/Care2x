import 'package:care2x/ViewRemedies/remedy.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final Remedy rem;
  Description({required this.rem});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Text(
              rem.title,
              style: TextStyle(
                fontSize: 30,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = Colors.blue[700]!,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              rem.description,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
