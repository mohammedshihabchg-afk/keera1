import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'driver_repository.g.dart';

class DriverRepository {
  final SupabaseClient _supabase;

  DriverRepository(this._supabase);

  Future<void> createDriverProfile({
    required String userId,
    required String fullName,
    required String phone,
    required String? profileImageUrl,
    required String nationalId,
    required String nationalIdFrontUrl,
    required String? nationalIdBackUrl,
    required String driverLicenseNumber,
    required String licenseType,
    required DateTime licenseExpiry,
    required String licenseImageUrl,
    required String vehicleType,
    required String plateNumber,
    required String vehicleColor,
    required String vehicleImageUrl,
  }) async {
    await _supabase.from('drivers').insert({
      'id': userId,
      'full_name': fullName,
      'phone': phone,
      'profile_image_url': profileImageUrl,
      'national_id': nationalId,
      'national_id_front_url': nationalIdFrontUrl,
      'national_id_back_url': nationalIdBackUrl,
      'driver_license_number': driverLicenseNumber,
      'license_type': licenseType,
      'license_expiry': licenseExpiry.toIso8601String(),
      'license_image_url': licenseImageUrl,
      'vehicle_type': vehicleType,
      'plate_number': plateNumber,
      'vehicle_color': vehicleColor,
      'vehicle_image_url': vehicleImageUrl,
      'verification_status': 'pending',
    });
  }
}

@riverpod
DriverRepository driverRepository(DriverRepositoryRef ref) {
  return DriverRepository(Supabase.instance.client);
}
