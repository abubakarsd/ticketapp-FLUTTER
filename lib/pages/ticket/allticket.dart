import 'package:flutter/material.dart';
import 'package:ticketapp/pages/ticket/transfarseat.dart';
import 'package:ticketapp/pages/ticket/viewbarcode.dart';
import 'package:ticketapp/services/database_helper.dart';
import 'package:ticketapp/model/datamodel.dart';

class TicketListForShow extends StatefulWidget {
  final int showId;
  final String showData;

  const TicketListForShow(
      {Key? key, required this.showId, required this.showData})
      : super(key: key);

  @override
  _TicketListForShowState createState() => _TicketListForShowState();
}

class _TicketListForShowState extends State<TicketListForShow> {
  late Future<List<Map<String, dynamic>>> _ticketListFuture;

  @override
  void initState() {
    super.initState();
    _loadTicketsForShow();
  }

  Future<void> _loadTicketsForShow() async {
    setState(() {
      _ticketListFuture = DatabaseHelper.getTicketsForShow(widget.showId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0163D5),
        title: Row(
          children: [
            const Icon(
              Icons.close,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ticketmaster Event',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  widget.showData,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          FutureBuilder<List<Map<String, dynamic>>>(
            future: _ticketListFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No tickets available'));
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: snapshot.data!.map((ticket) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.63,
                          child: Column(
                            children: [
                              Container(
                                height: screenHeight * 0.055,
                                width: screenWidth,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  color: Color(0xFF0163D5),
                                ),
                                child: Center(
                                  child: Text(
                                    ('${ticket['ticketType']} Ticket'),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: screenHeight * 0.07,
                                width: screenWidth,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 18, 118, 232),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'SEC',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          ticket['selection'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'ROW',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          ticket['row'].toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'SEAT',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          ticket['seat'].toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: screenHeight * 0.2,
                                width: screenWidth,
                                decoration: BoxDecoration(
                                  // color: Color.fromARGB(255, 111, 110, 110),
                                  image: DecorationImage(
                                    image: MemoryImage(ticket['artistImage']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      ticket['artistName'],
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      widget.showData,
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Entry Gate',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ('ENTER DOOR ${ticket['fee']}'),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: screenHeight * 0.06,
                                width: screenWidth * 0.6,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust the radius as needed
                                ),
                                child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Image.asset(
                                      //   'assets/images/image 2.png',
                                      //   height: 24, // Adjust the height as needed
                                      //   width: 24, // Adjust the width as needed
                                      // ),
                                      Icon(
                                        Icons.wallet,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        'Add to Apple Wallet',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )
                                    ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        viewBarcodeBottomSheet(
                                          context,
                                          ticket['selection'],
                                          ticket['ticketType'],
                                          ticket['row'],
                                          ticket['seat'],
                                          ticket['fee'],
                                        );
                                      },
                                      child: const Text(
                                        'View Barcode',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF0163D5)),
                                      ),
                                    ),
                                    const Text(
                                      'Ticket Details',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF0163D5)),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: screenHeight * 0.055,
                                width: screenWidth,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                  color: Color(0xFF0163D5),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.airplane_ticket),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      ('ticketmaster.verified'),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  seatTransBottomSheet(context);
                },
                child: Container(
                  height: screenHeight * 0.055,
                  width: screenWidth * 0.4,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Color(0xff0163D5),
                  ),
                  child: const Center(
                    child: Text('Transfar',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ),
              ),
              Container(
                height: screenHeight * 0.055,
                width: screenWidth * 0.4,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Color(0xFFEAEAEA),
                ),
                child: const Center(
                  child: Text('Sell',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/image 14.png'),
          )
        ],
      ),
    );
  }

  void viewBarcodeBottomSheet(
    BuildContext context,
    section,
    ticketType,
    row,
    seat,
    door,
  ) {
    showModalBottomSheet<void>(
        context: context,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return ViewBarcode(
            section: section,
            showData: widget.showData,
            ticketType: ticketType,
            row: row.toString(),
            seat: seat.toString(),
            door: door.toString(),
          );
        });
  }

  void seatTransBottomSheet(
    BuildContext context,
  ) {
    showModalBottomSheet<void>(
        context: context,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return TransfarSeat(section: '');
        });
  }
}
