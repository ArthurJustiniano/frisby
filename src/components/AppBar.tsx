import React from 'react';
import { Menu, Sun, Moon, Calculator } from 'lucide-react';

interface AppBarProps {
  title?: string;
  onOpenDrawer: () => void;
  isDark: boolean;
  onToggleTheme?: () => void;
}

export const AppBar: React.FC<AppBarProps> = ({
  title,
  onOpenDrawer,
  isDark,
  onToggleTheme,
}) => {
  return (
    <header
      id="app-bar"
      className={`h-16 px-4 sm:px-8 flex items-center justify-between sticky top-0 z-30 transition-colors ${
        isDark
          ? 'bg-[#000000] text-[#E0E0E0] border-b border-[#333333]'
          : 'bg-indigo-600 text-white shadow-md'
      }`}
    >
      <div className="flex items-center gap-3 sm:gap-4">
        <button
          id="btn-open-drawer"
          onClick={onOpenDrawer}
          aria-label="Abrir gaveta de navegação"
          className={`p-2 rounded-lg transition-colors cursor-pointer ${
            isDark
              ? 'text-[#888888] hover:text-[#FFBF00] hover:bg-[#1A1A1A] active:bg-[#222222]'
              : 'hover:bg-indigo-700 active:bg-indigo-800 text-white'
          }`}
        >
          <Menu className="w-5 h-5" />
        </button>

        {/* Brand Icon & Name */}
        <div className="flex items-center gap-2.5">
          <div
            className={`p-1.5 sm:p-2 rounded-lg ${
              isDark
                ? 'bg-[#FFBF00] text-black shadow-xs'
                : 'bg-white/20 text-white'
            }`}
          >
            <Calculator className="w-5 h-5 stroke-[2.2]" />
          </div>
          <span
            className={`text-xl sm:text-2xl font-bold tracking-tight ${
              isDark ? 'text-[#FFBF00]' : 'text-white'
            }`}
          >
            FRISBY
          </span>
        </div>

        {title && (
          <div className="hidden md:flex items-center gap-2 ml-2 pl-4 border-l border-[#333333]">
            <span className="text-xs font-semibold uppercase tracking-widest text-[#888888]">
              {title}
            </span>
          </div>
        )}
      </div>

      <div className="flex items-center gap-3 sm:gap-4">
        {/* Status Pill Badge */}
        <div
          className={`hidden sm:flex items-center gap-2 px-3 py-1 rounded-full text-xs font-medium border ${
            isDark
              ? 'bg-[#1A1A1A] border-[#333333] text-[#E0E0E0]'
              : 'bg-white/15 border-white/20 text-white'
          }`}
        >
          <div
            className={`w-2 h-2 rounded-full ${
              isDark ? 'bg-[#FFBF00] shadow-[0_0_8px_#FFBF00]' : 'bg-emerald-300'
            }`}
          />
          <span className="tracking-wide">
            {isDark ? 'MODO ESCURO' : 'MODO CLARO'}
          </span>
        </div>

        {/* Theme Toggle Button */}
        {onToggleTheme && (
          <button
            id="btn-quick-toggle-theme"
            onClick={onToggleTheme}
            aria-label={isDark ? 'Ativar tema claro' : 'Ativar tema escuro'}
            title={isDark ? 'Alternar para Tema Claro' : 'Alternar para Tema Escuro'}
            className={`p-2 rounded-lg transition-colors cursor-pointer ${
              isDark
                ? 'text-[#888888] hover:text-[#FFBF00] hover:bg-[#1A1A1A]'
                : 'hover:bg-indigo-700 text-white'
            }`}
          >
            {isDark ? <Sun className="w-5 h-5" /> : <Moon className="w-5 h-5" />}
          </button>
        )}
      </div>
    </header>
  );
};
