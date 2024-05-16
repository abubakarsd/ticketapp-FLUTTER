import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ticketapp/componets/cards/accountcard.dart';
import 'package:ticketapp/model/datamodel.dart';
import 'package:ticketapp/pages/artist/listatist.dart';
import 'package:ticketapp/pages/show/showlist.dart';
import 'package:ticketapp/pages/ticket/ticketlist.dart';
import 'package:ticketapp/services/database_helper.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF127CF7),
        title: const Center(
          child: Text(
            "My Account",
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          FutureBuilder<List<Artist>>(
            future: DatabaseHelper.getAllArtists(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return AccountCard(
                  imagePath: 'assets/images/music-artist.png',
                  header: 'All Artist',
                  subheader: 'Click here to view or manage artists',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ArtistList(),
                      ),
                    );
                  },
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return AccountCard(
                  imagePath: 'assets/images/music-artist.png',
                  header: 'All Artist',
                  subheader: 'Click here to view or manage artists',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ArtistList(),
                      ),
                    );
                  },
                );
              } else {
                final List<Uint8List> artistImages = snapshot.data!
                    .take(3)
                    .map((artist) => artist.imageFile)
                    .toList();

                return AccountCard(
                  imagePath: 'assets/images/music-artist.png',
                  header: 'All Artist',
                  subheader: 'Click here to view or manage artists',
                  artistImages: artistImages,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ArtistList(),
                      ),
                    );
                  },
                );
              }
            },
          ),
          FutureBuilder<List<Show>>(
            future: DatabaseHelper.getAllShows(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: AccountCard(
                  imagePath: 'assets/images/concert.png',
                  header: 'All Shows',
                  subheader: 'Click here to view or manage shows',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShowList(),
                      ),
                    );
                  },
                ));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                    child: AccountCard(
                  imagePath: 'assets/images/concert.png',
                  header: 'All Shows',
                  subheader: 'Click here to view or manage shows',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShowList(),
                      ),
                    );
                  },
                ));
              } else {
                // final List<Uint8List> artistImages = snapshot.data!
                //     .take(3)
                //     .map((show) => show.artist)
                //     .toList();

                return AccountCard(
                  imagePath: 'assets/images/concert.png',
                  header: 'All Shows',
                  subheader: 'Click here to view or manage shows',
                  // artistImages: artistImages,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShowList(),
                      ),
                    );
                  },
                );
              }
            },
          ),
          FutureBuilder<List<Ticket>>(
            future: DatabaseHelper.getAllTickets(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: AccountCard(
                  imagePath: 'assets/images/ticket (2) 1.png',
                  header: 'All Tickets',
                  subheader: 'Click here to view or manage tickets',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TicketList(),
                      ),
                    );
                  },
                ));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                    child: AccountCard(
                  imagePath: 'assets/images/ticket (2) 1.png',
                  header: 'All Tickets',
                  subheader: 'Click here to view or manage tickets',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TicketList(),
                      ),
                    );
                  },
                ));
              } else {
                // final List<Uint8List> artistImages = snapshot.data!
                //     .take(3)
                //     .map((ticket) => ticket.show.artist.imageFile)
                //     .toList();

                return AccountCard(
                  imagePath: 'assets/images/ticket (2) 1.png',
                  header: 'All Tickets',
                  subheader: 'Click here to view or manage tickets',
                  // artistImages: artistImages,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TicketList(),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
