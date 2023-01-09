


// Dies ist eine Klasse, die in erster Linie nur fürs Testen gedacht ist und
// am Ende wieder gelöscht werden sollte
// Das ist eine Klasse, die ein Beispiel ist, wie eine Profil Klasse aussehen könnte
// Die Profile werden am Ende wahrscheinlich vom Backend bereitgestellt
class Profile {
  String name;
  bool vegetarian;
  String description = '';
  String levelOfCooking;

  Profile({required this.name, required this.vegetarian,
    required this.levelOfCooking}) {

  }

  void addDescription(String text) {
    description = text;
  }



}

