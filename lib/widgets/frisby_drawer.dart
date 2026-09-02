import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme_settings_model.dart';
import '../theme/app_theme.dart';

class FrisbyDrawer extends StatefulWidget {
  const FrisbyDrawer({super.key});

  @override
  State<FrisbyDrawer> createState() => _FrisbyDrawerState();
}

class _FrisbyDrawerState extends State<FrisbyDrawer> {
  bool _isThemeExpanded = true;

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeSettingsModel>(context);
    final isDark = themeModel.isDark;

    return Drawer(
      backgroundColor: isDark ? const Color(0xFF0A0A0A) : Colors.white,
      child: Column(
        children: [
          // Drawer Header
          Container(
            height: 140,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkBg : const Color(0xFFEEF2FF),
              border: Border(
                bottom: BorderSide(
                  color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                ),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Configurações',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppTheme.darkGold : AppTheme.lightPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'FRISBY GRADE APP',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Drawer List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? AppTheme.darkSurface : Colors.white,
                    border: Border.all(
                      color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isThemeExpanded = !_isThemeExpanded;
                          });
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          child: Row(
                            children: [
                              Icon(
                                Icons.palette_outlined,
                                color: isDark ? AppTheme.darkGold : AppTheme.lightPrimary,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Mudar tema',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                _isThemeExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (_isThemeExpanded) ...[
                        Divider(
                          height: 1,
                          color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              // Light Theme Option
                              ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                tileColor: !isDark ? const Color(0xFFEEF2FF) : Colors.transparent,
                                leading: const Icon(Icons.wb_sunny_outlined, color: Colors.amber, size: 20),
                                title: Text(
                                  'Tema Claro',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: !isDark ? FontWeight.bold : FontWeight.normal,
                                    color: !isDark ? AppTheme.lightPrimary : (isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextPrimary),
                                  ),
                                ),
                                trailing: !isDark
                                    ? const Icon(Icons.check, color: AppTheme.lightPrimary, size: 18)
                                    : null,
                                onTap: () {
                                  themeModel.setTheme(false);
                                  Navigator.of(context).pop();
                                },
                              ),

                              const SizedBox(height: 4),

                              // Dark Theme Option
                              ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: isDark
                                      ? const BorderSide(color: AppTheme.darkBorder)
                                      : BorderSide.none,
                                ),
                                tileColor: isDark ? AppTheme.darkCard : Colors.transparent,
                                leading: Icon(
                                  Icons.nightlight_round,
                                  color: isDark ? AppTheme.darkGold : Colors.indigo,
                                  size: 20,
                                ),
                                title: Text(
                                  'Tema Escuro (Elegant Dark)',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: isDark ? FontWeight.bold : FontWeight.normal,
                                    color: isDark ? AppTheme.darkGold : AppTheme.lightTextPrimary,
                                  ),
                                ),
                                trailing: isDark
                                    ? const Icon(Icons.check, color: AppTheme.darkGold, size: 18)
                                    : null,
                                onTap: () {
                                  themeModel.setTheme(true);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF111111) : Colors.white,
              border: Border(
                top: BorderSide(
                  color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                ),
              ),
            ),
            child: Text(
              'VERSÃO FLUTTER • ELEGANT DARK M3',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
