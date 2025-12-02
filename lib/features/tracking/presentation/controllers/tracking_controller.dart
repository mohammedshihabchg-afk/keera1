import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'tracking_controller.g.dart';

@riverpod
class TrackingController extends _$TrackingController {
  StreamSubscription? _subscription;

  @override
  Stream<Map<String, dynamic>?> build(String shipmentId) {
    final controller = StreamController<Map<String, dynamic>?>();

    // Fetch initial shipment data to get driver_id
    // For MVP, we'll just listen to the tracking_live table for the driver associated with this shipment
    // But first we need to know WHICH driver.
    // So we fetch the shipment first.
    
    _setupSubscription(shipmentId, controller);

    ref.onDispose(() {
      _subscription?.cancel();
      controller.close();
    });

    return controller.stream;
  }

  Future<void> _setupSubscription(String shipmentId, StreamController<Map<String, dynamic>?> controller) async {
    final supabase = Supabase.instance.client;
    
    // Get shipment to find driver_id
    final shipment = await supabase
        .from('shipments')
        .select('driver_id')
        .eq('id', shipmentId)
        .single();
    
    final driverId = shipment['driver_id'] as String?;

    if (driverId == null) {
      controller.add(null); // No driver assigned yet
      return;
    }

    // Listen to tracking_live for this driver
    _subscription = supabase
        .from('tracking_live')
        .stream(primaryKey: ['id'])
        .eq('driver_id', driverId)
        .listen((data) {
          if (data.isNotEmpty) {
            controller.add(data.first);
          }
        });
  }
}
