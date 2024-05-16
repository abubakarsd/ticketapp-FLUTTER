import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ticketapp/pages/ticket/allticket.dart';
import 'package:ticketapp/services/database_helper.dart';
import 'package:ticketapp/model/datamodel.dart';

class MyEvents extends StatefulWidget {
  const MyEvents({super.key});

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  List<Map<String, dynamic>> _showsWithTicketCounts = [];

  @override
  void initState() {
    super.initState();
    _loadShowsWithTicketCounts();
  }

  Future<void> _loadShowsWithTicketCounts() async {
    final showsWithTicketCounts =
        await DatabaseHelper.getShowsWithDistinctTicketsAndTicketCount();
    setState(() {
      _showsWithTicketCounts = showsWithTicketCounts;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0163D5),
        centerTitle: true,
        title: const Text(
          'My Events',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.refresh, color: Colors.white),
          )
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Upcoming Events'),
                SizedBox(
                  width: 15,
                ),
                Text('Past Events'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _showsWithTicketCounts.length,
              itemBuilder: (context, index) {
                final show = Show.fromJson(_showsWithTicketCounts[index]);
                final ticketCount =
                    _showsWithTicketCounts[index]['ticketCount'];
                final artistImage =
                    _showsWithTicketCounts[index]['artistImage'] as Uint8List;
                final artistName = _showsWithTicketCounts[index]['artistName'];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      String showData =
                          '${getMonthName(show.month)} ${show.day}, ${show.time} ${show.location}';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TicketListForShow(
                            showId: show.id!,
                            showData: showData,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: screenHeight * 0.26,
                      width: screenWidth * 0.7,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 111, 110, 110),
                        // image: DecorationImage(
                        //   image: MemoryImage(artistImage),
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 90,
                                      width: 127,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 111, 110, 110),
                                        image: DecorationImage(
                                          image: MemoryImage(artistImage),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // child: Image.memory(artistImage)),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('Order #${show.orderId}'),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  const Icon(Icons.arrow_forward_ios,
                                      color: Colors.white),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      getMonthName(show.month),
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      show.day.toString(),
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      show.time,
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    Text(
                                      artistName,
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Text(
                                      show.location,
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String getMonthName(String month) {
    switch (month) {
      case '01':
        return 'January';
      case '02':
        return 'February';
      case '03':
        return 'March';
      case '04':
        return 'April';
      case '05':
        return 'May';
      case '06':
        return 'June';
      case '07':
        return 'July';
      case '08':
        return 'August';
      case '09':
        return 'September';
      case '10':
        return 'October';
      case '11':
        return 'November';
      case '12':
        return 'December';
      default:
        return '';
    }
  }
}
