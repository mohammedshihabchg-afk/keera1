// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/image_service.dart';
import '../controllers/driver_registration_controller.dart';

class DriverRegistrationScreen extends ConsumerStatefulWidget {
  const DriverRegistrationScreen({super.key});

  @override
  ConsumerState<DriverRegistrationScreen> createState() => _DriverRegistrationScreenState();
}

class _DriverRegistrationScreenState extends ConsumerState<DriverRegistrationScreen> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Personal Data
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  XFile? _profileImage;

  // ID Data
  final _nationalIdController = TextEditingController();
  XFile? _nationalIdFront;
  XFile? _nationalIdBack;

  // License Data
  final _licenseNumberController = TextEditingController();
  final _licenseTypeController = TextEditingController();
  DateTime _licenseExpiry = DateTime.now().add(const Duration(days: 365));
  XFile? _licenseImage;

  // Vehicle Data
  final _vehicleTypeController = TextEditingController();
  final _plateNumberController = TextEditingController();
  final _vehicleColorController = TextEditingController();
  XFile? _vehicleImage;

  Future<void> _pickImage(void Function(XFile?) onPick) async {
    final file = await ref.read(imageServiceProvider).pickImage(ImageSource.gallery);
    if (file != null) {
      setState(() {
        onPick(file);
      });
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      if (_nationalIdFront == null || _licenseImage == null || _vehicleImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please upload all required images')),
        );
        return;
      }

      await ref.read(driverRegistrationControllerProvider.notifier).submitRegistration(
            fullName: _fullNameController.text,
            phone: _phoneController.text,
            profileImage: _profileImage,
            nationalId: _nationalIdController.text,
            nationalIdFront: _nationalIdFront!,
            nationalIdBack: _nationalIdBack,
            driverLicenseNumber: _licenseNumberController.text,
            licenseType: _licenseTypeController.text,
            licenseExpiry: _licenseExpiry,
            licenseImage: _licenseImage!,
            vehicleType: _vehicleTypeController.text,
            plateNumber: _plateNumberController.text,
            vehicleColor: _vehicleColorController.text,
            vehicleImage: _vehicleImage!,
          );
      
      if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration submitted successfully!')),
        );
        context.go('/home'); // Or waiting screen
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(driverRegistrationControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Driver Registration')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Stepper(
                currentStep: _currentStep,
                onStepContinue: () {
                  if (_currentStep < 3) {
                    setState(() => _currentStep++);
                  } else {
                    _submit();
                  }
                },
                onStepCancel: () {
                  if (_currentStep > 0) {
                    setState(() => _currentStep--);
                  }
                },
                steps: [
                  Step(
                    title: const Text('Personal Info'),
                    content: Column(
                      children: [
                        TextFormField(
                          controller: _fullNameController,
                          decoration: const InputDecoration(labelText: 'Full Name'),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(labelText: 'Phone'),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          title: const Text('Profile Image'),
                          subtitle: Text(_profileImage?.name ?? 'No image selected'),
                          trailing: const Icon(Icons.camera_alt),
                          onTap: () => _pickImage((f) => _profileImage = f),
                        ),
                      ],
                    ),
                  ),
                  Step(
                    title: const Text('ID Info'),
                    content: Column(
                      children: [
                        TextFormField(
                          controller: _nationalIdController,
                          decoration: const InputDecoration(labelText: 'National ID'),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          title: const Text('ID Front'),
                          subtitle: Text(_nationalIdFront?.name ?? 'No image selected'),
                          trailing: const Icon(Icons.camera_alt),
                          onTap: () => _pickImage((f) => _nationalIdFront = f),
                        ),
                        ListTile(
                          title: const Text('ID Back (Optional)'),
                          subtitle: Text(_nationalIdBack?.name ?? 'No image selected'),
                          trailing: const Icon(Icons.camera_alt),
                          onTap: () => _pickImage((f) => _nationalIdBack = f),
                        ),
                      ],
                    ),
                  ),
                  Step(
                    title: const Text('License Info'),
                    content: Column(
                      children: [
                        TextFormField(
                          controller: _licenseNumberController,
                          decoration: const InputDecoration(labelText: 'License Number'),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _licenseTypeController,
                          decoration: const InputDecoration(labelText: 'License Type'),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          title: const Text('License Image'),
                          subtitle: Text(_licenseImage?.name ?? 'No image selected'),
                          trailing: const Icon(Icons.camera_alt),
                          onTap: () => _pickImage((f) => _licenseImage = f),
                        ),
                      ],
                    ),
                  ),
                  Step(
                    title: const Text('Vehicle Info'),
                    content: Column(
                      children: [
                        TextFormField(
                          controller: _vehicleTypeController,
                          decoration: const InputDecoration(labelText: 'Vehicle Type'),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _plateNumberController,
                          decoration: const InputDecoration(labelText: 'Plate Number'),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _vehicleColorController,
                          decoration: const InputDecoration(labelText: 'Vehicle Color'),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          title: const Text('Vehicle Image'),
                          subtitle: Text(_vehicleImage?.name ?? 'No image selected'),
                          trailing: const Icon(Icons.camera_alt),
                          onTap: () => _pickImage((f) => _vehicleImage = f),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
