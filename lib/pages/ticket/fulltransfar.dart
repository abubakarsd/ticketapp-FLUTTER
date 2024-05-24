import 'package:flutter/material.dart';
import 'package:ticketapp/services/database_helper.dart';

class TransfarSymbol extends StatefulWidget {
  final int userId;

  const TransfarSymbol({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<TransfarSymbol> createState() => _TransfarSymbolState();
}

class _TransfarSymbolState extends State<TransfarSymbol> {
  late Future<List<Map<String, dynamic>>> _userTicketsFuture;

  @override
  void initState() {
    super.initState();
    _loadUserTickets();
  }

  Future<void> _loadUserTickets() async {
    setState(() {
      _userTicketsFuture = DatabaseHelper.getUserTickets(widget.userId);
    });
  }

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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
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
              const SizedBox(
                height: 50,
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _userTicketsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No tickets available');
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: snapshot.data!.map((ticket) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                                child: Text(
                              'Ticket Transfer in Progress',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            )),
                            const Center(
                                child: Text('Tickets have been sent to')),
                            Center(child: Text('${ticket['emailPhone']}')),
                            const SizedBox(
                              height: 30,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 30, right: 30),
                              child: Divider(
                                height: 0.5,
                                thickness: 1,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FutureBuilder<List<Map<String, dynamic>>>(
                              future: DatabaseHelper.getTicketsByTransferId(
                                  ticket['id']),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Text(
                                      'No ticket details available');
                                } else {
                                  List<Widget> ticketWidgets = [];
                                  for (int i = 0;
                                      i < snapshot.data!.length;
                                      i++) {
                                    final ticketDetails = snapshot.data![i];
                                    ticketWidgets.add(
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              const Text(
                                                'SECTION',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                  '${ticketDetails['selection']}'),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text(
                                                'ROW',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text('${ticketDetails['row']}'),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text(
                                                'SEAT',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text('${ticketDetails['seat']}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                    if (i < snapshot.data!.length - 1) {
                                      ticketWidgets.add(
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Center(
                                            child: Text(
                                                '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -',
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: ticketWidgets,
                                  );
                                }
                              },
                            ),
                          ],
                        );
                      }).toList(),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 46,
                    width: 362,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff0163D5),
                        width: 1.0,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Cancel Transfer',
                        style: TextStyle(
                          color: Color(0xff0163D5),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
