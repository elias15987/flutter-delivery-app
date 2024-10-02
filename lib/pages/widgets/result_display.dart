import 'package:flutter/material.dart';

class ResultDisplay extends StatelessWidget {
  final List<List<int>> trips;
  final int totalTrips;

  const ResultDisplay({
    Key? key,
    required this.trips,
    required this.totalTrips,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Resultados:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        for (int i = 0; i < trips.length; i++)
          Text('Viaje ${i + 1}: ${trips[i].join(', ')}'),
        SizedBox(height: 10),
        Text('Total de viajes: $totalTrips', style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
