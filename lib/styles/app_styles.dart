import 'package:flutter/material.dart';

class AppStyles {
  // Colores
  static const Color primaryColor = Colors.blue;
  static const Color errorColor = Colors.red;
  static const Color backgroundAppColor = Colors.white;

  // Estilos de texto
  static TextStyle titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static TextStyle resultTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static TextStyle resultTextStyle = TextStyle(
    fontSize: 16,
  );

  // Tema del SnackBar
  static SnackBarThemeData snackBarTheme = SnackBarThemeData(
    backgroundColor: Colors.white,
    contentTextStyle: TextStyle(
      color: errorColor,
      fontSize: 16,
      fontWeight: FontWeight.w300,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(width: 1),
    ),
    elevation: 10,
  );
}
