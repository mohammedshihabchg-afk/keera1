import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LocationService {
  final SupabaseClient _supabase;

  LocationService(this._supabase);

  Future<void> startTracking() async {
    // Location tracking is not supported on web for this MVP
    print('Location tracking is not supported on web');
  }

  void stopTracking() {
    // No-op for web
  }
}

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService(Supabase.instance.client);
});
