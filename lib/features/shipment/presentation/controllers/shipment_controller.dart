import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/shipment.dart';
import '../../data/shipment_repository.dart';

part 'shipment_controller.g.dart';

@riverpod
class ShipmentController extends _$ShipmentController {
  @override
  FutureOr<List<Shipment>> build() {
    return ref.read(shipmentRepositoryProvider).getMyShipments();
  }

  Future<void> createShipment({
    required double pickupLat,
    required double pickupLng,
    required double dropoffLat,
    required double dropoffLng,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(shipmentRepositoryProvider).createShipment(
            pickupLat: pickupLat,
            pickupLng: pickupLng,
            dropoffLat: dropoffLat,
            dropoffLng: dropoffLng,
          );
      return ref.read(shipmentRepositoryProvider).getMyShipments();
    });
  }
}
