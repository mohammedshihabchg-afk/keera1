// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TrackingController)
const trackingControllerProvider = TrackingControllerFamily._();

final class TrackingControllerProvider
    extends $StreamNotifierProvider<TrackingController, Map<String, dynamic>?> {
  const TrackingControllerProvider._({
    required TrackingControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'trackingControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$trackingControllerHash();

  @override
  String toString() {
    return r'trackingControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TrackingController create() => TrackingController();

  @override
  bool operator ==(Object other) {
    return other is TrackingControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$trackingControllerHash() =>
    r'b981146ddd6399a668cb904edd4080b36675b9bd';

final class TrackingControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          TrackingController,
          AsyncValue<Map<String, dynamic>?>,
          Map<String, dynamic>?,
          Stream<Map<String, dynamic>?>,
          String
        > {
  const TrackingControllerFamily._()
    : super(
        retry: null,
        name: r'trackingControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TrackingControllerProvider call(String shipmentId) =>
      TrackingControllerProvider._(argument: shipmentId, from: this);

  @override
  String toString() => r'trackingControllerProvider';
}

abstract class _$TrackingController
    extends $StreamNotifier<Map<String, dynamic>?> {
  late final _$args = ref.$arg as String;
  String get shipmentId => _$args;

  Stream<Map<String, dynamic>?> build(String shipmentId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<Map<String, dynamic>?>, Map<String, dynamic>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, dynamic>?>,
                Map<String, dynamic>?
              >,
              AsyncValue<Map<String, dynamic>?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
