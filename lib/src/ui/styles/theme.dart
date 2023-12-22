import 'package:flutter/material.dart';

enum ThemeMode { light, dark }

class AppTheme {
  AppTheme._();
  static ThemeData get light => _theme(Brightness.light);
  static ThemeData get dark => _theme(Brightness.dark);

  static ThemeData _theme(Brightness brightness) => ThemeData(
        brightness: brightness,
        colorScheme: brightness == Brightness.light
            ? const ColorScheme.light().copyWith(
                primary: Colors.lightBlue,
                primaryContainer: const Color.fromARGB(255, 112, 173, 234),
                secondary: const Color.fromARGB(255, 102, 190, 107),
                secondaryContainer: const Color.fromARGB(255, 79, 184, 85),
                tertiary: Colors.orange,
                error: Colors.redAccent,
                outline: const Color.fromARGB(255, 68, 116, 138),
                surfaceVariant: const Color.fromARGB(255, 182, 222, 240),
                inverseSurface: Colors.white,
              )
            : const ColorScheme.dark().copyWith(
                primary: const Color.fromARGB(255, 12, 123, 213),
                primaryContainer: const Color.fromARGB(255, 10, 67, 134),
                secondary: const Color.fromARGB(255, 0, 108, 5),
                secondaryContainer: const Color.fromARGB(255, 1, 74, 4),
                tertiary: const Color.fromARGB(255, 215, 131, 4),
                error: const Color.fromARGB(255, 162, 52, 45),
                outline: const Color.fromARGB(255, 47, 66, 74),
                surfaceVariant: const Color.fromARGB(255, 60, 83, 94),
                inverseSurface: const Color.fromARGB(255, 26, 26, 26),
              ),
        scaffoldBackgroundColor: brightness == Brightness.light
            ? Colors.white
            : const Color.fromARGB(255, 18, 18, 18),
        hintColor: brightness == Brightness.light
            ? const Color.fromARGB(255, 103, 103, 103)
            : const Color.fromARGB(255, 149, 144, 144),
        iconTheme: const IconThemeData().copyWith(
          color: brightness == Brightness.light
              ? const Color.fromARGB(255, 131, 130, 130)
              : const Color.fromARGB(255, 208, 208, 208),
        ),
        textTheme: const TextTheme().copyWith(
          labelMedium: TextStyle(
            fontSize: 16,
            color: brightness == Brightness.light
                ? const Color.fromARGB(255, 103, 103, 103)
                : const Color.fromARGB(255, 216, 220, 219),
          ),

          labelSmall: TextStyle(
            fontSize: 14,
            fontWeight: brightness == Brightness.light
                ? FontWeight.w300
                : FontWeight.w200,
            color: brightness == Brightness.light
                ? const Color.fromARGB(255, 102, 102, 102)
                : const Color.fromARGB(255, 214, 211, 211),
            letterSpacing: 2,
          ),
          labelLarge: TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w400,
            color: brightness == Brightness.light ? Colors.black : Colors.white,
          ),
          bodySmall: TextStyle(
            color: brightness == Brightness.light
                ? const Color.fromARGB(255, 148, 143, 143)
                : const Color.fromARGB(255, 189, 189, 189),
            fontWeight: FontWeight.w400,
            fontSize: 13,
            wordSpacing: 0,
            letterSpacing: 0,
          ),
          bodyMedium: TextStyle(
            color: brightness == Brightness.light
                ? const Color.fromARGB(255, 42, 41, 41)
                : const Color.fromARGB(255, 216, 216, 216),
            fontWeight: FontWeight.w400,
            fontSize: 14.5,
          ),

          //Main card label
          titleSmall: TextStyle(
            color: brightness == Brightness.light
                ? const Color.fromARGB(255, 0, 0, 0)
                : const Color.fromARGB(255, 228, 230, 230),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),

          //CounterBadge
          headlineSmall: TextStyle(
            fontSize: 10,
            color: brightness == Brightness.light
                ? const Color.fromARGB(255, 255, 255, 255)
                : const Color.fromARGB(255, 217, 214, 214),
            fontWeight: FontWeight.w500,
          ),
          headlineMedium: TextStyle(
            color: brightness == Brightness.light ? Colors.black : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: brightness == Brightness.light
              ? Colors.white
              : const Color.fromARGB(255, 21, 21, 21),
          surfaceTintColor: brightness == Brightness.light
              ? Colors.white
              : const Color.fromARGB(255, 21, 21, 21),
          elevation: brightness == Brightness.light ? 0.5 : 0.5,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: brightness == Brightness.light ? Colors.black : Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
          iconTheme: IconThemeData(
            color: brightness == Brightness.light
                ? const Color.fromARGB(255, 103, 101, 101)
                : Colors.white,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: brightness == Brightness.light
              ? Colors.white
              : const Color.fromARGB(255, 21, 21, 21),
          elevation: 10,
          selectedIconTheme: IconThemeData(
            color: brightness == Brightness.light
                ? const Color.fromARGB(255, 34, 137, 221)
                : const Color.fromARGB(255, 19, 140, 239),
            size: 34,
          ),
          unselectedIconTheme: IconThemeData(
            color: brightness == Brightness.light
                ? const Color.fromARGB(255, 130, 129, 129)
                : const Color.fromARGB(255, 191, 188, 188),
            size: 34,
          ),
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        cardTheme: CardTheme(
          color: brightness == Brightness.light
              ? Colors.white
              : const Color.fromARGB(255, 32, 31, 31),
          surfaceTintColor: brightness == Brightness.light
              ? Colors.white
              : const Color.fromARGB(255, 26, 26, 26),
          elevation: 6,
        ),
        tabBarTheme: TabBarTheme(
          labelPadding: const EdgeInsets.symmetric(horizontal: 0),
          labelColor: brightness == Brightness.light
              ? const Color.fromARGB(255, 34, 137, 221)
              : const Color.fromARGB(255, 49, 134, 203),
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          unselectedLabelColor:
              brightness == Brightness.light ? Colors.black : Colors.white,
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        dividerColor: brightness == Brightness.light
            ? const Color.fromARGB(255, 228, 225, 225)
            : const Color.fromARGB(255, 75, 75, 75),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            color: brightness == Brightness.light
                ? const Color.fromARGB(255, 103, 103, 103)
                : const Color.fromARGB(255, 178, 172, 172),
            fontSize: 15.5,
            fontWeight: FontWeight.w300,
          ),
          prefixIconColor: brightness == Brightness.light
              ? const Color.fromARGB(255, 103, 101, 101)
              : Colors.white,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
              brightness == Brightness.light
                  ? const Color.fromARGB(255, 2, 141, 205)
                  : const Color.fromARGB(255, 12, 123, 213),
            ),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              brightness == Brightness.light
                  ? Colors.lightBlue
                  : const Color.fromARGB(255, 5, 77, 135),
            ),
          ),
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: brightness == Brightness.light
              ? Colors.white
              : const Color.fromARGB(255, 43, 42, 42),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: brightness == Brightness.light
              ? const Color.fromARGB(255, 65, 63, 63)
              : const Color.fromARGB(255, 43, 42, 42),
          contentTextStyle: TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w400,
            color: brightness == Brightness.light
                ? const Color.fromARGB(255, 235, 232, 232)
                : Colors.white,
          ),
        ),
        switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.selected)) {
                return brightness == Brightness.light
                    ? const Color.fromARGB(255, 3, 143, 207)
                    : const Color.fromARGB(255, 8, 98, 172);
              } else {
                return brightness == Brightness.light
                    ? const Color.fromARGB(255, 152, 153, 154)
                    : const Color.fromARGB(255, 103, 104, 105);
              }
            },
          ),
          thumbColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return brightness == Brightness.light
                  ? const Color.fromARGB(255, 49, 178, 237)
                  : const Color.fromARGB(255, 13, 124, 214);
            } else {
              return brightness == Brightness.light
                  ? const Color.fromARGB(255, 176, 177, 179)
                  : const Color.fromARGB(255, 150, 152, 154);
            }
          }),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: brightness == Brightness.light
              ? const Color.fromARGB(255, 2, 141, 205)
              : const Color.fromARGB(255, 14, 88, 172),
          foregroundColor: Colors.white,
        ),
      );
}
