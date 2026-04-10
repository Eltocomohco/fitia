import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../tracking/presentation/providers/body_profile_provider.dart';

class OnboardingProfileScreen extends ConsumerStatefulWidget {
  const OnboardingProfileScreen({super.key});

  @override
  ConsumerState<OnboardingProfileScreen> createState() =>
      _OnboardingProfileScreenState();
}

class _OnboardingProfileScreenState
    extends ConsumerState<OnboardingProfileScreen> {
  static const List<String> _goalOptions = <String>[
    'Perder grasa',
    'Recomposicion corporal',
    'Mantener',
    'Ganar musculo',
  ];

  static const List<String> _hungerOptions = <String>[
    'Baja',
    'Media',
    'Alta',
    'Muy alta',
  ];

  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  late final TextEditingController _heightController;
  late final TextEditingController _goalController;
  late final TextEditingController _targetWeightController;
  late final TextEditingController _targetWeeksController;
  late final TextEditingController _hungerController;
  late final TextEditingController _satietyBreakfastController;
  late final TextEditingController _satietyLunchController;
  late final TextEditingController _satietyDinnerController;
  int _step = 0;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final profile =
        ref.read(bodyProfileProvider).asData?.value ?? const BodyProfileState();
    _nameController = TextEditingController(text: profile.nombre);
    _ageController = TextEditingController(text: profile.edad.toString());
    _heightController = TextEditingController(
      text: profile.alturaCm.toStringAsFixed(0),
    );
    _goalController = TextEditingController(text: profile.objetivoPrincipal);
    _targetWeightController = TextEditingController(
      text: profile.pesoObjetivoKg?.toStringAsFixed(1) ?? '',
    );
    _targetWeeksController = TextEditingController(
      text: profile.pesoObjetivoPlazoSemanas?.toString() ?? '',
    );
    _hungerController = TextEditingController(text: profile.hambreHabitual);
    _satietyBreakfastController = TextEditingController(
      text: profile.saciedadDesayuno,
    );
    _satietyLunchController = TextEditingController(text: profile.saciedadComida);
    _satietyDinnerController = TextEditingController(text: profile.saciedadCena);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _goalController.dispose();
    _targetWeightController.dispose();
    _targetWeeksController.dispose();
    _hungerController.dispose();
    _satietyBreakfastController.dispose();
    _satietyLunchController.dispose();
    _satietyDinnerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalSteps = 4;
    final progress = (_step + 1) / totalSteps;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(24, 28, 24, 24 + bottomInset),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 560,
                    minHeight: constraints.maxHeight - 52,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bienvenido a Fiti',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Vamos por capas. Cuatro pasos cortos y Fiti ya deja de hablarte como a un desconocido.',
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 18),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 10,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Paso ${_step + 1} de $totalSteps',
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(height: 18),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 220),
                        child: _buildStepCard(context),
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          _error!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      _buildActionBar(totalSteps),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionBar(int totalSteps) {
    final primaryButton = FilledButton.icon(
      onPressed: _saving
          ? null
          : (_step == totalSteps - 1 ? _save : _nextStep),
      icon: _saving
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(
              _step == totalSteps - 1 ? Icons.check : Icons.arrow_forward,
            ),
      label: Text(
        _saving
            ? 'Guardando...'
            : _step == totalSteps - 1
            ? 'Entrar a Fitia'
            : 'Seguir',
      ),
    );

    if (_step == 0) {
      return SizedBox(width: double.infinity, child: primaryButton);
    }

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 140,
          child: OutlinedButton(
            onPressed: _saving ? null : _previousStep,
            child: const Text('Atrás'),
          ),
        ),
        SizedBox(
          width: 220,
          child: primaryButton,
        ),
      ],
    );
  }

  Widget _buildStepCard(BuildContext context) {
    return Card(
      key: ValueKey(_step),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: switch (_step) {
          0 => _buildIdentityStep(context),
          1 => _buildBodyBasicsStep(context),
          2 => _buildGoalStep(context),
          _ => _buildSignalsStep(context),
        },
      ),
    );
  }

  Widget _buildIdentityStep(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Primero lo básico.',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          'Como quieres que Fiti te llame y un par de datos para no recomendarte disparates.',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Tu nombre',
            hintText: 'Ejemplo: Carlos',
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Edad'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _heightController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Altura (cm)'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _FriendlyHint(
          icon: Icons.favorite_outline,
          text: 'Health Connect lo conectas luego. No te paro aquí por eso.',
        ),
      ],
    );
  }

  Widget _buildBodyBasicsStep(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Ahora dame una dirección clara.',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          'No es lo mismo querer perder grasa que mantenerte. Y tampoco es lo mismo apuntar a 78 que a 90 kg.',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _goalOptions.map((option) {
            final selected = _goalController.text.trim() == option;
            return ChoiceChip(
              label: Text(option),
              selected: selected,
              onSelected: (_) {
                setState(() {
                  _goalController.text = option;
                });
              },
            );
          }).toList(growable: false),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _goalController,
          decoration: const InputDecoration(
            labelText: 'Objetivo principal',
            hintText: 'Perder grasa, recomposición, mantener...',
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _targetWeightController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Peso objetivo (kg)'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _targetWeeksController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'En cuántas semanas te gustaría llegar',
            hintText: 'Ejemplo: 12',
          ),
        ),
      ],
    );
  }

  Widget _buildGoalStep(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Quiero saber cómo aprieta el día a día.',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          'Si vives con hambre o llegas destrozado a comer, Fiti tiene que saberlo.',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        Text('Hambre habitual', style: theme.textTheme.titleSmall),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _hungerOptions.map((option) {
            final selected = _hungerController.text.trim() == option;
            return ChoiceChip(
              label: Text(option),
              selected: selected,
              onSelected: (_) {
                setState(() {
                  _hungerController.text = option;
                });
              },
            );
          }).toList(growable: false),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _hungerController,
          decoration: const InputDecoration(
            labelText: 'Si quieres matizarlo, escríbelo aquí',
          ),
        ),
      ],
    );
  }

  Widget _buildSignalsStep(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Última capa.',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          'Qué suele pasar después de comer. Aquí suele estar media adherencia real.',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        Text('Saciedad por comida', style: theme.textTheme.titleSmall),
        const SizedBox(height: 10),
        TextField(
          controller: _satietyBreakfastController,
          decoration: const InputDecoration(
            labelText: 'Después del desayuno',
            hintText: 'Acabo bien, me entra hambre rápido...',
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _satietyLunchController,
          decoration: const InputDecoration(
            labelText: 'Después de la comida',
            hintText: 'Me quedo bien, luego pico, llego reventado a cenar...',
          ),
          maxLines: 2,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _satietyDinnerController,
          decoration: const InputDecoration(
            labelText: 'Después de la cena',
            hintText: 'Termino saciado, necesito picar algo dulce...',
          ),
          maxLines: 2,
        ),
        const SizedBox(height: 20),
        _FriendlyHint(
          icon: Icons.smart_toy_outlined,
          text: 'Con esto Fiti ya puede hablarte con bastante más criterio desde el minuto uno.',
        ),
      ],
    );
  }

  void _nextStep() {
    final validationError = _validateCurrentStep();
    if (validationError != null) {
      setState(() {
        _error = validationError;
      });
      return;
    }

    setState(() {
      _error = null;
      _step += 1;
    });
  }

  void _previousStep() {
    setState(() {
      _error = null;
      _step -= 1;
    });
  }

  String? _validateCurrentStep() {
    switch (_step) {
      case 0:
        final age = int.tryParse(_ageController.text.trim());
        final height = double.tryParse(
          _heightController.text.trim().replaceAll(',', '.'),
        );
        if (_nameController.text.trim().isEmpty ||
            age == null ||
            age <= 0 ||
            height == null ||
            height <= 0) {
          return 'Necesito tu nombre, edad y altura para seguir.';
        }
        return null;
      case 1:
        final targetWeight = double.tryParse(
          _targetWeightController.text.trim().replaceAll(',', '.'),
        );
        final targetWeeks = int.tryParse(_targetWeeksController.text.trim());
        if (_goalController.text.trim().isEmpty ||
            targetWeight == null ||
            targetWeight <= 0 ||
            targetWeeks == null ||
            targetWeeks <= 0) {
          return 'Marca un objetivo, un peso objetivo y un plazo realista.';
        }
        return null;
      case 2:
        if (_hungerController.text.trim().isEmpty) {
          return 'Dime al menos cómo suele ir tu hambre.';
        }
        return null;
      default:
        if (_satietyBreakfastController.text.trim().isEmpty &&
            _satietyLunchController.text.trim().isEmpty &&
            _satietyDinnerController.text.trim().isEmpty) {
          return 'Cuéntame al menos cómo acabas en una de las comidas principales.';
        }
        return null;
    }
  }

  Future<void> _save() async {
    final validationError = _validateCurrentStep();
    if (validationError != null) {
      setState(() {
        _error = validationError;
      });
      return;
    }

    final name = _nameController.text.trim();
    final age = int.tryParse(_ageController.text.trim());
    final height = double.tryParse(
      _heightController.text.trim().replaceAll(',', '.'),
    );
    final goal = _goalController.text.trim();
    final targetWeight = double.tryParse(
      _targetWeightController.text.trim().replaceAll(',', '.'),
    );
    final targetWeeks = int.tryParse(_targetWeeksController.text.trim());
    final hunger = _hungerController.text.trim();
    final satietyBreakfast = _satietyBreakfastController.text.trim();
    final satietyLunch = _satietyLunchController.text.trim();
    final satietyDinner = _satietyDinnerController.text.trim();

    if (name.isEmpty ||
        age == null ||
        age <= 0 ||
        height == null ||
        height <= 0 ||
        goal.isEmpty ||
        targetWeight == null ||
        targetWeight <= 0 ||
        targetWeeks == null ||
        targetWeeks <= 0 ||
        hunger.isEmpty ||
        (satietyBreakfast.isEmpty &&
            satietyLunch.isEmpty &&
            satietyDinner.isEmpty)) {
      setState(() {
        _error = 'Completa nombre, edad, altura, objetivo, peso objetivo, plazo, hambre y al menos una saciedad por comida.';
      });
      return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });

    try {
      await ref.read(bodyProfileProvider.notifier).saveProfile(
            edad: age,
            alturaCm: height,
            nombre: name,
            objetivoPrincipal: goal,
            pesoObjetivoKg: targetWeight,
            pesoObjetivoPlazoSemanas: targetWeeks,
            hambreHabitual: hunger,
            saciedadDesayuno: satietyBreakfast,
            saciedadComida: satietyLunch,
            saciedadCena: satietyDinner,
          );
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _error = 'No se pudo guardar tu perfil inicial.';
        _saving = false;
      });
    }
  }
}

class _FriendlyHint extends StatelessWidget {
  const _FriendlyHint({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}