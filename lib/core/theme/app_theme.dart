import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Iridescent Metallics & Aqua Color Palette
  static const Color primaryAqua = Color(0xFF00FFFF);
  static const Color secondaryAqua = Color(0xFF40E0D0);
  static const Color tertiaryAqua = Color(0xFF7FFFD4);
  
  // Iridescent Metallics
  static const Color metallicSilver = Color(0xFFB8860B);
  static const Color metallicGold = Color(0xFFFFD700);
  static const Color metallicCopper = Color(0xFFB87333);
  static const Color metallicPlatinum = Color(0xFFE5E4E2);
  
  // Gradient Colors
  static const LinearGradient aquaGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryAqua, secondaryAqua, tertiaryAqua],
  );
  
  static const LinearGradient metallicGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [metallicSilver, metallicGold, metallicCopper],
  );
  
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primarySwatch: _createMaterialColor(primaryAqua),
    scaffoldBackgroundColor: const Color(0xFFF8FFFE),
    
    colorScheme: const ColorScheme.light(
      primary: primaryAqua,
      secondary: secondaryAqua,
      tertiary: tertiaryAqua,
      surface: Color(0xFFFFFFFF),
      onPrimary: Color(0xFF000000),
      onSecondary: Color(0xFF000000),
      onSurface: Color(0xFF1A1A1A),
      error: Color(0xFFFF6B6B),
      onError: Color(0xFFFFFFFF),
    ),
    
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: GoogleFonts.orbitron(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1A1A1A),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
    ),
    
    textTheme: _createTextTheme(Brightness.light),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryAqua,
        foregroundColor: Colors.black,
        elevation: 8,
        shadowColor: primaryAqua.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
    
    cardTheme: CardThemeData(
      elevation: 8,
      shadowColor: primaryAqua.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primaryAqua.withOpacity(0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primaryAqua.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primaryAqua, width: 2),
      ),
    ),
  );
  
  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primarySwatch: _createMaterialColor(primaryAqua),
    scaffoldBackgroundColor: const Color(0xFF0A0A0A),
    
    colorScheme: const ColorScheme.dark(
      primary: primaryAqua,
      secondary: secondaryAqua,
      tertiary: tertiaryAqua,
      surface: Color(0xFF1A1A1A),
      onPrimary: Color(0xFF000000),
      onSecondary: Color(0xFF000000),
      onSurface: Color(0xFFFFFFFF),
      error: Color(0xFFFF6B6B),
      onError: Color(0xFF000000),
    ),
    
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: GoogleFonts.orbitron(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: primaryAqua,
      ),
      iconTheme: const IconThemeData(color: primaryAqua),
    ),
    
    textTheme: _createTextTheme(Brightness.dark),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryAqua,
        foregroundColor: Colors.black,
        elevation: 12,
        shadowColor: primaryAqua.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
    
    cardTheme: CardThemeData(
      color: const Color(0xFF1A1A1A),
      elevation: 12,
      shadowColor: primaryAqua.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1A1A1A),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primaryAqua.withOpacity(0.5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primaryAqua.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primaryAqua, width: 2),
      ),
    ),
  );
  
  static TextTheme _createTextTheme(Brightness brightness) {
    final Color textColor = brightness == Brightness.light 
        ? const Color(0xFF1A1A1A) 
        : const Color(0xFFFFFFFF);
    
    return TextTheme(
      displayLarge: GoogleFonts.orbitron(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: primaryAqua,
      ),
      displayMedium: GoogleFonts.orbitron(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: primaryAqua,
      ),
      displaySmall: GoogleFonts.orbitron(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineLarge: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: textColor,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textColor,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: textColor.withOpacity(0.7),
      ),
      labelLarge: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }
  
  static MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;
    
    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    
    for (double strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}

// Custom decorations for advanced UI effects
class AppDecorations {
  static BoxDecoration glassmorphismDecoration({
    double blur = 15,
    double opacity = 0.1,
    Color color = Colors.white,
    BorderRadius? borderRadius,
  }) {
    return BoxDecoration(
      color: color.withOpacity(opacity),
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      border: Border.all(
        color: Colors.white.withOpacity(0.2),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: blur,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }
  
  static BoxDecoration aquaGlowDecoration({
    BorderRadius? borderRadius,
    double glowIntensity = 0.5,
  }) {
    return BoxDecoration(
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      gradient: AppTheme.aquaGradient,
      boxShadow: [
        BoxShadow(
          color: AppTheme.primaryAqua.withOpacity(glowIntensity),
          blurRadius: 20,
          spreadRadius: 2,
        ),
        BoxShadow(
          color: AppTheme.secondaryAqua.withOpacity(glowIntensity * 0.7),
          blurRadius: 40,
          spreadRadius: -5,
        ),
      ],
    );
  }
}