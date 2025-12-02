import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    return pickedFile;
  }

  Future<XFile?> compressImage(XFile file) async {
    // On web, we skip compression for now or need a different approach
    // FlutterImageCompress supports web but needs different handling than file path
    // For MVP simplicity, just return the original file
    return file; 
  }
}

final imageServiceProvider = Provider<ImageService>((ref) {
  return ImageService();
});
