// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(imageService)
const imageServiceProvider = ImageServiceProvider._();

final class ImageServiceProvider
    extends $FunctionalProvider<ImageService, ImageService, ImageService>
    with $Provider<ImageService> {
  const ImageServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imageServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imageServiceHash();

  @$internal
  @override
  $ProviderElement<ImageService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ImageService create(Ref ref) {
    return imageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImageService>(value),
    );
  }
}

String _$imageServiceHash() => r'5227ccccdfc6f900651dff7e55ce791bae15378b';
