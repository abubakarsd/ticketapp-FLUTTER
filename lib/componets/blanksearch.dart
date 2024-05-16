import 'package:flutter/material.dart';

class BlankSearchContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Color.fromARGB(158, 249, 247, 247), // Background color
        borderRadius: BorderRadius.circular(0),
      ),
      child: Container(
        height: screenHeight * 0.05,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Row(
          children: [
            Icon(
              Icons.search,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              'Find events, teams, artists, & venues',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
