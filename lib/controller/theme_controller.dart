import 'package:flutter/material.dart';

import '../models/theme_model.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeModal themeModal = ThemeModal(isDark: false);

  changeTheme() {
    themeModal.isDark = !themeModal.isDark;
    notifyListeners();
  }
}
