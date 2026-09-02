import React, { useState } from 'react';
import { ArrowLeft, CheckCircle2, AlertTriangle, Calculator, Sparkles } from 'lucide-react';

interface CalculatorScreenProps {
  weights: number[];
  onBack: () => void;
  isDark: boolean;
}

export const CalculatorScreen: React.FC<CalculatorScreenProps> = ({
  weights,
  onBack,
  isDark,
}) => {
  const [grades, setGrades] = useState<string[]>(() =>
    new Array(weights.length).fill('')
  );
  const [result, setResult] = useState<string>('Insira as notas');
  const [stats, setStats] = useState<{
    weightedSum: number;
    totalWeight: number;
    average: number | null;
  } | null>(null);

  const calculateWithValues = (currentGrades: string[]) => {
    let weightedSum = 0;
    let totalWeight = 0;

    for (let i = 0; i < weights.length; i++) {
      const sanitized = (currentGrades[i] || '').replace(',', '.').trim();
      const val = parseFloat(sanitized);
      const gradeVal = isNaN(val) ? 0.0 : val;
      const weightVal = weights[i];

      weightedSum += gradeVal * weightVal;
      totalWeight += weightVal;
    }

    if (totalWeight === 0) {
      setResult('Erro: Peso total zero');
      setStats({ weightedSum: 0, totalWeight: 0, average: null });
    } else {
      const average = weightedSum / totalWeight;
      setResult(`Média: ${average.toFixed(2)}`);
      setStats({ weightedSum, totalWeight, average });
    }
  };

  const handleGradeChange = (index: number, val: string) => {
    const updated = [...grades];
    updated[index] = val;
    setGrades(updated);
    // Also update dynamically if already calculated
    if (stats !== null) {
      calculateWithValues(updated);
    }
  };

  const calculate = () => {
    calculateWithValues(grades);
  };

  const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Enter') {
      e.preventDefault();
      calculate();
    }
  };

  const isCalculated = stats !== null && stats.average !== null;
  const isZeroError = result === 'Erro: Peso total zero';
  const averageValue = stats?.average;

  const getStatus = () => {
    if (!isCalculated || averageValue === null || averageValue === undefined) {
      return {
        label: 'Aguardando Notas',
        badgeClass: isDark
          ? 'bg-[#1f1f1f] text-[#888888] border-[#333333]'
          : 'bg-slate-100 text-slate-500 border-slate-200',
      };
    }
    if (averageValue >= 7.0) {
      return {
        label: 'Aprovado',
        badgeClass: isDark
          ? 'bg-[#052c16] text-[#4ade80] border-[#166534]'
          : 'bg-emerald-50 text-emerald-700 border-emerald-200',
      };
    }
    if (averageValue >= 5.0) {
      return {
        label: 'Recuperação',
        badgeClass: isDark
          ? 'bg-[#422006] text-[#fbbf24] border-[#b45309]'
          : 'bg-amber-50 text-amber-700 border-amber-200',
      };
    }
    return {
      label: 'Reprovado',
      badgeClass: isDark
        ? 'bg-[#450a0a] text-[#f87171] border-[#991b1b]'
        : 'bg-rose-50 text-rose-700 border-rose-200',
    };
  };

  const status = getStatus();

  return (
    <div
      id="calculator-screen"
      className="flex-1 flex flex-col max-w-2xl w-full mx-auto p-4 sm:p-6"
    >
      {/* Header section */}
      <div className="mb-5">
        <h3
          className={`text-2xl sm:text-3xl font-light tracking-tight mb-1.5 ${
            isDark ? 'text-[#E0E0E0]' : 'text-slate-900'
          }`}
        >
          Calculadora de{' '}
          <span
            className={`font-bold ${
              isDark ? 'text-[#FFBF00]' : 'text-indigo-600'
            }`}
          >
            Médias
          </span>
        </h3>
        <p
          className={`text-xs sm:text-sm max-w-lg ${
            isDark ? 'text-[#888888]' : 'text-slate-600'
          }`}
        >
          Insira suas notas para as disciplinas configuradas. Os cálculos são ponderados com base nos pesos definidos.
        </p>
      </div>

      {/* Grades Input Cards Grid */}
      <div className="flex-1 flex flex-col min-h-0">
        <div className="flex items-center justify-between px-1 mb-2.5">
          <span
            className={`text-xs font-semibold uppercase tracking-widest ${
              isDark ? 'text-[#888888]' : 'text-slate-500'
            }`}
          >
            Notas Avaliativas ({weights.length})
          </span>
          <span
            className={`text-[11px] ${
              isDark ? 'text-[#666666]' : 'text-slate-400'
            }`}
          >
            Pressione Enter ou clique em Calcular
          </span>
        </div>

        <div
          id="grades-input-list"
          className="flex-1 overflow-y-auto grid grid-cols-1 sm:grid-cols-2 gap-3.5 pr-1 scrollbar-thin"
        >
          {weights.map((weight, index) => (
            <div
              key={index}
              id={`grade-field-container-${index}`}
              className={`p-4 rounded-xl border transition-all group ${
                isDark
                  ? 'bg-[#1A1A1A] border-[#333333] focus-within:border-[#FFBF00] focus-within:bg-[#202020]'
                  : 'bg-white border-slate-200 focus-within:border-indigo-600 focus-within:ring-1 focus-within:ring-indigo-600/20 shadow-xs'
              }`}
            >
              <div className="flex items-center justify-between mb-2">
                <label
                  htmlFor={`grade-input-${index}`}
                  className={`text-xs font-bold uppercase tracking-widest transition-colors ${
                    isDark
                      ? 'text-[#888888] group-focus-within:text-[#FFBF00]'
                      : 'text-indigo-900 group-focus-within:text-indigo-600'
                  }`}
                >
                  Nota {String(index + 1).padStart(2, '0')}
                </label>
                <span
                  className={`text-xs font-semibold px-2 py-0.5 rounded ${
                    isDark
                      ? 'bg-black text-[#FFBF00] border border-[#333333]'
                      : 'bg-slate-100 text-slate-600'
                  }`}
                >
                  Peso {weight.toFixed(1)}
                </span>
              </div>

              <div className="relative">
                <input
                  id={`grade-input-${index}`}
                  type="text"
                  inputMode="decimal"
                  placeholder="0.0"
                  value={grades[index] || ''}
                  onChange={(e) => handleGradeChange(index, e.target.value)}
                  onKeyDown={handleKeyDown}
                  className={`w-full py-2 px-1 text-2xl font-light outline-none transition-all ${
                    isDark
                      ? 'bg-transparent text-[#E0E0E0] placeholder:text-[#444444] border-b-2 border-[#333333] focus:border-[#FFBF00]'
                      : 'bg-slate-50 text-slate-900 placeholder:text-slate-400 border rounded-lg px-3 py-2 border-slate-300 focus:border-indigo-600'
                  }`}
                />
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Result Display Box (Styled after Elegant Dark hero result card) */}
      <div
        id="result-container"
        className={`my-4 p-6 sm:p-7 rounded-2xl border transition-all ${
          isZeroError
            ? 'bg-red-500/10 border-red-500/30 text-red-500'
            : isDark
            ? 'bg-[#1A1A1A] border-[#333333]'
            : 'bg-indigo-50/80 border-indigo-200 text-indigo-950 shadow-sm'
        }`}
      >
        <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-4">
          <div>
            <div className="flex items-center gap-2 mb-1.5">
              {isZeroError ? (
                <AlertTriangle className="w-4 h-4 text-red-500" />
              ) : isCalculated ? (
                <Sparkles
                  className={`w-4 h-4 ${isDark ? 'text-[#FFBF00]' : 'text-indigo-600'}`}
                />
              ) : (
                <Calculator className="w-4 h-4 opacity-50" />
              )}
              <h4
                className={`text-xs uppercase font-bold tracking-widest ${
                  isDark ? 'text-[#888888]' : 'text-slate-500'
                }`}
              >
                Resultado Final
              </h4>
            </div>

            {/* Large Prominent Display */}
            <div className="flex items-baseline gap-2">
              <span
                className={`text-5xl sm:text-6xl font-bold tracking-tight leading-none ${
                  isZeroError
                    ? 'text-red-500 text-2xl sm:text-3xl'
                    : isCalculated
                    ? isDark
                      ? 'text-[#FFBF00]'
                      : 'text-indigo-700'
                    : isDark
                    ? 'text-[#555555]'
                    : 'text-slate-400'
                }`}
              >
                {isZeroError
                  ? 'Erro'
                  : isCalculated && averageValue !== null
                  ? averageValue.toFixed(2)
                  : '0.00'}
              </span>
            </div>

            {/* Original result text for compatibility */}
            <p
              id="calculation-result-text"
              className={`text-xs mt-2 font-medium ${
                isZeroError
                  ? 'text-red-500'
                  : isDark
                  ? 'text-[#888888]'
                  : 'text-slate-600'
              }`}
            >
              {result}
            </p>
          </div>

          <div className="sm:text-right">
            <p
              className={`text-xs uppercase font-bold tracking-widest mb-2 ${
                isDark ? 'text-[#888888]' : 'text-slate-500'
              }`}
            >
              Status Acadêmico
            </p>
            <span
              className={`px-5 py-2.5 font-bold rounded-full border uppercase tracking-widest text-xs inline-block shadow-xs ${status.badgeClass}`}
            >
              {status.label}
            </span>
          </div>
        </div>

        {/* Breakdown details */}
        {isCalculated && stats && (
          <div
            className={`mt-4 pt-4 border-t flex items-center justify-between text-xs ${
              isDark
                ? 'border-[#333333] text-[#888888]'
                : 'border-indigo-100 text-slate-600'
            }`}
          >
            <span>
              Soma Ponderada:{' '}
              <strong className={isDark ? 'text-[#E0E0E0]' : 'text-slate-800'}>
                {stats.weightedSum.toFixed(2)}
              </strong>
            </span>
            <span>
              Peso Total:{' '}
              <strong className={isDark ? 'text-[#FFBF00]' : 'text-slate-800'}>
                {stats.totalWeight.toFixed(1)}
              </strong>
            </span>
          </div>
        )}
      </div>

      {/* Navigation & Action Row */}
      <div className="flex items-center gap-3">
        <button
          id="btn-back-to-config"
          type="button"
          onClick={onBack}
          className={`flex-1 py-3.5 px-4 rounded-xl border font-bold text-sm flex items-center justify-center gap-2 transition-colors cursor-pointer ${
            isDark
              ? 'bg-[#1A1A1A] border-[#333333] text-[#888888] hover:text-[#E0E0E0] hover:bg-[#222222]'
              : 'border-slate-300 text-slate-700 hover:bg-slate-100'
          }`}
        >
          <ArrowLeft className="w-4 h-4" />
          <span>Voltar</span>
        </button>

        <button
          id="btn-perform-calculate"
          type="button"
          onClick={calculate}
          className={`flex-1 py-3.5 px-4 rounded-xl font-bold text-sm flex items-center justify-center gap-2 transition-all cursor-pointer ${
            isDark
              ? 'bg-[#FFBF00] hover:bg-[#E5AC00] text-black shadow-lg shadow-[#FFBF00]/10'
              : 'bg-indigo-600 hover:bg-indigo-500 text-white shadow-md shadow-indigo-600/20'
          }`}
        >
          <CheckCircle2 className="w-4 h-4 stroke-[2.5]" />
          <span>Calcular</span>
        </button>
      </div>
    </div>
  );
};
