import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final SupabaseClient _supabase;

  StorageService(this._supabase);

  Future<String> uploadImage(XFile file, String bucket, String path) async {
    final bytes = await file.readAsBytes();
    final fileExt = file.name.split('.').last;
    final fileName = '${const Uuid().v4()}.$fileExt';
    final fullPath = '$path/$fileName';

    await _supabase.storage.from(bucket).uploadBinary(
          fullPath,
          bytes,
          fileOptions: FileOptions(contentType: 'image/$fileExt', upsert: true),
        );

    return _supabase.storage.from(bucket).getPublicUrl(fullPath);
  }
}

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService(Supabase.instance.client);
});
