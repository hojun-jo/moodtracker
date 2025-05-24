abstract class ThemeDatasource {
  Future<void> setTheme(String theme);
  Future<String?> getTheme();
  Future<void> setFonts(String fonts);
  Future<String?> getFonts();
}
