part of 'delivery_bloc.dart';

abstract class DeliveryEvent {}

class CalculateTrips extends DeliveryEvent {
  final String limitStr;  
  final List<int> weights;

  CalculateTrips({required this.limitStr, required this.weights});
}
