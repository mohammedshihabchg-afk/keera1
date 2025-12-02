import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/utils/image_service.dart';
import '../../../auth/data/auth_repository.dart';
import '../../data/driver_repository.dart';

part 'driver_registration_controller.g.dart';

@riverpod
class DriverRegistrationController extends _$DriverRegistrationController {
  @override
  FutureOr<void> build() {
    // no-op
  }

  Future<void> submitRegistration({
    required String fullName,
    required String phone,
    required XFile? profileImage,
    required String nationalId,
    required XFile nationalIdFront,
    required XFile? nationalIdBack,
    required String driverLicenseNumber,
    required String licenseType,
    required DateTime licenseExpiry,
    required XFile licenseImage,
    required String vehicleType,
    required String plateNumber,
    required String vehicleColor,
    required XFile vehicleImage,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final user = ref.read(authRepositoryProvider).currentUser;
      if (user == null) throw Exception('User not logged in');

      final storage = ref.read(storageServiceProvider);
      final imageService = ref.read(imageServiceProvider);

      // Helper to compress and upload
      Future<String> upload(XFile file, String path) async {
        final compressed = await imageService.compressImage(file);
        if (compressed == null) throw Exception('Failed to compress image');
        return await storage.uploadImage(compressed, 'driver_documents', '$path/${user.id}');
      }

      // Upload images
      final profileUrl = profileImage != null ? await upload(profileImage, 'profile') : null;
      final nidFrontUrl = await upload(nationalIdFront, 'national_id_front');
      final nidBackUrl = nationalIdBack != null ? await upload(nationalIdBack, 'national_id_back') : null;
      final licenseUrl = await upload(licenseImage, 'license');
      final vehicleUrl = await upload(vehicleImage, 'vehicle');

      // Create profile
      await ref.read(driverRepositoryProvider).createDriverProfile(
            userId: user.id,
            fullName: fullName,
            phone: phone,
            profileImageUrl: profileUrl,
            nationalId: nationalId,
            nationalIdFrontUrl: nidFrontUrl,
            nationalIdBackUrl: nidBackUrl,
            driverLicenseNumber: driverLicenseNumber,
            licenseType: licenseType,
            licenseExpiry: licenseExpiry,
            licenseImageUrl: licenseUrl,
            vehicleType: vehicleType,
            plateNumber: plateNumber,
            vehicleColor: vehicleColor,
            vehicleImageUrl: vehicleUrl,
          );
    });
  }
}
