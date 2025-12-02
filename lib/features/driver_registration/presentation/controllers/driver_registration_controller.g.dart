// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_registration_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DriverRegistrationController)
const driverRegistrationControllerProvider =
    DriverRegistrationControllerProvider._();

final class DriverRegistrationControllerProvider
    extends $AsyncNotifierProvider<DriverRegistrationController, void> {
  const DriverRegistrationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverRegistrationControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverRegistrationControllerHash();

  @$internal
  @override
  DriverRegistrationController create() => DriverRegistrationController();
}

String _$driverRegistrationControllerHash() =>
    r'a3a69fbbca027485cd03a97856bc3e18ec985409';

abstract class _$DriverRegistrationController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
