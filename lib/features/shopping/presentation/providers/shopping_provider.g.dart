// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Rango seleccionado para consolidar la lista de la compra.

@ProviderFor(ShoppingRange)
final shoppingRangeProvider = ShoppingRangeProvider._();

/// Rango seleccionado para consolidar la lista de la compra.
final class ShoppingRangeProvider
    extends $NotifierProvider<ShoppingRange, DateTimeRange<DateTime>> {
  /// Rango seleccionado para consolidar la lista de la compra.
  ShoppingRangeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shoppingRangeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shoppingRangeHash();

  @$internal
  @override
  ShoppingRange create() => ShoppingRange();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTimeRange<DateTime> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTimeRange<DateTime>>(value),
    );
  }
}

String _$shoppingRangeHash() => r'b33a874ab0c0e22f58847a42419bc4243b1ac5fe';

/// Rango seleccionado para consolidar la lista de la compra.

abstract class _$ShoppingRange extends $Notifier<DateTimeRange<DateTime>> {
  DateTimeRange<DateTime> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<DateTimeRange<DateTime>, DateTimeRange<DateTime>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTimeRange<DateTime>, DateTimeRange<DateTime>>,
              DateTimeRange<DateTime>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Consolida ingredientes por rango temporal para lista de la compra.

@ProviderFor(ShoppingListNotifier)
final shoppingListProvider = ShoppingListNotifierFamily._();

/// Consolida ingredientes por rango temporal para lista de la compra.
final class ShoppingListNotifierProvider
    extends
        $AsyncNotifierProvider<ShoppingListNotifier, Map<Alimento, double>> {
  /// Consolida ingredientes por rango temporal para lista de la compra.
  ShoppingListNotifierProvider._({
    required ShoppingListNotifierFamily super.from,
    required (DateTime, DateTime) super.argument,
  }) : super(
         retry: null,
         name: r'shoppingListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$shoppingListNotifierHash();

  @override
  String toString() {
    return r'shoppingListProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ShoppingListNotifier create() => ShoppingListNotifier();

  @override
  bool operator ==(Object other) {
    return other is ShoppingListNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$shoppingListNotifierHash() =>
    r'422ae95eee3dd847b0d8c2bd6592a34426456c7a';

/// Consolida ingredientes por rango temporal para lista de la compra.

final class ShoppingListNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ShoppingListNotifier,
          AsyncValue<Map<Alimento, double>>,
          Map<Alimento, double>,
          FutureOr<Map<Alimento, double>>,
          (DateTime, DateTime)
        > {
  ShoppingListNotifierFamily._()
    : super(
        retry: null,
        name: r'shoppingListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Consolida ingredientes por rango temporal para lista de la compra.

  ShoppingListNotifierProvider call(DateTime start, DateTime end) =>
      ShoppingListNotifierProvider._(argument: (start, end), from: this);

  @override
  String toString() => r'shoppingListProvider';
}

/// Consolida ingredientes por rango temporal para lista de la compra.

abstract class _$ShoppingListNotifier
    extends $AsyncNotifier<Map<Alimento, double>> {
  late final _$args = ref.$arg as (DateTime, DateTime);
  DateTime get start => _$args.$1;
  DateTime get end => _$args.$2;

  FutureOr<Map<Alimento, double>> build(DateTime start, DateTime end);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<Map<Alimento, double>>, Map<Alimento, double>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<Alimento, double>>,
                Map<Alimento, double>
              >,
              AsyncValue<Map<Alimento, double>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
