// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shipmentRepository)
const shipmentRepositoryProvider = ShipmentRepositoryProvider._();

final class ShipmentRepositoryProvider
    extends
        $FunctionalProvider<
          ShipmentRepository,
          ShipmentRepository,
          ShipmentRepository
        >
    with $Provider<ShipmentRepository> {
  const ShipmentRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shipmentRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shipmentRepositoryHash();

  @$internal
  @override
  $ProviderElement<ShipmentRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShipmentRepository create(Ref ref) {
    return shipmentRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShipmentRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShipmentRepository>(value),
    );
  }
}

String _$shipmentRepositoryHash() =>
    r'2c585ae3e47ae3bd5441656bc119f7a2a06d760f';
