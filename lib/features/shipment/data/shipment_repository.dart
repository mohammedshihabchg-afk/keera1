import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/shipment.dart';

part 'shipment_repository.g.dart';

class ShipmentRepository {
  final SupabaseClient _supabase;

  ShipmentRepository(this._supabase);

  Future<List<Shipment>> getMyShipments() async {
    final userId = _supabase.auth.currentUser!.id;
    final data = await _supabase
        .from('shipments')
        .select()
        .eq('customer_id', userId)
        .order('created_at', ascending: false);
    
    return (data as List).map((e) => Shipment.fromJson(e)).toList();
  }

  Future<void> createShipment({
    required double pickupLat,
    required double pickupLng,
    required double dropoffLat,
    required double dropoffLng,
  }) async {
    final userId = _supabase.auth.currentUser!.id;
    await _supabase.from('shipments').insert({
      'customer_id': userId,
      'pickup_location_lat': pickupLat,
      'pickup_location_lng': pickupLng,
      'dropoff_location_lat': dropoffLat,
      'dropoff_location_lng': dropoffLng,
      'status': 'pending',
    });
  }

  Future<List<Shipment>> getAssignedShipments() async {
    final userId = _supabase.auth.currentUser!.id;
    final data = await _supabase
        .from('shipments')
        .select()
        .eq('driver_id', userId)
        .order('created_at', ascending: false);
    
    return (data as List).map((e) => Shipment.fromJson(e)).toList();
  }

  Future<void> updateStatus(String shipmentId, String status) async {
    await _supabase.from('shipments').update({'status': status}).eq('id', shipmentId);
  }
}

@riverpod
ShipmentRepository shipmentRepository(ShipmentRepositoryRef ref) {
  return ShipmentRepository(Supabase.instance.client);
}
