import React, { useState } from 'react';
import { Palette, Sun, Moon, ChevronDown, ChevronUp, X, Check } from 'lucide-react';

interface AppDrawerProps {
  isOpen: boolean;
  onClose: () => void;
  isDark: boolean;
  onSetTheme: (isDark: boolean) => void;
}

export const AppDrawer: React.FC<AppDrawerProps> = ({
  isOpen,
  onClose,
  isDark,
  onSetTheme,
}) => {
  const [isThemeExpanded, setIsThemeExpanded] = useState(true);

  if (!isOpen) return null;

  return (
    <div
      id="drawer-backdrop"
      className="fixed inset-0 z-50 flex"
      onClick={onClose}
    >
      {/* Backdrop */}
      <div className="fixed inset-0 bg-black/50 transition-opacity" />

      {/* Drawer surface */}
      <div
        id="app-drawer"
        role="dialog"
        aria-modal="true"
        className={`relative z-10 w-80 max-w-[85vw] h-full shadow-2xl flex flex-col transition-transform transform ${
          isDark
            ? 'bg-[#0A0A0A] text-[#E0E0E0] border-r border-[#333333]'
            : 'bg-white text-slate-800'
        }`}
        onClick={(e) => e.stopPropagation()}
      >
        {/* Drawer Header */}
        <div
          id="drawer-header"
          className={`h-36 flex flex-col justify-center items-center px-6 relative border-b ${
            isDark
              ? 'bg-[#000000] border-[#333333] text-[#FFBF00]'
              : 'bg-indigo-50/80 border-indigo-100 text-indigo-900'
          }`}
        >
          <button
            id="btn-close-drawer"
            onClick={onClose}
            aria-label="Fechar gaveta"
            className={`absolute top-4 right-4 p-1.5 rounded-lg transition-colors cursor-pointer ${
              isDark
                ? 'hover:bg-[#1A1A1A] text-[#888888] hover:text-[#FFBF00]'
                : 'hover:bg-indigo-100 text-indigo-400 hover:text-indigo-800'
            }`}
          >
            <X className="w-5 h-5" />
          </button>
          <h2 className="text-2xl font-bold tracking-tight">Configurações</h2>
          <p className={`text-xs mt-1 uppercase tracking-widest font-semibold ${isDark ? 'text-[#888888]' : 'text-indigo-600/80'}`}>
            Frisby Grade App
          </p>
        </div>

        {/* Drawer Content */}
        <div className="flex-1 overflow-y-auto py-3 px-3">
          {/* Mudar tema Accordion */}
          <div className={`rounded-xl border overflow-hidden transition-colors ${
            isDark ? 'border-[#333333] bg-[#111111]' : 'border-slate-200 bg-white'
          }`}>
            <button
              id="btn-toggle-theme-accordion"
              onClick={() => setIsThemeExpanded(!isThemeExpanded)}
              className={`w-full flex items-center justify-between px-4 py-3.5 transition-colors cursor-pointer ${
                isDark ? 'hover:bg-[#1A1A1A] text-[#E0E0E0]' : 'hover:bg-slate-50'
              }`}
            >
              <div className="flex items-center gap-3">
                <Palette
                  className={`w-5 h-5 ${
                    isDark ? 'text-[#FFBF00]' : 'text-indigo-600'
                  }`}
                />
                <span className="text-sm font-semibold tracking-wide">Mudar tema</span>
              </div>
              {isThemeExpanded ? (
                <ChevronUp className={`w-4 h-4 ${isDark ? 'text-[#888888]' : 'text-zinc-400'}`} />
              ) : (
                <ChevronDown className={`w-4 h-4 ${isDark ? 'text-[#888888]' : 'text-zinc-400'}`} />
              )}
            </button>

            {/* Expansion list */}
            {isThemeExpanded && (
              <div className={`p-2 space-y-1.5 border-t ${isDark ? 'border-[#333333]' : 'border-slate-100'}`}>
                {/* Tema Claro */}
                <button
                  id="btn-select-light-theme"
                  onClick={() => {
                    onSetTheme(false);
                    onClose();
                  }}
                  className={`w-full flex items-center justify-between px-4 py-3 rounded-lg text-sm transition-all cursor-pointer ${
                    !isDark
                      ? 'bg-indigo-50 text-indigo-700 font-semibold'
                      : 'hover:bg-[#1A1A1A] text-[#888888] hover:text-[#E0E0E0]'
                  }`}
                >
                  <div className="flex items-center gap-3">
                    <Sun className="w-4 h-4 text-amber-500" />
                    <span>Tema Claro</span>
                  </div>
                  {!isDark && <Check className="w-4 h-4 text-indigo-600" />}
                </button>

                {/* Tema Escuro */}
                <button
                  id="btn-select-dark-theme"
                  onClick={() => {
                    onSetTheme(true);
                    onClose();
                  }}
                  className={`w-full flex items-center justify-between px-4 py-3 rounded-lg text-sm transition-all cursor-pointer ${
                    isDark
                      ? 'bg-[#1A1A1A] text-[#FFBF00] font-bold border border-[#333333]'
                      : 'hover:bg-slate-100 text-slate-700'
                  }`}
                >
                  <div className="flex items-center gap-3">
                    <Moon className="w-4 h-4 text-[#FFBF00]" />
                    <span>Tema Escuro (Elegant Dark)</span>
                  </div>
                  {isDark && <Check className="w-4 h-4 text-[#FFBF00]" />}
                </button>
              </div>
            )}
          </div>
        </div>

        {/* Footer info */}
        <div
          className={`p-4 text-center text-[11px] uppercase tracking-widest font-bold border-t ${
            isDark
              ? 'bg-[#111111] border-[#333333] text-[#555555]'
              : 'border-slate-100 text-slate-400'
          }`}
        >
          Versão Web • Elegant Dark M3
        </div>
      </div>
    </div>
  );
};
