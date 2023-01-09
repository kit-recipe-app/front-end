class RAIngredient {
  String name;
  String unit;
  int amount;
  int calories;

  // umrechnungsfaktoren für unterstütze Einheiten im Backend speichern, falls Rezept gespeichert wird übergeben
  // z.B.:  {gramm_kilogramm: 1000, ...}

  RAIngredient(
      {required this.name,
      required this.unit,
      required this.amount,
      required this.calories});
}
