part of 'delivery_bloc.dart';

abstract class DeliveryState {}

class DeliveryInitial extends DeliveryState {}

class DeliveryLoading extends DeliveryState {}

class DeliveryCalculated extends DeliveryState {
  final List<List<int>> trips;
  final int totalTrips;

  DeliveryCalculated(this.trips, this.totalTrips);
}

class DeliveryError extends DeliveryState {
  final String message;

  DeliveryError(this.message);
}
