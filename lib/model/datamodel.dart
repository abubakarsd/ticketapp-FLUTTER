import 'dart:typed_data';

class Artist {
  final int? id;
  final String name;
  final Uint8List imageFile;

  const Artist({
    this.id,
    required this.name,
    required this.imageFile,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageBytes': imageFile,
    };
  }

  factory Artist.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('JSON cannot be null');
    }
    return Artist(
      id: json['id'],
      name: json['name'] ?? '',
      imageFile: json['imageBytes'],
    );
  }
}

class Show {
  final int? id;
  final int? artistId;
  final String month;
  final int day;
  final String time;
  final String name;
  final String location;
  final double fee;
  final String? orderId;
  final String? mapUrl;
  final String? ticketType;

  Show({
    this.id,
    required this.artistId,
    required this.month,
    required this.day,
    required this.time,
    required this.name,
    required this.location,
    required this.fee,
    this.orderId,
    this.mapUrl,
    this.ticketType,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'artistId': artistId,
      'month': month,
      'day': day,
      'time': time,
      'name': name,
      'location': location,
      'fee': fee,
      'orderId': orderId,
      'mapUrl': mapUrl,
      'ticketType': ticketType,
    };
  }

  factory Show.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('JSON cannot be null');
    }
    return Show(
      id: json['id'],
      artistId: json['artistId'],
      month: json['month'] ?? '',
      day: json['day'] ?? 1,
      time: json['time'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      fee: json['fee'] ?? 0.0,
      orderId: json['orderId'],
      mapUrl: json['mapUrl'],
      ticketType: json['ticketType'],
    );
  }
}

class Ticket {
  final int? id;
  final int? showId;
  final String selection;
  final int row;
  final int seat;

  Ticket({
    this.id,
    required this.showId,
    required this.selection,
    required this.row,
    required this.seat,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'showId': showId,
      'selection': selection,
      'row': row,
      'seat': seat,
    };
  }

  factory Ticket.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('JSON cannot be null');
    }
    return Ticket(
      id: json['id'],
      showId: json['showId'],
      selection: json['selection'] ?? '',
      row: json['row'] ?? 0,
      seat: json['seat'] ?? 0,
    );
  }
}
