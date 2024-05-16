import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ticketapp/model/datamodel.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Artist.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE Artist(id INTEGER PRIMARY KEY, name TEXT NOT NULL, imageBytes BLOB NOT NULL);");
      await db.execute(
          "CREATE TABLE Show(id INTEGER PRIMARY KEY, artistId INTEGER, month TEXT NOT NULL, day INTEGER NOT NULL, time TEXT NOT NULL, name TEXT NOT NULL, location TEXT NOT NULL, fee TEXT NOT NULL, orderId TEXT, mapUrl TEXT, ticketType TEXT, FOREIGN KEY(artistId) REFERENCES Artist(id));");
      await db.execute(
          "CREATE TABLE Ticket(id INTEGER PRIMARY KEY, showId INTEGER, selection TEXT NOT NULL, row TEXT NOT NULL, seat INTEGER NOT NULL, FOREIGN KEY(showId) REFERENCES Show(id));");
    }, version: _version);
  }

  static Future<int> addArtist(Artist artist) async {
    final db = await _getDB();
    return await db.insert("Artist", artist.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateArtist(Artist artist) async {
    final db = await _getDB();
    return await db.update("Artist", artist.toJson(),
        where: 'id = ?',
        whereArgs: [artist.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteArtist(int id) async {
    final db = await _getDB();
    return await db.delete(
      "Artist",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<Artist?> getArtistById(int id) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'Artist',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      // Since id is unique, the list will contain only one element
      return Artist.fromJson(maps.first);
    } else {
      // Artist with the specified id not found
      return null;
    }
  }

  static Future<List<Artist>> getAllArtists() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Artist");

    return List.generate(maps.length, (index) {
      return Artist.fromJson(maps[index]);
    });
  }

  static Future<int> addShow(Show show) async {
    final db = await _getDB();
    print(show.toJson());
    return await db.insert("Show", show.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateShow(Show show) async {
    final db = await _getDB();
    return await db.update("Show", show.toJson(),
        where: 'id = ?',
        whereArgs: [show.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteShow(int id) async {
    final db = await _getDB();
    return await db.delete("Show", where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Show>> getAllShows() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Show");

    return List.generate(maps.length, (index) {
      return Show.fromJson(maps[index]);
    });
  }

  // Add this function to the DatabaseHelper class
  static Future<List<Map<String, dynamic>>> getShowsWithArtists() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT Show.*, Artist.name AS artistName, Artist.imageBytes AS artistImage
    FROM Show
    INNER JOIN Artist ON Show.artistId = Artist.id
  ''');

    return maps;
  }

  static Future<int> addTicket(Ticket ticket) async {
    final db = await _getDB();
    return await db.insert("Ticket", ticket.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateTicket(Ticket ticket) async {
    final db = await _getDB();
    return await db.update("Ticket", ticket.toJson(),
        where: 'id = ?',
        whereArgs: [ticket.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteTicket(int id) async {
    final db = await _getDB();
    return await db.delete("Ticket", where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Ticket>> getAllTickets() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Ticket");

    return List.generate(maps.length, (index) {
      return Ticket.fromJson(maps[index]);
    });
  }

  static Future<List<Map<String, dynamic>>>
      getTicketsWithShowsAndArtists() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT Ticket.*, Show.*, Artist.name AS artistName, Artist.imageBytes AS artistImage
    FROM Ticket
    INNER JOIN Show ON Ticket.showId = Show.id
    INNER JOIN Artist ON Show.artistId = Artist.id
  ''');

    return maps;
  }

  static Future<List<Map<String, dynamic>>> getShowsWithTickets() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT Show.*, Ticket.*
    FROM Show
    INNER JOIN Ticket ON Show.id = Ticket.showId
  ''');

    return maps;
  }

  static Future<List<Map<String, dynamic>>>
      getShowsWithDistinctTicketsAndTicketCount() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT Show.*, COUNT(Ticket.id) AS ticketCount, Artist.name AS artistName, Artist.imageBytes AS artistImage
    FROM Show
    LEFT JOIN Ticket ON Show.id = Ticket.showId
    LEFT JOIN Artist ON Show.artistId = Artist.id
    GROUP BY Show.id
    HAVING ticketCount > 0
  ''');

    return maps;
  }

  static Future<List<Map<String, dynamic>>> getTicketsForShow(
      int showId) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT Ticket.*, Show.fee AS fee, Show.ticketType AS ticketType, Artist.name AS artistName, Artist.imageBytes AS artistImage
    FROM Ticket
    INNER JOIN Show ON Ticket.showId = Show.id
    INNER JOIN Artist ON Show.artistId = Artist.id
    WHERE Show.id = ?
  ''', [showId]);

    return maps;
  }
}
