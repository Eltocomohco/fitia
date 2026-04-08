// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier para consultar recetas persistidas en Isar.

@ProviderFor(RecipeListNotifier)
final recipeListProvider = RecipeListNotifierProvider._();

/// Notifier para consultar recetas persistidas en Isar.
final class RecipeListNotifierProvider
    extends $AsyncNotifierProvider<RecipeListNotifier, List<Receta>> {
  /// Notifier para consultar recetas persistidas en Isar.
  RecipeListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recipeListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recipeListNotifierHash();

  @$internal
  @override
  RecipeListNotifier create() => RecipeListNotifier();
}

String _$recipeListNotifierHash() =>
    r'804dd363a4b8c111e6ddf09ce9fd583983cec588';

/// Notifier para consultar recetas persistidas en Isar.

abstract class _$RecipeListNotifier extends $AsyncNotifier<List<Receta>> {
  FutureOr<List<Receta>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Receta>>, List<Receta>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Receta>>, List<Receta>>,
              AsyncValue<List<Receta>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Notifier para gestionar el estado temporal de creación de recetas.

@ProviderFor(RecipeBuilderNotifier)
final recipeBuilderProvider = RecipeBuilderNotifierProvider._();

/// Notifier para gestionar el estado temporal de creación de recetas.
final class RecipeBuilderNotifierProvider
    extends $NotifierProvider<RecipeBuilderNotifier, RecipeBuilderState> {
  /// Notifier para gestionar el estado temporal de creación de recetas.
  RecipeBuilderNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recipeBuilderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recipeBuilderNotifierHash();

  @$internal
  @override
  RecipeBuilderNotifier create() => RecipeBuilderNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecipeBuilderState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecipeBuilderState>(value),
    );
  }
}

String _$recipeBuilderNotifierHash() =>
    r'7202726e299e6fb91b0154f523261075be504933';

/// Notifier para gestionar el estado temporal de creación de recetas.

abstract class _$RecipeBuilderNotifier extends $Notifier<RecipeBuilderState> {
  RecipeBuilderState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RecipeBuilderState, RecipeBuilderState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RecipeBuilderState, RecipeBuilderState>,
              RecipeBuilderState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
