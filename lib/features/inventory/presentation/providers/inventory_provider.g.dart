// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador de estado para la lista de alimentos base.

@ProviderFor(InventoryNotifier)
final inventoryProvider = InventoryNotifierProvider._();

/// Controlador de estado para la lista de alimentos base.
final class InventoryNotifierProvider
    extends $AsyncNotifierProvider<InventoryNotifier, List<Alimento>> {
  /// Controlador de estado para la lista de alimentos base.
  InventoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inventoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inventoryNotifierHash();

  @$internal
  @override
  InventoryNotifier create() => InventoryNotifier();
}

String _$inventoryNotifierHash() => r'4358ba3f17781dc750f49d39f32f8dc4884acd00';

/// Controlador de estado para la lista de alimentos base.

abstract class _$InventoryNotifier extends $AsyncNotifier<List<Alimento>> {
  FutureOr<List<Alimento>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Alimento>>, List<Alimento>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Alimento>>, List<Alimento>>,
              AsyncValue<List<Alimento>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
