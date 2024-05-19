import 'package:flutter/material.dart';

class TransfarUser extends StatefulWidget {
  final String section;
  final Function seatTransBottomSheet;
  final List<int> selectedSeats;

  const TransfarUser({
    Key? key,
    required this.section,
    required this.seatTransBottomSheet,
    required this.selectedSeats,
  }) : super(key: key);

  @override
  State<TransfarUser> createState() => _TransfarUserState();
}

class _TransfarUserState extends State<TransfarUser> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          height: screenHeight * 0.6,
          width: screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'TRANSFER TICKETS',
                      style: TextStyle(
                        color: Color(0xFF908E8E),
                        fontSize: 13,
                      ),
                    ),
                    Divider(
                      height: 0.5,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${widget.selectedSeats.length.toString()} Ticket Selected",
                  textAlign: TextAlign.left,
                ),
              ),

              // Expanded(
              //   child: ListView.builder(
              //     itemCount: widget.selectedSeats.length,
              //     itemBuilder: (context, index) {
              //       final seat = widget.selectedSeats[index];
              //       return ListTile(
              //         title: Text('Seat $seat'),
              //       );
              //     },
              //   ),
              // ),

              Container(
                height: 45,
                width: screenWidth,
                decoration: const BoxDecoration(
                  color: Color(0xFFEBECED),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          widget.seatTransBottomSheet(
                              context, widget.selectedSeats);
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_back_ios),
                            Text('Back'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
