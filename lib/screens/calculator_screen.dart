import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/grade_settings_model.dart';
import '../models/theme_settings_model.dart';
import '../theme/app_theme.dart';
import '../widgets/frisby_app_bar.dart';
import '../widgets/frisby_drawer.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final List<TextEditingController> _controllers = [];
  CalculationResult? _result;

  @override
  void initState() {
    super.initState();
    final gradeModel = Provider.of<GradeSettingsModel>(context, listen: false);
    for (int i = 0; i < gradeModel.weights.length; i++) {
      _controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _calculate() {
    final gradeModel = Provider.of<GradeSettingsModel>(context, listen: false);
    final List<double> grades = [];

    for (final controller in _controllers) {
      final sanitized = controller.text.replaceAll(',', '.').trim();
      final val = double.tryParse(sanitized);
      grades.add(val ?? 0.0);
    }

    setState(() {
      _result = gradeModel.calculate(grades);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeSettingsModel>(context).isDark;
    final gradeModel = Provider.of<GradeSettingsModel>(context);
    final weights = gradeModel.weights;

    // Status colors
    Color statusBg;
    Color statusText;
    Color statusBorder;

    if (_result == null || _result!.average == null) {
      statusBg = isDark ? const Color(0xFF1F1F1F) : const Color(0xFFF1F5F9);
      statusText = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;
      statusBorder = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;
    } else if (_result!.status == AcademicStatus.approved) {
      statusBg = isDark ? AppTheme.approvedBgDark : const Color(0xFFECFDF5);
      statusText = isDark ? AppTheme.approvedTextDark : const Color(0xFF047857);
      statusBorder = isDark ? AppTheme.approvedBorderDark : const Color(0xFFA7F3D0);
    } else if (_result!.status == AcademicStatus.recovery) {
      statusBg = isDark ? AppTheme.recoveryBgDark : const Color(0xFFFFFBEB);
      statusText = isDark ? AppTheme.recoveryTextDark : const Color(0xFFB45309);
      statusBorder = isDark ? AppTheme.recoveryBorderDark : const Color(0xFFFDE68A);
    } else {
      statusBg = isDark ? AppTheme.failedBgDark : const Color(0xFFFFF1F2);
      statusText = isDark ? AppTheme.failedTextDark : const Color(0xFFBE123C);
      statusBorder = isDark ? AppTheme.failedBorderDark : const Color(0xFFFECDD3);
    }

    return Scaffold(
      appBar: const FrisbyAppBar(
        title: 'Cálculo',
        showBackButton: true,
      ),
      drawer: const FrisbyDrawer(),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                            letterSpacing: -0.5,
                            color: isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary,
                          ),
                          children: [
                            const TextSpan(text: 'Calculadora de '),
                            TextSpan(
                              text: 'Médias',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppTheme.darkGold : AppTheme.lightPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Insira suas notas para as disciplinas configuradas. Os cálculos são ponderados com base nos pesos definidos.',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Section Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'NOTAS AVALIATIVAS (${weights.length})',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                          color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                        ),
                      ),
                      Text(
                        'Preencha e toque em Calcular',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? const Color(0xFF666666) : const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Inputs List
                  Expanded(
                    child: ListView.separated(
                      itemCount: weights.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final weight = weights[index];
                        final controller = _controllers[index];

                        return Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: isDark ? AppTheme.darkCard : Colors.white,
                            border: Border.all(
                              color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'NOTA ${(index + 1).toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.1,
                                      color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightPrimary,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: isDark ? Colors.black : const Color(0xFFF1F5F9),
                                      border: Border.all(
                                        color: isDark ? AppTheme.darkBorder : Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'Peso ${weight.toStringAsFixed(1)}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: isDark ? AppTheme.darkGold : const Color(0xFF475569),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              TextField(
                                controller: controller,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                textInputAction: index == weights.length - 1
                                    ? TextInputAction.done
                                    : TextInputAction.next,
                                onSubmitted: (_) {
                                  if (index == weights.length - 1) {
                                    _calculate();
                                  }
                                },
                                onChanged: (_) {
                                  if (_result != null) {
                                    _calculate();
                                  }
                                },
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w300,
                                  color: isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary,
                                ),
                                decoration: InputDecoration(
                                  hintText: '0.0',
                                  hintStyle: TextStyle(
                                    color: isDark ? const Color(0xFF444444) : const Color(0xFF94A3B8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 4),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: isDark ? AppTheme.darkGold : AppTheme.lightPrimary,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Result Card
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.darkCard : const Color(0xFFF5F7FF),
                      border: Border.all(
                        color: isDark ? AppTheme.darkBorder : const Color(0xFFC7D2FE),
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        _result?.average != null
                                            ? Icons.auto_awesome
                                            : Icons.calculate_outlined,
                                        size: 16,
                                        color: isDark ? AppTheme.darkGold : AppTheme.lightPrimary,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'RESULTADO FINAL',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.1,
                                          color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    _result?.average != null
                                        ? _result!.average!.toStringAsFixed(2)
                                        : '0.00',
                                    style: TextStyle(
                                      fontSize: 44,
                                      fontWeight: FontWeight.w900,
                                      height: 1.0,
                                      color: _result?.average != null
                                          ? (isDark ? AppTheme.darkGold : AppTheme.lightPrimary)
                                          : (isDark ? const Color(0xFF555555) : const Color(0xFF94A3B8)),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _result?.errorMessage ??
                                        (_result?.average != null
                                            ? 'Média: ${_result!.average!.toStringAsFixed(2)}'
                                            : 'Insira as notas'),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Academic Status Badge
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'STATUS',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.1,
                                    color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: statusBg,
                                    border: Border.all(color: statusBorder),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    _result?.statusLabel ?? 'Aguardando Notas',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: statusText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        if (_result != null && _result!.average != null) ...[
                          const SizedBox(height: 14),
                          Divider(
                            height: 1,
                            color: isDark ? AppTheme.darkBorder : const Color(0xFFE0E7FF),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Soma Ponderada: ${_result!.weightedSum.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                                ),
                              ),
                              Text(
                                'Peso Total: ${_result!.totalWeight.toStringAsFixed(1)}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? AppTheme.darkGold : AppTheme.lightPrimary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Navigation & Actions
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
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _calculate,
                          icon: const Icon(Icons.check_circle_outline, size: 18),
                          label: const Text('Calcular', style: TextStyle(fontWeight: FontWeight.bold)),
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
