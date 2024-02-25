import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4285595855),
      surfaceTint: Color(4286652643),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4288234235),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4283453126),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4287927551),
      onSecondaryContainer: Color(4278583376),
      tertiary: Color(4285750272),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294957670),
      onTertiaryContainer: Color(4283712256),
      error: Color(4289083690),
      onError: Color(4294967295),
      errorContainer: Color(4294937978),
      onErrorContainer: Color(4283236864),
      background: Color(4294965247),
      onBackground: Color(4280228132),
      surface: Color(4294965247),
      onSurface: Color(4280228132),
      surfaceVariant: Color(4293648116),
      onSurfaceVariant: Color(4283188053),
      outline: Color(4286411654),
      outlineVariant: Color(4291740375),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281609785),
      inverseOnSurface: Color(4294503932),
      inversePrimary: Color(4292459007),
      primaryFixed: Color(4293843967),
      onPrimaryFixed: Color(4280942676),
      primaryFixedDim: Color(4292459007),
      onPrimaryFixedVariant: Color(4284743865),
      secondaryFixed: Color(4293058559),
      onSecondaryFixed: Color(4278911083),
      secondaryFixedDim: Color(4290953727),
      onSecondaryFixedVariant: Color(4281808045),
      tertiaryFixed: Color(4294959237),
      onTertiaryFixed: Color(4280490752),
      tertiaryFixedDim: Color(4293575485),
      onTertiaryFixedVariant: Color(4283909376),
      surfaceDim: Color(4292990949),
      surfaceBright: Color(4294965247),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294701311),
      surfaceContainer: Color(4294306554),
      surfaceContainerHigh: Color(4293912052),
      surfaceContainerHighest: Color(4293517294),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4284416176),
      surfaceTint: Color(4286652643),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4288234235),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281479081),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4284901086),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4283580672),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4287459584),
      onTertiaryContainer: Color(4294967295),
      error: Color(4286586386),
      onError: Color(4294967295),
      errorContainer: Color(4291055421),
      onErrorContainer: Color(4294967295),
      background: Color(4294965247),
      onBackground: Color(4280228132),
      surface: Color(4294965247),
      onSurface: Color(4280228132),
      surfaceVariant: Color(4293648116),
      onSurfaceVariant: Color(4282924881),
      outline: Color(4284832622),
      outlineVariant: Color(4286674826),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281609785),
      inverseOnSurface: Color(4294503932),
      inversePrimary: Color(4292459007),
      primaryFixed: Color(4288234235),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4286520288),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4284901086),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283256003),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4287459584),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4285552896),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292990949),
      surfaceBright: Color(4294965247),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294701311),
      surfaceContainer: Color(4294306554),
      surfaceContainerHigh: Color(4293912052),
      surfaceContainerHighest: Color(4293517294),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4281532515),
      surfaceTint: Color(4286652643),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4284416176),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4279173246),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281479081),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281016576),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283580672),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283236864),
      onError: Color(4294967295),
      errorContainer: Color(4286586386),
      onErrorContainer: Color(4294967295),
      background: Color(4294965247),
      onBackground: Color(4280228132),
      surface: Color(4294965247),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4293648116),
      onSurfaceVariant: Color(4280820017),
      outline: Color(4282924881),
      outlineVariant: Color(4282924881),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281609785),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4294305791),
      primaryFixed: Color(4284416176),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4282450044),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281479081),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4279765908),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4283580672),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4281871104),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292990949),
      surfaceBright: Color(4294965247),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294701311),
      surfaceContainer: Color(4294306554),
      surfaceContainerHigh: Color(4293912052),
      surfaceContainerHighest: Color(4293517294),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4292459007),
      surfaceTint: Color(4292459007),
      onPrimary: Color(4282777733),
      primaryContainer: Color(4287970806),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4290953727),
      onSecondary: Color(4280095639),
      secondaryContainer: Color(4284901086),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4294967295),
      onTertiary: Color(4282134272),
      tertiaryContainer: Color(4294561866),
      onTertiaryContainer: Color(4283317504),
      error: Color(4294948007),
      onError: Color(4284811522),
      errorContainer: Color(4294407520),
      onErrorContainer: Color(4280614912),
      background: Color(4279636251),
      onBackground: Color(4293517294),
      surface: Color(4279636251),
      onSurface: Color(4293517294),
      surfaceVariant: Color(4283188053),
      onSurfaceVariant: Color(4291740375),
      outline: Color(4288187809),
      outlineVariant: Color(4283188053),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293517294),
      inverseOnSurface: Color(4281609785),
      inversePrimary: Color(4286652643),
      primaryFixed: Color(4293843967),
      onPrimaryFixed: Color(4280942676),
      primaryFixedDim: Color(4292459007),
      onPrimaryFixedVariant: Color(4284743865),
      secondaryFixed: Color(4293058559),
      onSecondaryFixed: Color(4278911083),
      secondaryFixedDim: Color(4290953727),
      onSecondaryFixedVariant: Color(4281808045),
      tertiaryFixed: Color(4294959237),
      onTertiaryFixed: Color(4280490752),
      tertiaryFixedDim: Color(4293575485),
      onTertiaryFixedVariant: Color(4283909376),
      surfaceDim: Color(4279636251),
      surfaceBright: Color(4282201922),
      surfaceContainerLowest: Color(4279307286),
      surfaceContainerLow: Color(4280228132),
      surfaceContainer: Color(4280491304),
      surfaceContainerHigh: Color(4281149491),
      surfaceContainerHighest: Color(4281872958),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4292722431),
      surfaceTint: Color(4292459007),
      onPrimary: Color(4280483911),
      primaryContainer: Color(4289753343),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4291216895),
      onSecondary: Color(4278714459),
      secondaryContainer: Color(4286809085),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294967295),
      onTertiary: Color(4282134272),
      tertiaryContainer: Color(4294561866),
      onTertiaryContainer: Color(4280819200),
      error: Color(4294949550),
      onError: Color(4281729280),
      errorContainer: Color(4294407520),
      onErrorContainer: Color(4278190080),
      background: Color(4279636251),
      onBackground: Color(4293517294),
      surface: Color(4279636251),
      onSurface: Color(4294965756),
      surfaceVariant: Color(4283188053),
      onSurfaceVariant: Color(4292069084),
      outline: Color(4289372083),
      outlineVariant: Color(4287266707),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293517294),
      inverseOnSurface: Color(4281149491),
      inversePrimary: Color(4284874940),
      primaryFixed: Color(4293843967),
      onPrimaryFixed: Color(4280025147),
      primaryFixedDim: Color(4292459007),
      onPrimaryFixedVariant: Color(4283302034),
      secondaryFixed: Color(4293058559),
      onSecondaryFixed: Color(4278517836),
      secondaryFixedDim: Color(4290953727),
      onSecondaryFixedVariant: Color(4280556957),
      tertiaryFixed: Color(4294959237),
      onTertiaryFixed: Color(4279701504),
      tertiaryFixedDim: Color(4293575485),
      onTertiaryFixedVariant: Color(4282594560),
      surfaceDim: Color(4279636251),
      surfaceBright: Color(4282201922),
      surfaceContainerLowest: Color(4279307286),
      surfaceContainerLow: Color(4280228132),
      surfaceContainer: Color(4280491304),
      surfaceContainerHigh: Color(4281149491),
      surfaceContainerHighest: Color(4281872958),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294965756),
      surfaceTint: Color(4292459007),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4292722431),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294834687),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4291216895),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294967295),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4294561866),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965752),
      onError: Color(4278190080),
      errorContainer: Color(4294949550),
      onErrorContainer: Color(4278190080),
      background: Color(4279636251),
      onBackground: Color(4293517294),
      surface: Color(4279636251),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4283188053),
      onSurfaceVariant: Color(4294965756),
      outline: Color(4292069084),
      outlineVariant: Color(4292069084),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293517294),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4282253430),
      primaryFixed: Color(4294042111),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4292722431),
      onPrimaryFixedVariant: Color(4280483911),
      secondaryFixed: Color(4293387519),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4291216895),
      onSecondaryFixedVariant: Color(4278714459),
      tertiaryFixed: Color(4294960540),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4293904193),
      onTertiaryFixedVariant: Color(4280096000),
      surfaceDim: Color(4279636251),
      surfaceBright: Color(4282201922),
      surfaceContainerLowest: Color(4279307286),
      surfaceContainerLow: Color(4280228132),
      surfaceContainer: Color(4280491304),
      surfaceContainerHigh: Color(4281149491),
      surfaceContainerHighest: Color(4281872958),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
