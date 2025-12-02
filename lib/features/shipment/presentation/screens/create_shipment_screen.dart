import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/shipment_controller.dart';

class CreateShipmentScreen extends ConsumerStatefulWidget {
  const CreateShipmentScreen({super.key});

  @override
  ConsumerState<CreateShipmentScreen> createState() => _CreateShipmentScreenState();
}

class _CreateShipmentScreenState extends ConsumerState<CreateShipmentScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Using text fields for MVP simplicity, ideally map picker
  final _pickupLatController = TextEditingController();
  final _pickupLngController = TextEditingController();
  final _dropoffLatController = TextEditingController();
  final _dropoffLngController = TextEditingController();

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(shipmentControllerProvider.notifier).createShipment(
            pickupLat: double.parse(_pickupLatController.text),
            pickupLng: double.parse(_pickupLngController.text),
            dropoffLat: double.parse(_dropoffLatController.text),
            dropoffLng: double.parse(_dropoffLngController.text),
          );
      
      if (mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(shipmentControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('New Shipment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text('Pickup Location'),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _pickupLatController,
                      decoration: const InputDecoration(labelText: 'Lat'),
                      keyboardType: TextInputType.number,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _pickupLngController,
                      decoration: const InputDecoration(labelText: 'Lng'),
                      keyboardType: TextInputType.number,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Dropoff Location'),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _dropoffLatController,
                      decoration: const InputDecoration(labelText: 'Lat'),
                      keyboardType: TextInputType.number,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _dropoffLngController,
                      decoration: const InputDecoration(labelText: 'Lng'),
                      keyboardType: TextInputType.number,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.isLoading ? null : _submit,
                  child: state.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Create Shipment'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
