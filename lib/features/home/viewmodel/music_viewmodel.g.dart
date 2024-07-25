// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getMusicsHash() => r'2932901f5535d50e4504a13c9256bcfa139c4589';

/// See also [getMusics].
@ProviderFor(getMusics)
final getMusicsProvider = AutoDisposeFutureProvider<List<MusicModal>>.internal(
  getMusics,
  name: r'getMusicsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getMusicsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetMusicsRef = AutoDisposeFutureProviderRef<List<MusicModal>>;
String _$musicViewModelHash() => r'182419bac55d8c14ee7fde7f3bb072fd24967b64';

/// See also [MusicViewModel].
@ProviderFor(MusicViewModel)
final musicViewModelProvider = AutoDisposeNotifierProvider<MusicViewModel,
    AsyncValue<MusicModal>?>.internal(
  MusicViewModel.new,
  name: r'musicViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$musicViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MusicViewModel = AutoDisposeNotifier<AsyncValue<MusicModal>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
