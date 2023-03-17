import 'package:flutter_frontend_recipes/shared/shared_prefs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  group('Shared Preferences', (){
    group('Standard values', () {
      setUp(() {
        SharedPreferences.setMockInitialValues({});
      });
      test('Omnivor as standard food preference, if no preference is chosen', () async{
        await SharedPrefs().init();
        const expectedPref = "Omnivor";
        final actualPref = SharedPrefs().getChosenPref();
        expect(actualPref, expectedPref);
      });

      test('Allergies all false as standard value', () async{
        await SharedPrefs().init();
        const String nutsText = "Nüsse";
        const String milkText = "Milch";
        const String eggsText = "Eier";
        const String fishText = "Fisch";
        const String glutenText = "Gluten";
        const String seafoodText = "Meeresfrüchte";
        const expectedBool = false;

        for(String allergy in [nutsText, milkText, eggsText, fishText, glutenText, seafoodText]){
         expect(SharedPrefs().getAllergy(allergy), expectedBool);
        }
      });

      test('Preferences all false as standard value', () async{
        await SharedPrefs().init();
        const String allText = "Omnivor";
        const String veganText = "Vegan";
        const String vegetarianText = "Vegetarisch";
        const String pescetarianText = "Pescetarisch";
        const expectedBool = false;

        for(String allergy in [allText, veganText, vegetarianText, pescetarianText]){
          expect(SharedPrefs().getAllergy(allergy), expectedBool);
        }
      });
    });

    group('Get and set settings', () {
      test('Get and Set Theme', () async{
        await SharedPrefs().init();


      });

    });

  });
}