// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(driverRepository)
const driverRepositoryProvider = DriverRepositoryProvider._();

final class DriverRepositoryProvider
    extends
        $FunctionalProvider<
          DriverRepository,
          DriverRepository,
          DriverRepository
        >
    with $Provider<DriverRepository> {
  const DriverRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverRepositoryHash();

  @$internal
  @override
  $ProviderElement<DriverRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DriverRepository create(Ref ref) {
    return driverRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DriverRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DriverRepository>(value),
    );
  }
}

String _$driverRepositoryHash() => r'b08f23af42c7471db0283168c524db774ef45256';
