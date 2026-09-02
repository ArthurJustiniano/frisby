import React from 'react';
import { Calculator, ArrowRight, Sparkles } from 'lucide-react';

interface WelcomeScreenProps {
  onStart: () => void;
  isDark: boolean;
}

export const WelcomeScreen: React.FC<WelcomeScreenProps> = ({ onStart, isDark }) => {
  return (
    <div
      id="welcome-screen"
      className={`flex-1 flex flex-col items-center justify-center p-6 text-center select-none ${
        isDark ? 'bg-gradient-to-br from-[#000000] to-[#0A0A0A]' : 'bg-transparent'
      }`}
    >
      <div className="max-w-md w-full flex flex-col items-center">
        {/* Calculator Icon Badge */}
        <div
          id="hero-calculator-icon"
          className={`w-24 h-24 rounded-2xl flex items-center justify-center mb-6 transition-all duration-300 shadow-xl ${
            isDark
              ? 'bg-[#FFBF00] text-black shadow-[#FFBF00]/10'
              : 'bg-indigo-600 text-white shadow-indigo-600/20'
          }`}
        >
          <Calculator className="w-14 h-14 stroke-[2]" />
        </div>

        {/* Title */}
        <h1
          id="app-hero-title"
          className={`text-4xl sm:text-5xl font-light tracking-tight mb-3 ${
            isDark ? 'text-[#E0E0E0]' : 'text-slate-900'
          }`}
        >
          Frisby <span className={`font-bold ${isDark ? 'text-[#FFBF00]' : 'text-indigo-600'}`}>Médias</span>
        </h1>

        <p
          className={`text-base mb-8 max-w-sm ${
            isDark ? 'text-[#888888]' : 'text-slate-600'
          }`}
        >
          Calculadora de média ponderada com cálculo em tempo real e suporte a múltiplos pesos.
        </p>

        {/* Action Button: "Começar" */}
        <button
          id="btn-start"
          onClick={onStart}
          className={`group inline-flex items-center justify-center gap-3 px-10 py-4 sm:py-5 rounded-xl text-lg font-bold shadow-lg transition-all duration-200 active:scale-95 cursor-pointer ${
            isDark
              ? 'bg-[#FFBF00] hover:bg-[#E5AC00] text-black shadow-[#FFBF00]/20 hover:shadow-[#FFBF00]/30'
              : 'bg-indigo-600 hover:bg-indigo-500 text-white shadow-indigo-600/25 hover:shadow-indigo-600/40'
          }`}
        >
          <span>Começar</span>
          <ArrowRight className="w-5 h-5 transition-transform group-hover:translate-x-1" />
        </button>

        {/* Quick hint */}
        <div
          className={`mt-10 flex items-center gap-2 text-xs uppercase tracking-widest font-semibold ${
            isDark ? 'text-[#888888]' : 'text-slate-400'
          }`}
        >
          <Sparkles className="w-3.5 h-3.5" />
          <span>Configure os pesos e inicie o cálculo</span>
        </div>
      </div>
    </div>
  );
};
