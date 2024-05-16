import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ticketapp/componets/TextFields/BaseText.dart';
import 'package:ticketapp/componets/TextFields/TextFieldDecoration.dart';
import 'package:ticketapp/model/datamodel.dart';
import 'package:ticketapp/services/database_helper.dart';

class AddShow extends StatefulWidget {
  const AddShow({super.key});

  @override
  State<AddShow> createState() => _AddShowState();
}

class _AddShowState extends State<AddShow> {
  late TextEditingController _artistController;
  late TextEditingController _showName;
  late TextEditingController _showLocation;
  late TextEditingController _entryGate;
  late TextEditingController _orderID;
  late TextEditingController _mapURL;
  late TextEditingController _ticketType;
  late List<Artist> _artists;
  Artist? _selectedArtist;

  @override
  void initState() {
    super.initState();
    _loadArtists();
    _artistController = TextEditingController();
    _showName = TextEditingController();
    _showLocation = TextEditingController();
    _entryGate = TextEditingController();
    _orderID = TextEditingController();
    _mapURL = TextEditingController();
    _ticketType = TextEditingController();
    _artists = [];
  }

  // Function to load artists data
  void _loadArtists() async {
    _artists = await DatabaseHelper.getAllArtists();
    setState(() {}); // Update state to rebuild UI with loaded artists
  }

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void dispose() {
    _artistController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add new show",
          style: TextStyle(fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<Artist>(
                value: _selectedArtist,
                onChanged: (newValue) {
                  setState(() {
                    _selectedArtist = newValue;
                  });
                },
                items: _artists.map((artist) {
                  return DropdownMenuItem<Artist>(
                    value: artist,
                    child: Text(artist.name),
                  );
                }).toList(),
                decoration: inputDecoration(
                  context,
                  hintText: 'Select artist',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.datetime,
                controller: TextEditingController(
                  text: _selectedDate.month.toString().padLeft(2, '0'),
                ),
                decoration: inputDecoration(
                  context,
                  hintText: 'Month',
                  suffixIcon: Image.asset('assets/images/Calendar.png'),
                ),
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    initialDatePickerMode: DatePickerMode.day,
                  );
                  if (pickedDate != null && pickedDate != _selectedDate) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.datetime,
                controller: TextEditingController(
                  text: _selectedDate.day.toString().padLeft(2, '0'),
                ),
                decoration: inputDecoration(
                  context,
                  hintText: 'day',
                  suffixIcon: Image.asset('assets/images/Calendar.png'),
                ),
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    initialDatePickerMode: DatePickerMode.day,
                  );
                  if (pickedDate != null && pickedDate != _selectedDate) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: TextEditingController(
                  text: _selectedTime.format(context),
                ),
                decoration: inputDecoration(
                  context,
                  hintText: 'Time',
                  suffixIcon: Image.asset('assets/images/Clock.png'),
                ),
                onTap: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime,
                  );
                  if (pickedTime != null && pickedTime != _selectedTime) {
                    setState(() {
                      _selectedTime = pickedTime;
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: _showName,
                hintText: 'Show name',
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: _showLocation,
                hintText: 'Show location',
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: _entryGate,
                hintText: 'Entry Gate',
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: _orderID,
                hintText: 'Order ID',
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: _mapURL,
                hintText: 'Map Url',
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: _ticketType,
                hintText: 'Ticket Type',
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _addShow,
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF127CF7),
                ),
                child: const Text(
                  "Add Show",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addShow() async {
    final String showName = _showName.text;
    final String month = _selectedDate.month.toString().padLeft(2, '0');
    final String day = _selectedDate.day.toString().padLeft(2, '0');
    final String time = _selectedTime.format(context);

    if (showName.isNotEmpty && _selectedArtist != null) {
      final Show show = Show(
        name: showName,
        artistId: _selectedArtist!.id,
        month: month,
        day: int.parse(day),
        time: time,
        location: _showLocation.text,
        fee: double.parse(_entryGate.text), // Convert _entryGate.text to double
        orderId: _orderID.text,
        mapUrl: _mapURL.text,
        ticketType: _ticketType.text,
      );
      await DatabaseHelper.addShow(show);
      setState(() {
        _showName.clear(); // Clear show name controller
        _showLocation.clear(); // Clear show location controller
        _entryGate.clear(); // Clear entry gate controller
        _orderID.clear(); // Clear order ID controller
        _mapURL.clear(); // Clear map URL controller
        _ticketType.clear(); // Clear ticket type controller
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Show added successfully')),
      );
      Navigator.pop(context); // Pop current screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter show name and select an artist'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
