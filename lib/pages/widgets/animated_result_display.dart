import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';

class AnimatedResultDisplay extends StatefulWidget {
  final List<List<int>> trips;
  final int totalTrips;

  const AnimatedResultDisplay({
    Key? key,
    required this.trips,
    required this.totalTrips,
  }) : super(key: key);

  @override
  _AnimatedResultDisplayState createState() => _AnimatedResultDisplayState();
}

class _AnimatedResultDisplayState extends State<AnimatedResultDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _opacity = Tween<double>(begin: 0, end: 1).animate(_controller);
    _scale = Tween<double>(begin: 0.8, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedResultDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.trips != widget.trips || oldWidget.totalTrips != widget.totalTrips) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: FadeTransition(
        opacity: _opacity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resultados:',
              style: AppStyles.resultTitleStyle, // Usar el estilo de resultados
            ),
            SizedBox(height: 10),
            ...widget.trips.map((trip) => Text('Viaje: ${trip.join(', ')}')),
            SizedBox(height: 10),
            Text('Total de viajes: ${widget.totalTrips}', style: AppStyles.resultTextStyle),
          ],
        ),
      ),
    );
  }
}
