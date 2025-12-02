import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/utils/image_service.dart';
import '../../../shipment/data/shipment_repository.dart';

class DeliveryConfirmationScreen extends ConsumerStatefulWidget {
  final String shipmentId;

  const DeliveryConfirmationScreen({super.key, required this.shipmentId});

  @override
  ConsumerState<DeliveryConfirmationScreen> createState() => _DeliveryConfirmationScreenState();
}

class _DeliveryConfirmationScreenState extends ConsumerState<DeliveryConfirmationScreen> {
  XFile? _proofImage;
  bool _isSubmitting = false;

  Future<void> _pickImage() async {
    final file = await ref.read(imageServiceProvider).pickImage(ImageSource.camera);
    if (file != null) {
      setState(() => _proofImage = file);
    }
  }

  Future<void> _submit() async {
    if (_proofImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please take a proof photo')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // Compress and upload
      final compressed = await ref.read(imageServiceProvider).compressImage(_proofImage!);
      if (compressed == null) throw Exception('Compression failed');

      final url = await ref.read(storageServiceProvider).uploadImage(
            compressed,
            'delivery_proofs',
            'shipment_${widget.shipmentId}',
          );

      // Update shipment status (and potentially save proof URL in a separate table or column)
      // For MVP, we just update status. Ideally we'd save the URL too.
      // Let's assume we update status to 'delivered'
      await ref.read(shipmentRepositoryProvider).updateStatus(widget.shipmentId, 'delivered');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Delivery confirmed!')),
        );
        context.go('/driver-dashboard');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Delivery')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_proofImage != null)
              FutureBuilder<String>(
                future: _proofImage!.path.startsWith('http') 
                    ? Future.value(_proofImage!.path)
                    : Future.value(_proofImage!.path),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Image.network(snapshot.data!, height: 200, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: const Center(child: Icon(Icons.image, size: 50)),
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              )
            else
              Container(
                height: 200,
                color: Colors.grey[200],
                child: const Center(child: Icon(Icons.camera_alt, size: 50)),
              ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.camera),
              label: const Text('Take Photo'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text('Confirm Delivery'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
