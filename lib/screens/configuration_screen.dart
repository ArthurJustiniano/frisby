import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/grade_settings_model.dart';
import '../models/theme_settings_model.dart';
import '../theme/app_theme.dart';
import '../widgets/frisby_app_bar.dart';
import '../widgets/frisby_drawer.dart';
import 'calculator_screen.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleAddWeight() {
    final text = _controller.text.replaceAll(',', '.').trim();
    final val = double.tryParse(text);

    if (val == null || val <= 0) {
      setState(() {
        _errorText = 'Digite um peso válido maior que 0';
      });
      return;
    }

    final gradeModel = Provider.of<GradeSettingsModel>(context, listen: false);
    gradeModel.addWeight(val);

    setState(() {
      _errorText = null;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeSettingsModel>(context).isDark;
    final gradeModel = Provider.of<GradeSettingsModel>(context);
    final weights = gradeModel.weights;
    final totalWeight = gradeModel.totalWeight;

    return Scaffold(
      appBar: const FrisbyAppBar(
        title: 'Configurar Pesos',
        showBackButton: true,
      ),
      drawer: const FrisbyDrawer(),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 580),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Section Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'CONFIGURAÇÃO DE PESOS',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                            color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                          ),
                        ),
                        Text(
                          '${weights.length} ${weights.length == 1 ? "nota configurada" : "notas configuradas"}',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Add Weight Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.darkCard : Colors.white,
                      border: Border.all(
                        color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: isDark
                          ? null
                          : [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ADICIONAR NOVO PESO',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                            color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightPrimary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                textInputAction: TextInputAction.done,
                                onSubmitted: (_) => _handleAddWeight(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Ex: 4.0 ou 6.0',
                                  hintStyle: TextStyle(
                                    color: isDark ? const Color(0xFF555555) : const Color(0xFF94A3B8),
                                  ),
                                  filled: true,
                                  fillColor: isDark ? Colors.black : const Color(0xFFF8FAFC),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: isDark ? AppTheme.darkGold : AppTheme.lightPrimary,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Add Button
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDark ? AppTheme.darkGold : AppTheme.lightPrimary,
                                foregroundColor: isDark ? Colors.black : Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: _handleAddWeight,
                              icon: const Icon(Icons.add, size: 18),
                              label: const Text(
                                'Adicionar',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 6),

                            // Reset Button
                            IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: isDark ? Colors.black : const Color(0xFFEEF2FF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: isDark ? AppTheme.darkBorder : const Color(0xFFC7D2FE),
                                  ),
                                ),
                                padding: const EdgeInsets.all(12),
                              ),
                              icon: Icon(
                                Icons.refresh,
                                size: 20,
                                color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightPrimary,
                              ),
                              tooltip: 'Resetar todos os pesos',
                              onPressed: () {
                                if (weights.isNotEmpty) {
                                  gradeModel.resetWeights();
                                }
                              },
                            ),
                          ],
                        ),
                        if (_errorText != null) ...[
                          const SizedBox(height: 6),
                          Text(
                            _errorText!,
                            style: const TextStyle(
                              color: Color(0xFFFF4444),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Weights List
                  Expanded(
                    child: weights.isEmpty
                        ? Container(
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF0A0A0A) : const Color(0xFFF8FAFC),
                              border: Border.all(
                                color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.scale_rounded,
                                      size: 40,
                                      color: isDark ? AppTheme.darkBorder : const Color(0xFFCBD5E1),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'NENHUM PESO ADICIONADO',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.1,
                                        color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Digite o peso da primeira avaliação no campo acima para iniciar a composição.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemCount: weights.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final weight = weights[index];
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: isDark ? AppTheme.darkCard : Colors.white,
                                  border: Border.all(
                                    color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'NOTA ${(index + 1).toString().padLeft(2, '0')}',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.0,
                                            color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'Peso ${weight.toStringAsFixed(1)}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: isDark ? AppTheme.darkGold : AppTheme.lightPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline_rounded),
                                      color: const Color(0xFFFF4444),
                                      onPressed: () => gradeModel.removeWeight(index),
                                      tooltip: 'Remover peso',
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),

                  const SizedBox(height: 12),

                  // Total Weight Container
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF111111) : Colors.white,
                      border: Border.all(
                        color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'PESO TOTAL',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1,
                                color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                              ),
                            ),
                            Text(
                              totalWeight.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppTheme.darkGold : AppTheme.lightPrimary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: (totalWeight / 10.0).clamp(0.0, 1.0),
                            minHeight: 6,
                            backgroundColor: isDark ? AppTheme.darkBorder : const Color(0xFFE2E8F0),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isDark ? AppTheme.darkGold : AppTheme.lightPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Bottom Navigation Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            foregroundColor: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                            side: BorderSide(
                              color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_back, size: 18),
                          label: const Text('Voltar', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: isDark ? AppTheme.darkGold : AppTheme.lightPrimary,
                            foregroundColor: isDark ? Colors.black : Colors.white,
                            disabledBackgroundColor: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFE2E8F0),
                            disabledForegroundColor: isDark ? const Color(0xFF555555) : const Color(0xFF94A3B8),
                            elevation: weights.isNotEmpty ? 2 : 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: weights.isEmpty
                              ? null
                              : () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const CalculatorScreen(),
                                    ),
                                  );
                                },
                          icon: const Icon(Icons.arrow_forward, size: 18),
                          label: const Text(
                            'Iniciar Cálculo',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
