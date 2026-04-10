import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_community/isar.dart';

import '../../../nutrition/data/models/alimento.dart';
import '../providers/inventory_provider.dart';

/// Formulario modal para crear un nuevo alimento base.
class AddFoodModal extends ConsumerStatefulWidget {
  /// Crea un [AddFoodModal].
  const AddFoodModal({super.key, this.initial, this.prefill});

  /// Alimento inicial para modo edición.
  final Alimento? initial;

  /// Datos precargados para alta rápida, por ejemplo desde el escáner.
  final Alimento? prefill;

  @override
  ConsumerState<AddFoodModal> createState() => _AddFoodModalState();
}

class _AddFoodModalState extends ConsumerState<AddFoodModal> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreCtrl;
  late final TextEditingController _kcalCtrl;
  late final TextEditingController _proteinasCtrl;
  late final TextEditingController _carbsCtrl;
  late final TextEditingController _grasasCtrl;
  late final TextEditingController _porcionCtrl;

  bool _isSaving = false;
  late Set<GrupoAlimento> _selectedGroups;

  bool get _isEditing => widget.initial != null;

  Alimento? get _seedData => widget.initial ?? widget.prefill;

  @override
  void initState() {
    super.initState();
    final initial = _seedData;
    _nombreCtrl = TextEditingController(text: initial?.nombre ?? '');
    _kcalCtrl = TextEditingController(
      text: initial == null ? '' : initial.kcal.toStringAsFixed(0),
    );
    _proteinasCtrl = TextEditingController(
      text: initial == null ? '' : initial.proteinas.toStringAsFixed(1),
    );
    _carbsCtrl = TextEditingController(
      text: initial == null ? '' : initial.carbohidratos.toStringAsFixed(1),
    );
    _grasasCtrl = TextEditingController(
      text: initial == null ? '' : initial.grasas.toStringAsFixed(1),
    );
    _porcionCtrl = TextEditingController(
      text: initial == null
          ? '100'
          : initial.porcionBaseGramos.toStringAsFixed(0),
    );

    _selectedGroups = {
      for (final value in (initial?.grupos ?? const <String>[]))
        ...GrupoAlimento.values.where((e) => e.label == value),
    };
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _kcalCtrl.dispose();
    _proteinasCtrl.dispose();
    _carbsCtrl.dispose();
    _grasasCtrl.dispose();
    _porcionCtrl.dispose();
    super.dispose();
  }

  String? _requiredNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obligatorio';
    }
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null) {
      return 'Ingresa un número válido';
    }
    if (parsed < 0) {
      return 'Debe ser mayor o igual a 0';
    }
    return null;
  }

  String? _requiredPositiveNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obligatorio';
    }
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null) {
      return 'Ingresa un número válido';
    }
    if (parsed <= 0) {
      return 'Debe ser mayor que 0';
    }
    return null;
  }

  Future<void> _scanBarcode() async {
    final scannedFood = await context.push<Alimento>('/inventory/barcode-scanner');
    if (!mounted || scannedFood == null) {
      return;
    }

    setState(() {
      _nombreCtrl.text = scannedFood.nombre;
      _kcalCtrl.text = _formatNumber(scannedFood.kcal);
      _proteinasCtrl.text = _formatNumber(scannedFood.proteinas);
      _carbsCtrl.text = _formatNumber(scannedFood.carbohidratos);
      _grasasCtrl.text = _formatNumber(scannedFood.grasas);
    });
  }

  String _formatNumber(double value) {
    return value.truncateToDouble() == value
        ? value.toStringAsFixed(0)
        : value.toStringAsFixed(1);
  }

  Future<void> _submit() async {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }

    setState(() => _isSaving = true);

    final alimento = Alimento(
      id: widget.initial?.id ?? Isar.autoIncrement,
      nombre: _nombreCtrl.text.trim(),
      kcal: double.parse(_kcalCtrl.text.replaceAll(',', '.')),
      proteinas: double.parse(_proteinasCtrl.text.replaceAll(',', '.')),
      carbohidratos: double.parse(_carbsCtrl.text.replaceAll(',', '.')),
      grasas: double.parse(_grasasCtrl.text.replaceAll(',', '.')),
      porcionBaseGramos: double.parse(_porcionCtrl.text.replaceAll(',', '.')),
      grupos: _selectedGroups.map((e) => e.label).toList(),
    );

    try {
      if (_isEditing) {
        await ref.read(inventoryProvider.notifier).updateAlimento(alimento);
      } else {
        await ref.read(inventoryProvider.notifier).addAlimento(alimento);
      }
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo guardar el alimento')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isEditing ? 'Editar alimento' : 'Nuevo alimento',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: _isSaving ? null : _scanBarcode,
                  icon: const Icon(Icons.qr_code_scanner_outlined),
                  label: const Text('Escanear código de barras'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _nombreCtrl,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _kcalCtrl,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Kcal',
                    helperText: 'Valores por ${_porcionCtrl.text.trim()} g',
                  ),
                  validator: _requiredNumber,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _porcionCtrl,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Porción base (g)',
                  ),
                  validator: _requiredPositiveNumber,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _proteinasCtrl,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(labelText: 'Proteínas (g)'),
                  validator: _requiredNumber,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _carbsCtrl,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Carbohidratos (g)',
                  ),
                  validator: _requiredNumber,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _grasasCtrl,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(labelText: 'Grasas (g)'),
                  validator: _requiredNumber,
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pertenece a grupos',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: GrupoAlimento.values.map((group) {
                    final selected = _selectedGroups.contains(group);
                    return FilterChip(
                      label: Text(group.label),
                      selected: selected,
                      onSelected: (value) {
                        setState(() {
                          if (value) {
                            _selectedGroups.add(group);
                          } else {
                            _selectedGroups.remove(group);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                if (_selectedGroups.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Selecciona al menos un grupo',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isSaving || _selectedGroups.isEmpty
                        ? null
                        : _submit,
                    icon: _isSaving
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save_outlined),
                    label: Text(
                      _isSaving
                          ? 'Guardando...'
                          : (_isEditing
                                ? 'Guardar cambios'
                                : 'Guardar alimento'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
