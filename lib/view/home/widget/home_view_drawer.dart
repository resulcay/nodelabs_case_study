import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_flags/country_flags.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodelabs_case_study/product/constant/color.dart';
import 'package:nodelabs_case_study/product/constant/locales.dart';
import 'package:nodelabs_case_study/product/global/global_declaration.dart';
import 'package:nodelabs_case_study/product/network/base_config/dio_manager.dart';
import 'package:nodelabs_case_study/view_model/theme/theme_view_model.dart';

class HomeViewDrawer extends StatefulWidget {
  const HomeViewDrawer({
    required this.mainContext,
    super.key,
  });

  final BuildContext mainContext;

  @override
  State<HomeViewDrawer> createState() => _HomeViewDrawerState();
}

class _HomeViewDrawerState extends State<HomeViewDrawer>
    with TickerProviderStateMixin {
  late AnimationController _themeAnimationController;
  late AnimationController _dropdownAnimationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _dropdownAnimation;

  bool _isDropdownOpen = false;
  late String _selectedLanguage;

  static final List<LanguageModel> _supportedLanguages = [
    LanguageModel(
      name: 'English',
      code: 'en',
      countryCode: 'US',
      locale: Locales.enUS.locale,
    ),
    LanguageModel(
      name: 'Türkçe',
      code: 'tr',
      countryCode: 'TR',
      locale: Locales.trTR.locale,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _themeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _dropdownAnimationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 1.2,
    ).animate(
      CurvedAnimation(
        parent: _themeAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _themeAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _dropdownAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _dropdownAnimationController,
        curve: Curves.easeOutBack,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final currentLocale = context.locale;

    _selectedLanguage = _supportedLanguages
        .firstWhere(
          (lang) =>
              lang.locale.languageCode == currentLocale.languageCode &&
              lang.locale.countryCode == currentLocale.countryCode,
          orElse: () => _supportedLanguages.first,
        )
        .name;
  }

  @override
  void dispose() {
    _themeAnimationController.dispose();
    _dropdownAnimationController.dispose();
    super.dispose();
  }

  void _handleThemeChange(bool isDark) {
    if (isDark) {
      _themeAnimationController.forward();
    } else {
      _themeAnimationController.reverse();
    }
    context.read<ThemeViewModel>().changeTheme();
  }

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });

    if (_isDropdownOpen) {
      _dropdownAnimationController.forward();
    } else {
      _dropdownAnimationController.reverse();
    }
  }

  void _selectLanguage(LanguageModel language) {
    setState(() {
      _selectedLanguage = language.name;
      _isDropdownOpen = false;
    });

    _dropdownAnimationController.reverse();
    widget.mainContext.setLocale(language.locale);
    DioManager().setLanguage(language.code);
  }

  Widget _buildLanguageItem(LanguageModel language, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.primary.withValues(alpha: .1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .1),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CountryFlag.fromCountryCode(
                language.countryCode.toLowerCase(),
                width: 32,
                height: 24,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              language.name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).textTheme.bodyMedium?.color,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
            ),
          ),
          if (isSelected)
            Icon(
              Icons.check,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedLang = _supportedLanguages.firstWhere(
      (lang) => lang.name == _selectedLanguage,
      orElse: () => _supportedLanguages.first,
    );

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: ColorConstants.primaryColor),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: userCredentialViewModel.state.photoUrl!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator.adaptive(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  userCredentialViewModel.state.name ?? 'User Name',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withValues(alpha: .1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: BlocBuilder<ThemeViewModel, dynamic>(
              builder: (context, state) {
                final isDark = context
                    .select((ThemeViewModel cubit) => cubit.state.isDark);

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        AnimatedBuilder(
                          animation: _themeAnimationController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _scaleAnimation.value,
                              child: Transform.rotate(
                                angle: _rotationAnimation.value * 3.14159,
                                child: Icon(
                                  isDark ? Icons.dark_mode : Icons.light_mode,
                                  color: isDark
                                      ? Theme.of(context).colorScheme.primary
                                      : ColorConstants.radialGradientColor,
                                  size: 24,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Dark Mode',
                              style: Theme.of(context).textTheme.titleSmall,
                            ).tr(),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: Text(
                                isDark ? 'drawer enabled' : 'drawer disabled',
                                key: ValueKey(isDark),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                              ).tr(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => _handleThemeChange(!isDark),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 56,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: isDark
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withValues(alpha: 0.3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: AnimatedAlign(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          alignment: isDark
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            width: 28,
                            height: 28,
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 150),
                              child: Icon(
                                isDark ? Icons.nights_stay : Icons.wb_sunny,
                                key: ValueKey(isDark),
                                size: 16,
                                color: isDark
                                    ? Theme.of(context).colorScheme.primary
                                    : ColorConstants.radialGradientColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withValues(alpha: .1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: _toggleDropdown,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.language,
                          color: Theme.of(context).colorScheme.primary,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Test',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                              ).tr(),
                              Text(
                                selectedLang.name,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: .1),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: CountryFlag.fromCountryCode(
                              selectedLang.countryCode.toLowerCase(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        AnimatedRotation(
                          turns: _isDropdownOpen ? 0.5 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _dropdownAnimation,
                  builder: (context, child) {
                    return ClipRect(
                      child: Align(
                        heightFactor: _dropdownAnimation.value,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Theme.of(context).dividerColor,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                constraints:
                                    const BoxConstraints(maxHeight: 300),
                                child: SingleChildScrollView(
                                  physics: const ClampingScrollPhysics(),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Column(
                                    children:
                                        _supportedLanguages.map((language) {
                                      final isSelected =
                                          language.name == _selectedLanguage;
                                      return InkWell(
                                        onTap: () => _selectLanguage(language),
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 150),
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: isSelected
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                    .withValues(alpha: .1)
                                                : Colors.transparent,
                                          ),
                                          child: _buildLanguageItem(
                                            language,
                                            isSelected: isSelected,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class LanguageModel {
  const LanguageModel({
    required this.name,
    required this.code,
    required this.countryCode,
    required this.locale,
  });
  final String name;
  final String code;
  final String countryCode;
  final Locale locale;
}
