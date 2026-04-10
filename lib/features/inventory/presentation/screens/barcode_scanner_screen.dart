import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/services/open_food_facts_service.dart';

/// Pantalla de escaneo de códigos de barras para autocompletar alimentos.
class BarcodeScannerScreen extends StatefulWidget {
  /// Crea una [BarcodeScannerScreen].
  const BarcodeScannerScreen({super.key});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  final MobileScannerController _controller = MobileScannerController();
  final OpenFoodFactsService _service = const OpenFoodFactsService();

  bool _isHandling = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleDetection(BarcodeCapture capture) async {
    if (_isHandling) {
      return;
    }

    final barcode = capture.barcodes.firstOrNull?.rawValue?.trim();
    if (barcode == null || barcode.isEmpty) {
      return;
    }

    _isHandling = true;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    await _controller.stop();

    try {
      final alimento = await _service.getMacrosFromBarcode(barcode);
      if (!mounted) {
        return;
      }

      context.pop(alimento);
      return;
    } on OpenFoodFactsLookupException catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _errorMessage = _messageForFailure(error.failure);
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _errorMessage = 'No se pudo consultar OpenFoodFacts. Inténtalo de nuevo.';
      });
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _isLoading = false;
      _isHandling = false;
    });
    await _controller.start();
  }

  String _messageForFailure(OpenFoodFactsLookupFailure failure) {
    return switch (failure) {
      OpenFoodFactsLookupFailure.invalidBarcode =>
        'El código detectado no es válido. Vuelve a intentarlo.',
      OpenFoodFactsLookupFailure.notFound =>
        'No se encontró ese producto en OpenFoodFacts.',
      OpenFoodFactsLookupFailure.network =>
        'Error de red al consultar el producto. Revisa la conexión.',
      OpenFoodFactsLookupFailure.invalidResponse =>
        'La respuesta del producto es incompleta o inválida.',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escanear alimento')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: _handleDetection,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_errorMessage != null)
                  Container(
                    margin: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade900.withValues(alpha: 0.88),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          _errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: _isLoading
                              ? null
                              : () {
                                  setState(() => _errorMessage = null);
                                },
                          icon: const Icon(Icons.center_focus_strong_outlined),
                          label: const Text('Seguir escaneando'),
                        ),
                      ],
                    ),
                  ),
                Container(
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'Apunta al código de barras del alimento para recuperar sus macros por 100 g.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            ColoredBox(
              color: Colors.black.withValues(alpha: 0.45),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}