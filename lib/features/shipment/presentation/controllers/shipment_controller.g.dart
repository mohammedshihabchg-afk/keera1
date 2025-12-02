// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShipmentController)
const shipmentControllerProvider = ShipmentControllerProvider._();

final class ShipmentControllerProvider
    extends $AsyncNotifierProvider<ShipmentController, List<Shipment>> {
  const ShipmentControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shipmentControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shipmentControllerHash();

  @$internal
  @override
  ShipmentController create() => ShipmentController();
}

String _$shipmentControllerHash() =>
    r'83a6f9ca720046a87641d369b0b6f6239170f4d7';

abstract class _$ShipmentController extends $AsyncNotifier<List<Shipment>> {
  FutureOr<List<Shipment>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Shipment>>, List<Shipment>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Shipment>>, List<Shipment>>,
              AsyncValue<List<Shipment>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
