import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../shipment/data/shipment_repository.dart';
import '../../shipment/domain/shipment.dart';

import '../../../../core/services/location_service.dart';

// Simple provider for driver tasks
final driverTasksProvider = FutureProvider<List<Shipment>>((ref) async {
  return ref.read(shipmentRepositoryProvider).getAssignedShipments();
});

class DriverDashboardScreen extends ConsumerWidget {
  const DriverDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(driverTasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {
              ref.read(locationServiceProvider).startTracking();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tracking started')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () => context.push('/qr-scanner'),
          ),
        ],
      ),
      body: tasksAsync.when(
        data: (tasks) => tasks.isEmpty
            ? const Center(child: Text('No assigned tasks'))
            : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text('Shipment #${task.trackingCode}'),
                    subtitle: Text('Status: ${task.status}'),
                    trailing: const Icon(Icons.map),
                    onTap: () {
                      // Open map for navigation
                      // context.push('/navigation/${task.id}');
                    },
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
