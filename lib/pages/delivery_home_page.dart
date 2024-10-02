import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/delivery_bloc.dart';
import 'widgets/text_field_widget.dart';
import 'widgets/animated_result_display.dart';
import '../styles/app_styles.dart';

class DeliveryHomePage extends StatelessWidget {
  final TextEditingController limitController = TextEditingController();
  final TextEditingController weightsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery App'),
        centerTitle: true,
        backgroundColor: AppStyles.backgroundAppColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Ingrese los detalles de la entrega',
              style: AppStyles.titleStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextFieldWidget(
              controller: limitController,
              label: 'Límite de peso por viaje',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextFieldWidget(
              controller: weightsController,
              label: 'Pesos de los paquetes (separados por comas)',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final limitText = limitController.text.trim();
                final weights = weightsController.text.split(',')
                    .map((weight) => int.tryParse(weight.trim()))
                    .where((weight) => weight != null)
                    .cast<int>()
                    .toList();

                // Enviar evento al Bloc
                final deliveryBloc = BlocProvider.of<DeliveryBloc>(context);
                deliveryBloc.add(CalculateTrips(limitStr: limitText, weights: weights));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppStyles.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 8),
              ),
              child: Text('Calcular Viajes', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            BlocListener<DeliveryBloc, DeliveryState>(
              listener: (context, state) {
                if (state is DeliveryError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: AppStyles.snackBarTheme.backgroundColor,
                      behavior: SnackBarBehavior.floating,
                      shape: AppStyles.snackBarTheme.shape,
                      elevation: AppStyles.snackBarTheme.elevation,
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: BlocBuilder<DeliveryBloc, DeliveryState>(
                builder: (context, state) {
                  if (state is DeliveryLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is DeliveryCalculated) {
                    return AnimatedResultDisplay(trips: state.trips, totalTrips: state.totalTrips);
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
