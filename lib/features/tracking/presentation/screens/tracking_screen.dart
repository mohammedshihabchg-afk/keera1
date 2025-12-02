import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../controllers/tracking_controller.dart';

class TrackingScreen extends ConsumerStatefulWidget {
  final String shipmentId;

  const TrackingScreen({super.key, required this.shipmentId});

  @override
  ConsumerState<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends ConsumerState<TrackingScreen> {

  @override
  Widget build(BuildContext context) {
    final trackingAsync = ref.watch(trackingControllerProvider(widget.shipmentId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Tracking'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              final url = 'https://keera-tracking.com/tracking/${widget.shipmentId}';
              Share.share('Track your shipment: $url');
            },
          ),
        ],
      ),
      body: trackingAsync.when(
        data: (locationData) {
          if (locationData != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.map, size: 50, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('Map View (Disabled for Web MVP)'),
                  const SizedBox(height: 8),
                  Text('Driver Location: ${locationData['lat']}, ${locationData['lng']}'),
                ],
              ),
            );
          }
          return const Center(child: Text('Waiting for driver location...'));
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
