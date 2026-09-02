import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme_settings_model.dart';
import '../theme/app_theme.dart';

class FrisbyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final VoidCallback? onBack;

  const FrisbyAppBar({
    super.key,
    this.title,
    this.showBackButton = false,
    this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeSettingsModel>(context);
    final isDark = themeModel.isDark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkBg : AppTheme.lightPrimary,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppTheme.darkBorder : Colors.transparent,
            width: 1,
          ),
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              if (showBackButton)
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: isDark ? AppTheme.darkTextSecondary : Colors.white,
                  onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                  tooltip: 'Voltar',
                )
              else
                Builder(
                  builder: (ctx) => IconButton(
                    icon: const Icon(Icons.menu),
                    color: isDark ? AppTheme.darkTextSecondary : Colors.white,
                    onPressed: () => Scaffold.of(ctx).openDrawer(),
                    tooltip: 'Abrir menu',
                  ),
                ),
              const SizedBox(width: 8),

              // Brand Icon
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.darkGold : Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.calculate_rounded,
                  size: 20,
                  color: isDark ? Colors.black : Colors.white,
                ),
              ),
              const SizedBox(width: 8),

              // Title / Brand
              Text(
                'FRISBY',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  letterSpacing: 1.2,
                  color: isDark ? AppTheme.darkGold : Colors.white,
                ),
              ),

              if (title != null && title!.isNotEmpty) ...[
                const SizedBox(width: 12),
                Container(
                  height: 16,
                  width: 1,
                  color: isDark ? AppTheme.darkBorder : Colors.white.withOpacity(0.3),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                      color: isDark ? AppTheme.darkTextSecondary : Colors.white70,
                    ),
                  ),
                ),
              ] else
                const Spacer(),

              // Status Pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppTheme.darkCard
                      : Colors.white.withOpacity(0.15),
                  border: Border.all(
                    color: isDark
                        ? AppTheme.darkBorder
                        : Colors.white.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.darkGold : Colors.greenAccent,
                        shape: BoxShape.circle,
                        boxShadow: isDark
                            ? [
                                const BoxShadow(
                                  color: AppTheme.darkGold,
                                  blurRadius: 4,
                                )
                              ]
                            : null,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isDark ? 'ESCURO' : 'CLARO',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: isDark ? AppTheme.darkTextPrimary : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Theme Quick Switch
              IconButton(
                icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
                color: isDark ? AppTheme.darkGold : Colors.white,
                tooltip: isDark ? 'Mudar para tema claro' : 'Mudar para tema escuro',
                onPressed: () => themeModel.toggleTheme(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
