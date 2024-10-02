import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/package.dart';

part 'delivery_event.dart';
part 'delivery_state.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  DeliveryBloc() : super(DeliveryInitial()) {
    on<CalculateTrips>(_onCalculateTrips);
  }

  Future<void> _onCalculateTrips(CalculateTrips event, Emitter<DeliveryState> emit) async {
    emit(DeliveryLoading());

    final String limitStr = event.limitStr;
    final List<int> weights = event.weights;

    // Valido el string que sea un número entero
    final validationError = _validateLimitString(limitStr);
    if (validationError != null) {
      emit(DeliveryError(validationError));
      return;
    }

    // Convertir el límite a int
    final int limit = int.parse(limitStr);

    // Valido los datos datos
    final weightValidationError = _validateInputs(limit, weights);
    if (weightValidationError != null) {
      emit(DeliveryError(weightValidationError));
      return;
    }

    // Ordenar los pesos de mayor a menor
    weights.sort((a, b) => b.compareTo(a));

    List<List<int>> trips = [];

    for (int weight in weights) {
      // Intento añadir el paquete a un viaje existente
      bool addedToTrip = false;

      for (var trip in trips) {
        int currentWeight = trip.reduce((a, b) => a + b);
        if (currentWeight + weight <= limit) {
          trip.add(weight);
          addedToTrip = true;
          break;
        }
      }

      // Si no se pudo agregar a ningún viaje existente, creo un nuevo viaje
      if (!addedToTrip) {
        trips.add([weight]);
      }
    }

    emit(DeliveryCalculated(trips, trips.length));
  }

  //Validaciones

  String? _validateLimitString(String limitStr) {
    if (limitStr.isEmpty) {
      return 'El límite no puede estar vacío.';
    }
    final int? limit = int.tryParse(limitStr);
    if (limit == null) {
      return 'El límite debe ser un número entero válido.';
    }
    return null;
  }


  String? _validateInputs(int limit, List<int> weights) {
    if (limit <= 0) {
      return 'El límite debe ser mayor que cero.';
    }

    if (weights.isEmpty) {
      return 'Por favor, ingresar paquetes válidos.';
    }

    for (var weight in weights) {
      if (weight <= 0) {
        return 'Todos los pesos deben ser mayores que cero.';
      }
      if (weight > limit) {
        return 'Los pesos no deben superar el límite.';
      }
    }

    return null;
  }
}
