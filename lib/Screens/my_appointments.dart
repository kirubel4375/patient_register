import 'package:flutter/material.dart';

class MyAppointments extends StatelessWidget {
  const MyAppointments({ Key? key, required this.appointedDate, required this.id }) : super(key: key);
  final DateTime appointedDate;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            child: Column(
              children: [
                Text(appointedDate.day.toString()),
                Text(id),
                TextButton(onPressed: (){}, child: const Text("cancele appointment"),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}