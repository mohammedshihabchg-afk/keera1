import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../shipment/data/shipment_repository.dart';

class QRScannerScreen extends ConsumerStatefulWidget {
  const QRScannerScreen({super.key});

  @override
  ConsumerState<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends ConsumerState<QRScannerScreen> {
  bool _isProcessing = false;

  /*
  void _onDetect(BarcodeCapture capture) async {
    if (_isProcessing) return;
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      if (barcode.rawValue != null) {
        setState(() => _isProcessing = true);
        final code = barcode.rawValue!;
        
        // Assume code is shipment ID or tracking code
        // For MVP, let's say it's shipment ID
        try {
          // Update status to picked_up (logic should be smarter)
          await ref.read(shipmentRepositoryProvider).updateStatus(code, 'picked_up');
          
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Shipment $code updated!')),
            );
            context.pop();
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: $e')),
            );
            setState(() => _isProcessing = false);
          }
        }
        return; 
      }
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Code')),
      body: Center(child: Text('QR Scanner not supported on Web yet')),
    );
  }
}
