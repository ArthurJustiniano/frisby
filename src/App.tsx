/**
 * @license
 * SPDX-License-Identifier: Apache-2.0
 */

import { useState, useEffect } from 'react';
import { AnimatePresence, motion } from 'motion/react';
import { Screen } from './types.ts';
import { AppDrawer } from './components/AppDrawer.tsx';
import { AppBar } from './components/AppBar.tsx';
import { WelcomeScreen } from './components/WelcomeScreen.tsx';
import { ConfigurationScreen } from './components/ConfigurationScreen.tsx';
import { CalculatorScreen } from './components/CalculatorScreen.tsx';

export default function App() {
  // ThemeSettingsModel: default to Elegant Dark theme
  const [isDark, setIsDark] = useState<boolean>(() => {
    const saved = localStorage.getItem('frisby_theme');
    if (saved !== null) return saved === 'dark';
    return true; // Default to Elegant Dark
  });

  // GradeSettingsModel: list of weights
  const [weights, setWeights] = useState<number[]>(() => {
    try {
      const saved = localStorage.getItem('frisby_weights');
      return saved ? JSON.parse(saved) : [];
    } catch {
      return [];
    }
  });

  // Navigation state (simulating Navigator.push and Navigator.pop)
  const [currentScreen, setCurrentScreen] = useState<Screen>('welcome');
  const [isDrawerOpen, setIsDrawerOpen] = useState<boolean>(false);

  // Sync theme to localStorage and document root
  useEffect(() => {
    localStorage.setItem('frisby_theme', isDark ? 'dark' : 'light');
    if (isDark) {
      document.documentElement.classList.add('dark');
      document.documentElement.style.backgroundColor = '#000000';
    } else {
      document.documentElement.classList.remove('dark');
      document.documentElement.style.backgroundColor = '#f8fafc';
    }
  }, [isDark]);

  // Sync weights to localStorage
  useEffect(() => {
    localStorage.setItem('frisby_weights', JSON.stringify(weights));
  }, [weights]);

  // ThemeSettingsModel.setTheme
  const handleSetTheme = (dark: boolean) => {
    setIsDark(dark);
  };

  // GradeSettingsModel.addWeight
  const handleAddWeight = (weight: number) => {
    setWeights((prev) => [...prev, weight]);
  };

  // Remove individual weight
  const handleRemoveWeight = (index: number) => {
    setWeights((prev) => prev.filter((_, i) => i !== index));
  };

  // GradeSettingsModel.reset
  const handleResetWeights = () => {
    setWeights([]);
  };

  // Navigation handlers
  const handleStart = () => {
    setCurrentScreen('configuration');
  };

  const handleStartCalculation = () => {
    if (weights.length > 0) {
      setCurrentScreen('calculator');
    }
  };

  const handleBackToWelcome = () => {
    setCurrentScreen('welcome');
  };

  const handleBackToConfiguration = () => {
    setCurrentScreen('configuration');
  };

  // Determine AppBar title per Flutter spec:
  // WelcomeScreen: no title (AppBar())
  // ConfigurationScreen: "Configurar Pesos"
  // CalculatorScreen: "Cálculo"
  const getAppBarTitle = () => {
    switch (currentScreen) {
      case 'configuration':
        return 'Configurar Pesos';
      case 'calculator':
        return 'Cálculo';
      case 'welcome':
      default:
        return undefined;
    }
  };

  return (
    <div
      id="frisby-root"
      className={`min-h-screen flex flex-col font-sans transition-colors duration-300 ${
        isDark
          ? 'bg-[#000000] text-[#E0E0E0] selection:bg-[#FFBF00] selection:text-black'
          : 'bg-slate-50 text-slate-800 selection:bg-indigo-500 selection:text-white'
      }`}
    >
      {/* App Drawer */}
      <AppDrawer
        isOpen={isDrawerOpen}
        onClose={() => setIsDrawerOpen(false)}
        isDark={isDark}
        onSetTheme={handleSetTheme}
      />

      {/* App Bar */}
      <AppBar
        title={getAppBarTitle()}
        onOpenDrawer={() => setIsDrawerOpen(true)}
        isDark={isDark}
        onToggleTheme={() => setIsDark((prev) => !prev)}
      />

      {/* Body / Screen Switcher with Animated Transitions */}
      <main className="flex-1 flex flex-col relative overflow-hidden">
        <AnimatePresence mode="wait">
          {currentScreen === 'welcome' && (
            <motion.div
              key="welcome"
              initial={{ opacity: 0, scale: 0.98 }}
              animate={{ opacity: 1, scale: 1 }}
              exit={{ opacity: 0, scale: 0.98 }}
              transition={{ duration: 0.2 }}
              className="flex-1 flex flex-col"
            >
              <WelcomeScreen onStart={handleStart} isDark={isDark} />
            </motion.div>
          )}

          {currentScreen === 'configuration' && (
            <motion.div
              key="configuration"
              initial={{ opacity: 0, x: 20 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: -20 }}
              transition={{ duration: 0.2 }}
              className="flex-1 flex flex-col"
            >
              <ConfigurationScreen
                weights={weights}
                onAddWeight={handleAddWeight}
                onRemoveWeight={handleRemoveWeight}
                onReset={handleResetWeights}
                onBack={handleBackToWelcome}
                onStartCalculation={handleStartCalculation}
                isDark={isDark}
              />
            </motion.div>
          )}

          {currentScreen === 'calculator' && (
            <motion.div
              key="calculator"
              initial={{ opacity: 0, x: 20 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: -20 }}
              transition={{ duration: 0.2 }}
              className="flex-1 flex flex-col"
            >
              <CalculatorScreen
                weights={weights}
                onBack={handleBackToConfiguration}
                isDark={isDark}
              />
            </motion.div>
          )}
        </AnimatePresence>
      </main>

      {/* Footer bar matching Elegant Dark theme */}
      <footer
        id="app-footer"
        className={`px-6 py-2.5 flex justify-between items-center text-[10px] tracking-widest font-bold uppercase transition-colors border-t ${
          isDark
            ? 'bg-[#1A1A1A] border-[#333333] text-[#555555]'
            : 'bg-white border-slate-200 text-slate-400'
        }`}
      >
        <div className="flex items-center gap-6">
          <span>Build 2.4.1</span>
          <span>Engine: Flutter_M3</span>
          <span className="hidden sm:inline">User: Academico_Admin</span>
        </div>
        <div className="flex items-center gap-2">
          <span className={isDark ? 'text-[#FFBF00]' : 'text-indigo-600'}>
            Frisby Grade System
          </span>
        </div>
      </footer>
    </div>
  );
}

