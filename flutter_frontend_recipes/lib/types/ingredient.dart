class RAIngredient {
  String name;
  String unit;
  int amount;
  int calories;

  // umrechnungsfaktoren für unterstütze Einheiten im Backend speichern, falls Rezept gespeichert wird übergeben
  // z.B.:  {gramm_kilogramm: 1000, ...}

  RAIngredient({
    required this.name,
    required this.unit,
    required this.amount,
    required this.calories,
  });

  factory RAIngredient.fromJson(Map<String, dynamic> json) {
    return RAIngredient(
      name: json['ingredient']['name'],
      unit: json['amountInformation']['unit']['name'],
      amount: json['amountInformation']['amount'].round(),
      calories: 0,
    );
  }

  @override
  String toString() => '$amount $unit $name';

  multiply(int factor) {
    amount *= factor;
  }
}
