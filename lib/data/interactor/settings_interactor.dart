bool themeIsBlack = false;

class SettingsInteractor {
  bool toggleTheme() {
    themeIsBlack = !themeIsBlack;
    return themeIsBlack;
  }
}
