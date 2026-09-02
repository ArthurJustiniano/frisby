import React, { useState, useRef } from 'react';
import { Plus, RotateCcw, ArrowLeft, ArrowRight, Trash2, Scale } from 'lucide-react';

interface ConfigurationScreenProps {
  weights: number[];
  onAddWeight: (weight: number) => void;
  onRemoveWeight: (index: number) => void;
  onReset: () => void;
  onBack: () => void;
  onStartCalculation: () => void;
  isDark: boolean;
}

export const ConfigurationScreen: React.FC<ConfigurationScreenProps> = ({
  weights,
  onAddWeight,
  onRemoveWeight,
  onReset,
  onBack,
  onStartCalculation,
  isDark,
}) => {
  const [inputValue, setInputValue] = useState('');
  const [inputError, setInputError] = useState<string | null>(null);
  const inputRef = useRef<HTMLInputElement>(null);

  const handleAddWeight = () => {
    const sanitized = inputValue.replace(',', '.').trim();
    const val = parseFloat(sanitized);

    if (isNaN(val) || val <= 0) {
      setInputError('Digite um peso válido maior que 0');
      return;
    }

    onAddWeight(val);
    setInputValue('');
    setInputError(null);
    inputRef.current?.focus();
  };

  const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Enter') {
      e.preventDefault();
      handleAddWeight();
    }
  };

  const totalConfiguredWeight = weights.reduce((acc, w) => acc + w, 0);

  return (
    <div
      id="configuration-screen"
      className="flex-1 flex flex-col max-w-xl w-full mx-auto p-4 sm:p-6"
    >
      {/* Section Header */}
      <div className="flex items-center justify-between mb-4 px-1">
        <h2
          className={`text-xs font-semibold uppercase tracking-widest ${
            isDark ? 'text-[#888888]' : 'text-slate-500'
          }`}
        >
          Configuração de Pesos
        </h2>
        <span
          className={`text-xs font-medium ${
            isDark ? 'text-[#888888]' : 'text-slate-400'
          }`}
        >
          {weights.length} {weights.length === 1 ? 'nota configurada' : 'notas configuradas'}
        </span>
      </div>

      {/* Add Weight Input Card */}
      <div
        className={`p-5 rounded-2xl border transition-colors mb-5 ${
          isDark
            ? 'bg-[#1A1A1A] border-[#333333]'
            : 'bg-white border-slate-200 shadow-sm'
        }`}
      >
        <div>
          <label
            htmlFor="weight-input"
            className={`block text-xs uppercase font-bold tracking-wider mb-2 ${
              isDark ? 'text-[#888888]' : 'text-indigo-600'
            }`}
          >
            Adicionar Novo Peso
          </label>
          <div className="flex items-center gap-2">
            <input
              id="weight-input"
              ref={inputRef}
              type="text"
              inputMode="decimal"
              placeholder="Ex: 4.0 ou 6.0"
              value={inputValue}
              onChange={(e) => {
                setInputValue(e.target.value);
                if (inputError) setInputError(null);
              }}
              onKeyDown={handleKeyDown}
              className={`flex-1 px-4 py-2.5 text-base rounded-lg border outline-none transition-all ${
                isDark
                  ? 'bg-black text-[#E0E0E0] placeholder:text-[#555555] border-[#333333] focus:border-[#FFBF00]'
                  : 'bg-slate-50 text-slate-900 placeholder:text-slate-400 border-slate-300 focus:border-indigo-600'
              } ${inputError ? 'border-red-500' : ''}`}
            />

            <button
              id="btn-add-weight"
              type="button"
              onClick={handleAddWeight}
              className={`py-2.5 px-4 sm:px-5 rounded-lg font-bold flex items-center justify-center gap-1.5 transition-colors cursor-pointer ${
                isDark
                  ? 'bg-[#FFBF00] hover:bg-[#E5AC00] text-black'
                  : 'bg-indigo-600 hover:bg-indigo-500 text-white shadow-sm'
              }`}
            >
              <Plus className="w-4 h-4 stroke-[2.5]" />
              <span className="text-sm">Adicionar</span>
            </button>

            <button
              id="btn-reset-weights"
              type="button"
              onClick={onReset}
              title="Resetar todos os pesos"
              className={`p-2.5 rounded-lg border flex items-center justify-center transition-colors cursor-pointer ${
                isDark
                  ? 'bg-black border-[#333333] text-[#888888] hover:text-[#FFBF00] hover:border-[#FFBF00]'
                  : 'bg-indigo-50 hover:bg-indigo-100 text-indigo-700 border-indigo-200'
              }`}
            >
              <RotateCcw className="w-4 h-4" />
            </button>
          </div>
          {inputError && (
            <p className="mt-1.5 text-xs text-[#FF4444] font-medium">
              {inputError}
            </p>
          )}
        </div>
      </div>

      {/* Registered Weights List */}
      <div className="flex-1 flex flex-col min-h-0">
        {weights.length === 0 ? (
          <div
            id="empty-weights-state"
            className={`flex-1 flex flex-col items-center justify-center p-8 rounded-2xl border border-dashed text-center min-h-[180px] ${
              isDark
                ? 'border-[#333333] bg-[#0A0A0A] text-[#888888]'
                : 'border-slate-200 bg-slate-50/50 text-slate-400'
            }`}
          >
            <Scale className="w-10 h-10 mb-3 opacity-40" />
            <p className="text-sm font-semibold uppercase tracking-wider">Nenhum peso adicionado</p>
            <p className="text-xs mt-1 max-w-xs text-opacity-80">
              Digite o peso da primeira avaliação no campo acima para iniciar a composição.
            </p>
          </div>
        ) : (
          <div
            id="weights-list"
            className="flex-1 overflow-y-auto space-y-2.5 pr-1 scrollbar-thin"
          >
            {weights.map((weight, index) => (
              <div
                key={index}
                id={`weight-card-${index}`}
                className={`p-4 rounded-xl border flex items-center justify-between transition-all ${
                  isDark
                    ? 'bg-[#1A1A1A] border-[#333333] text-[#E0E0E0] hover:border-[#444444]'
                    : 'bg-white border-slate-200 text-slate-800 shadow-xs hover:border-indigo-200'
                }`}
              >
                <div>
                  <p
                    className={`text-xs uppercase font-medium tracking-wider ${
                      isDark ? 'text-[#888888]' : 'text-slate-500'
                    }`}
                  >
                    Nota {String(index + 1).padStart(2, '0')}
                  </p>
                  <p
                    className={`text-lg font-bold tracking-tight mt-0.5 ${
                      isDark ? 'text-[#FFBF00]' : 'text-indigo-700'
                    }`}
                  >
                    Peso {weight.toFixed(1)}
                  </p>
                </div>

                <div className="flex items-center gap-2">
                  <button
                    id={`btn-remove-weight-${index}`}
                    onClick={() => onRemoveWeight(index)}
                    aria-label={`Remover nota ${index + 1}`}
                    title="Remover nota"
                    className={`p-2 rounded-lg transition-all cursor-pointer ${
                      isDark
                        ? 'text-[#FF4444] opacity-60 hover:opacity-100 hover:bg-[#261515]'
                        : 'text-slate-400 hover:text-red-600 hover:bg-slate-100'
                    }`}
                  >
                    <Trash2 className="w-4 h-4" />
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Peso Total Bar (Matching Elegant Dark design) */}
      <div
        id="total-weight-container"
        className={`mt-4 p-5 rounded-2xl border transition-colors ${
          isDark
            ? 'bg-[#111111] border-[#333333]'
            : 'bg-white border-slate-200 shadow-xs'
        }`}
      >
        <div className="flex justify-between items-center mb-2">
          <span
            className={`text-xs font-bold uppercase tracking-widest ${
              isDark ? 'text-[#888888]' : 'text-slate-500'
            }`}
          >
            Peso Total
          </span>
          <span
            className={`text-lg font-bold tracking-tight ${
              isDark ? 'text-[#FFBF00]' : 'text-indigo-600'
            }`}
          >
            {totalConfiguredWeight.toFixed(1)}
          </span>
        </div>
        <div
          className={`w-full h-1.5 rounded-full overflow-hidden ${
            isDark ? 'bg-[#333333]' : 'bg-slate-200'
          }`}
        >
          <div
            className={`h-full transition-all duration-300 ${
              isDark ? 'bg-[#FFBF00]' : 'bg-indigo-600'
            }`}
            style={{
              width: `${Math.min(100, Math.max(0, (totalConfiguredWeight / 10) * 100))}%`,
            }}
          />
        </div>
      </div>

      {/* Bottom Navigation Buttons */}
      <div className="pt-4 flex items-center gap-3">
        <button
          id="btn-back-to-welcome"
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
          id="btn-start-calculation"
          type="button"
          disabled={weights.length === 0}
          onClick={onStartCalculation}
          className={`flex-1 py-3.5 px-4 rounded-xl font-bold text-sm flex items-center justify-center gap-2 transition-all cursor-pointer ${
            weights.length === 0
              ? isDark
                ? 'bg-[#1A1A1A] border border-[#333333] text-[#555555] cursor-not-allowed opacity-50'
                : 'bg-slate-200 text-slate-400 cursor-not-allowed'
              : isDark
              ? 'bg-[#FFBF00] hover:bg-[#E5AC00] text-black shadow-lg shadow-[#FFBF00]/10'
              : 'bg-indigo-600 hover:bg-indigo-500 text-white shadow-md'
          }`}
        >
          <span>Iniciar Cálculo</span>
          <ArrowRight className="w-4 h-4" />
        </button>
      </div>
    </div>
  );
};
