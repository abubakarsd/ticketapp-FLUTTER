import 'dart:typed_data';

import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final String imagePath;
  final String header;
  final String subheader;
  final List<Uint8List>? artistImages; // Updated parameter
  final onTap;

  const AccountCard({
    Key? key,
    required this.imagePath,
    required this.header,
    required this.subheader,
    this.artistImages, // Updated parameter
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 110,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF908E8E),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        header,
                        style: const TextStyle(fontSize: 17),
                      ),
                      Text(
                        subheader,
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w300),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 40,
                        width: 150,
                        child: Stack(
                          children: (artistImages ?? []).take(3).map((image) {
                            return Positioned(
                              left: 15 *
                                  (artistImages ?? [])
                                      .indexOf(image)
                                      .toDouble(), // Adjust the position as needed
                              child: CircleAvatar(
                                radius: 15,
                                backgroundImage: MemoryImage(image),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Image.asset(imagePath), // Replaced Icon with Image.asset
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
