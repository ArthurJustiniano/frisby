import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AcademicStatus {
  waiting,
  approved,
  recovery,
  failed,
}

class CalculationResult {
  final double weightedSum;
  final double totalWeight;
  final double? average;
  final String statusLabel;
  final AcademicStatus status;
  final String? errorMessage;

  CalculationResult({
    required this.weightedSum,
    required this.totalWeight,
    this.average,
    required this.statusLabel,
    required this.status,
    this.errorMessage,
  });
}

class GradeSettingsModel extends ChangeNotifier {
  static const String _prefKey = 'frisby_weights';
  List<double> _weights = [];

  GradeSettingsModel() {
    _loadFromPrefs();
  }

  List<double> get weights => List.unmodifiable(_weights);
  int get count => _weights.length;

  double get totalWeight => _weights.fold(0.0, (acc, w) => acc + w);

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefKey);
    if (saved != null) {
      try {
        final List<dynamic> decoded = jsonDecode(saved);
        _weights = decoded.map((e) => (e as num).toDouble()).toList();
        notifyListeners();
      } catch (_) {
        _weights = [];
      }
    }
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, jsonEncode(_weights));
  }

  void addWeight(double weight) {
    if (weight > 0) {
      _weights.add(weight);
      notifyListeners();
      _saveToPrefs();
    }
  }

  void removeWeight(int index) {
    if (index >= 0 && index < _weights.length) {
      _weights.removeAt(index);
      notifyListeners();
      _saveToPrefs();
    }
  }

  void resetWeights() {
    _weights.clear();
    notifyListeners();
    _saveToPrefs();
  }

  CalculationResult calculate(List<double> grades) {
    if (_weights.isEmpty) {
      return CalculationResult(
        weightedSum: 0,
        totalWeight: 0,
        statusLabel: 'Aguardando Notas',
        status: AcademicStatus.waiting,
        errorMessage: 'Nenhum peso configurado',
      );
    }

    double totalW = 0;
    double weightedSum = 0;

    for (int i = 0; i < _weights.length; i++) {
      final double gradeVal = (i < grades.length) ? grades[i] : 0.0;
      final double weightVal = _weights[i];
      weightedSum += gradeVal * weightVal;
      totalW += weightVal;
    }

    if (totalW == 0) {
      return CalculationResult(
        weightedSum: 0,
        totalWeight: 0,
        statusLabel: 'Erro de Peso',
        status: AcademicStatus.failed,
        errorMessage: 'Erro: Peso total zero',
      );
    }

    final double avg = weightedSum / totalW;
    AcademicStatus status;
    String statusLabel;

    if (avg >= 7.0) {
      status = AcademicStatus.approved;
      statusLabel = 'Aprovado';
    } else if (avg >= 5.0) {
      status = AcademicStatus.recovery;
      statusLabel = 'Recuperação';
    } else {
      status = AcademicStatus.failed;
      statusLabel = 'Reprovado';
    }

    return CalculationResult(
      weightedSum: weightedSum,
      totalWeight: totalW,
      average: avg,
      statusLabel: statusLabel,
      status: status,
    );
  }
}
