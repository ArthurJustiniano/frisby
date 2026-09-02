export type Screen = 'welcome' | 'configuration' | 'calculator';

export type ThemeMode = 'light' | 'dark';

export interface AppState {
  isDark: boolean;
  weights: number[];
  currentScreen: Screen;
  isDrawerOpen: boolean;
}
