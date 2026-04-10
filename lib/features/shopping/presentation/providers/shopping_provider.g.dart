// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Rango seleccionado para consolidar la lista de la compra.

@ProviderFor(ShoppingRange)
const shoppingRangeProvider = ShoppingRangeProvider._();

/// Rango seleccionado para consolidar la lista de la compra.
final class ShoppingRangeProvider
    extends $NotifierProvider<ShoppingRange, DateTimeRange<DateTime>> {
  /// Rango seleccionado para consolidar la lista de la compra.
  const ShoppingRangeProvider._()
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
    final created = build();
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
    element.handleValue(ref, created);
  }
}

/// Productos actualmente cargados en la despensa del usuario.

@ProviderFor(PantryInventory)
const pantryInventoryProvider = PantryInventoryProvider._();

/// Productos actualmente cargados en la despensa del usuario.
final class PantryInventoryProvider
    extends $AsyncNotifierProvider<PantryInventory, List<DespensaProducto>> {
  /// Productos actualmente cargados en la despensa del usuario.
  const PantryInventoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pantryInventoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pantryInventoryHash();

  @$internal
  @override
  PantryInventory create() => PantryInventory();
}

String _$pantryInventoryHash() => r'632dfcb3fc918ed576626df8807189d74a565bdb';

/// Productos actualmente cargados en la despensa del usuario.

abstract class _$PantryInventory
    extends $AsyncNotifier<List<DespensaProducto>> {
  FutureOr<List<DespensaProducto>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<DespensaProducto>>, List<DespensaProducto>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<DespensaProducto>>,
                List<DespensaProducto>
              >,
              AsyncValue<List<DespensaProducto>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ShoppingManualItems)
const shoppingManualItemsProvider = ShoppingManualItemsFamily._();

final class ShoppingManualItemsProvider
    extends
        $AsyncNotifierProvider<ShoppingManualItems, List<ShoppingManualItem>> {
  const ShoppingManualItemsProvider._({
    required ShoppingManualItemsFamily super.from,
    required (DateTime, DateTime) super.argument,
  }) : super(
         retry: null,
         name: r'shoppingManualItemsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$shoppingManualItemsHash();

  @override
  String toString() {
    return r'shoppingManualItemsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ShoppingManualItems create() => ShoppingManualItems();

  @override
  bool operator ==(Object other) {
    return other is ShoppingManualItemsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$shoppingManualItemsHash() =>
    r'c124215fba683dce3c65879a400b543d67e81ff3';

final class ShoppingManualItemsFamily extends $Family
    with
        $ClassFamilyOverride<
          ShoppingManualItems,
          AsyncValue<List<ShoppingManualItem>>,
          List<ShoppingManualItem>,
          FutureOr<List<ShoppingManualItem>>,
          (DateTime, DateTime)
        > {
  const ShoppingManualItemsFamily._()
    : super(
        retry: null,
        name: r'shoppingManualItemsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ShoppingManualItemsProvider call(DateTime start, DateTime end) =>
      ShoppingManualItemsProvider._(argument: (start, end), from: this);

  @override
  String toString() => r'shoppingManualItemsProvider';
}

abstract class _$ShoppingManualItems
    extends $AsyncNotifier<List<ShoppingManualItem>> {
  late final _$args = ref.$arg as (DateTime, DateTime);
  DateTime get start => _$args.$1;
  DateTime get end => _$args.$2;

  FutureOr<List<ShoppingManualItem>> build(DateTime start, DateTime end);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args.$1, _$args.$2);
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<ShoppingManualItem>>,
              List<ShoppingManualItem>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ShoppingManualItem>>,
                List<ShoppingManualItem>
              >,
              AsyncValue<List<ShoppingManualItem>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Consolida ingredientes por rango temporal para lista de la compra.

@ProviderFor(ShoppingListNotifier)
const shoppingListProvider = ShoppingListNotifierFamily._();

/// Consolida ingredientes por rango temporal para lista de la compra.
final class ShoppingListNotifierProvider
    extends
        $AsyncNotifierProvider<ShoppingListNotifier, List<ShoppingListItem>> {
  /// Consolida ingredientes por rango temporal para lista de la compra.
  const ShoppingListNotifierProvider._({
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
    r'53d60953e77bd571d7ccedd8c12c559e9fac0288';

/// Consolida ingredientes por rango temporal para lista de la compra.

final class ShoppingListNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ShoppingListNotifier,
          AsyncValue<List<ShoppingListItem>>,
          List<ShoppingListItem>,
          FutureOr<List<ShoppingListItem>>,
          (DateTime, DateTime)
        > {
  const ShoppingListNotifierFamily._()
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
    extends $AsyncNotifier<List<ShoppingListItem>> {
  late final _$args = ref.$arg as (DateTime, DateTime);
  DateTime get start => _$args.$1;
  DateTime get end => _$args.$2;

  FutureOr<List<ShoppingListItem>> build(DateTime start, DateTime end);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args.$1, _$args.$2);
    final ref =
        this.ref
            as $Ref<AsyncValue<List<ShoppingListItem>>, List<ShoppingListItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ShoppingListItem>>,
                List<ShoppingListItem>
              >,
              AsyncValue<List<ShoppingListItem>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
