import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/shipment_controller.dart';

class CustomerDashboardScreen extends ConsumerWidget {
  const CustomerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shipmentsAsync = ref.watch(shipmentControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Shipments')),
      body: shipmentsAsync.when(
        data: (shipments) => shipments.isEmpty
            ? const Center(child: Text('No shipments yet'))
            : ListView.builder(
                itemCount: shipments.length,
                itemBuilder: (context, index) {
                  final shipment = shipments[index];
                  return ListTile(
                    title: Text('Tracking Code: ${shipment.trackingCode}'),
                    subtitle: Text('Status: ${shipment.status}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigate to tracking details
                      context.push('/tracking/${shipment.id}');
                    },
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/create-shipment'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
