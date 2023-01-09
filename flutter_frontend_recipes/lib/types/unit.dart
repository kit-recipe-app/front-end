class RAUnit {
  // Das ist doch kacke, man kann natürlich nicht alle Einheiten ineinander umrechnen, da manche Volumen- und manche Masse-
  // abhängig sind. Müssen wir nochmal drüber gehen. ABER NICHT JEZTZT ES SIND FERIEN
  final Map<String, Map<String, double>> conversions = {
    "gramm": {"kilogramm": 1000},
  };

  String title;

  RAUnit({required this.title});

  double? changeUnit(String changeToUnit) {
    return conversions[title]![changeToUnit];
  }
}
