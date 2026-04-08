import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../nutrition/data/models/alimento.dart';
import '../providers/inventory_provider.dart';

/// Pantalla de alta de alimentos base del inventario.
class AddFoodScreen extends ConsumerStatefulWidget {
  /// Crea un [AddFoodScreen].
  const AddFoodScreen({super.key});

  @override
  ConsumerState<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends ConsumerState<AddFoodScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _kcalCtrl = TextEditingController();
  final _proteinasCtrl = TextEditingController();
  final _carbsCtrl = TextEditingController();
  final _grasasCtrl = TextEditingController();
  final Set<GrupoAlimento> _selectedGroups = <GrupoAlimento>{};

  bool _isSaving = false;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _kcalCtrl.dispose();
    _proteinasCtrl.dispose();
    _carbsCtrl.dispose();
    _grasasCtrl.dispose();
    super.dispose();
  }

  String? _requiredNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obligatorio';
    }
    final parsed = double.tryParse(value.trim().replaceAll(',', '.'));
    if (parsed == null) {
      return 'Número inválido';
    }
    if (parsed < 0) {
      return 'Debe ser mayor o igual a 0';
    }
    return null;
  }

  Future<void> _save() async {
    final form = _formKey.currentState;
    if (form == null || !form.validate() || _selectedGroups.isEmpty) {
      setState(() {});
      return;
    }

    setState(() => _isSaving = true);

    final nuevoAlimento = Alimento(
      nombre: _nombreCtrl.text.trim(),
      kcal: double.parse(_kcalCtrl.text.trim().replaceAll(',', '.')),
      proteinas: double.parse(_proteinasCtrl.text.trim().replaceAll(',', '.')),
      carbohidratos: double.parse(_carbsCtrl.text.trim().replaceAll(',', '.')),
      grasas: double.parse(_grasasCtrl.text.trim().replaceAll(',', '.')),
      porcionBaseGramos: 100,
      grupos: _selectedGroups.map((e) => e.label).toList(),
    );

    try {
      await ref.read(inventoryProvider.notifier).addAlimento(nuevoAlimento);
      if (!mounted) {
        return;
      }
      context.pop();
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo guardar el alimento')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo alimento')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Valores por 100 g',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nombreCtrl,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Campo obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _kcalCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Kcal'),
                validator: _requiredNumber,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _proteinasCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Proteínas'),
                validator: _requiredNumber,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _carbsCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Carbohidratos'),
                validator: _requiredNumber,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _grasasCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Grasas'),
                validator: _requiredNumber,
              ),
              const SizedBox(height: 16),
              Text('Grupos', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: GrupoAlimento.values.map((group) {
                  final isSelected = _selectedGroups.contains(group);
                  return FilterChip(
                    label: Text(group.label),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
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
                  child: Text(
                    'Selecciona al menos un grupo',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _isSaving ? null : _save,
                icon: _isSaving
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save_outlined),
                label: Text(_isSaving ? 'Guardando...' : 'Guardar alimento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
