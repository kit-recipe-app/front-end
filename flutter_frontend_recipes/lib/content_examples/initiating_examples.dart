import 'package:flutter_frontend_recipes/pages/recipes/recipe.dart';
import 'package:flutter_frontend_recipes/pages/recipes/ingredients.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/shopping_list.dart';
import 'package:flutter_frontend_recipes/pages/profile/profile.dart';




// Dies ist eine Klasse, die in erster Linie nur fürs Testen gedacht ist und
// am Ende wieder gelöscht werden sollte
// Das ist eine Klasse, die ein besipiele von Rezepten Einkaufslisten und Profile instanziiert
// (die Klassen basieren auf anderen Testklassen, die vorher entwicket wurden)
// Muss auf jeden Fall am Ende wieder gelöscht werden
class InitiatingExamples {

  List<Recipe> exampleRecipes = [];
  List<ShoppingList> exampleLists = [];
  List<Profile> exampleProfiles = [];


  InitiatingExamples() {
    createProfiles();
  }


   void createProfiles() {
    Profile profileOfHerbert = Profile(name: 'Herbert', vegetarian: true);
    Profile profileOfMargritt = Profile(name: 'Margritt', vegetarian: false);
    Profile profileOfLucas= Profile(name: 'Lucas', vegetarian: false);
    Profile profileOfTim = Profile(name: 'Tim', vegetarian: false);
    Profile profileOfMaria = Profile(name: 'Maria', vegetarian: true);

    exampleProfiles.add(profileOfHerbert);
    exampleProfiles.add(profileOfMargritt);
    exampleProfiles.add(profileOfLucas);
    exampleProfiles.add(profileOfTim);
    exampleProfiles.add(profileOfMaria);
  }



  void createRecipes() {
    List<Ingredients> ingredients1 = [
      Ingredients(name: 'Spaghetti', amount: 500, unit: 'g'),
      Ingredients(name: 'Hackfleisch', amount: 200, unit: 'g'),
      Ingredients(name: 'Käse', amount: 20, unit: 'g'),
      Ingredients(name: 'Tomaten', amount: 4, unit: 'Stück'),
    ];
    Recipe recipe1 = Recipe(title: 'Spaghetti Bolognese', time: 30, difficulty: 'normal',
        calories: 200, vegetarian: false, ingredients: ingredients1,
        description: '''Zuerst macht man die Spaghetti in heißes Wasser und fügt etwas Salz hinzu dann 
        lässt man sie kochen und dann mACHT MANn das kadhskada sjsdkjask iohfshakjh sad shdk l
        d ash alhs dhkalshd skhd ksjahdljhs akjhd akshdasd d ksahd ashd ahsdhasduhsfksbdniul
        hahd  djsabkjd  jdh s js js d hskjhs kjshd kds sdhkj skj hks  sdahdkahlsdk ahldhsadlkjahsdlsla
         sajkshdkjahiuwhsakdjkw hdukhsnckjiuh duwihaksdkjkawjhld idsjnkjnckhiualhdliu ''');



    List<Ingredients> ingredients2 = [
      Ingredients(name: 'Vegetarisches Schnitzel', amount: 1, unit: 'Stück'),
      Ingredients(name: 'Kartoffel', amount: 4, unit: 'Stück'),
      Ingredients(name: 'Salz', amount: 1, unit: 'Prise'),
      Ingredients(name: 'Pfeffer', amount: 1, unit: 'Prise'),
      Ingredients(name: 'Panade', amount: 200, unit: 'g'),
    ];
    Recipe recipe2 = Recipe(title: 'Vegetarisches Schnitzel mit kartoffel', time: 40,
        difficulty: 'normal', calories: 400, vegetarian: true,
        ingredients: ingredients2, description: '''Zuerst schält man die Kartoffel und dann schneidet man sie
        dann wird das Salz und Pfefferzur Panade dazugegeben und umgerührt, dann das Schnitzel in die
        Pfanne und dann  sakdakhdlkashdkjshchiabuic hdkjab  sja kj askhak kad kjhsdk aha  ashd 
         asdjksahdkjhaskd sdah asdl msn ansakjdka as kda skjda sjdha a jhs kjhdkjasdjk adhsjasd
         s dasd sa dsa dasdasdjaskjdjdbsmnbmnbjhsjk  hdkjahd kjsd sdhk sjkd skjd ksdhs kdsds 
          sdskj dksaksj kdhs khsad kjsdj ahdkjashdkjcnc mdj has jdds djwajndjflahd,b jssakdakhdlkashdkjshchiabuic hdkjab  sja kj askhak kad kjhsdk aha  ashd 
         asdjksahdkjhaskd sdah asdl msn ansakjdka as kda skjda sjdha a jhs kjhdkjasdjk adhsjasd
         s dasd sa dsa dasdasdjaskjdjdbsmnbmnbjhsjk  hdkjahd kjsd sdhk sjkd skjd ksdhs kdsds 
          sdskj dksaksj kdhs khsad kjsdj ahdkjashdkjcnc mdj has jdds djwajndjflahd,b js 
          sakdakhdlkashdkjshchiabuic hdkjab  sja kj askhak kad kjhsdk aha  ashd 
         asdjksahdkjhaskd sdah asdl msn ansakjdka as kda skjda sjdha a jhs kjhdkjasdjk adhsjasd
         s dasd sa dsa dasdasdjaskjdjdbsmnbmnbjhsjk  hdkjahd kjsd sdhk sjkd skjd ksdhs kdsds 
          sdskj dksaksj kdhs khsad kjsdj ahdkjashdkjcnc mdj has jdds djwajndjflahd,b js
          sakdakhdlkashdkjshchiabuic hdkjab  sja kj askhak kad kjhsdk aha  ashd 
         asdjksahdkjhaskd sdah asdl msn ansakjdka as kda skjda sjdha a jhs kjhdkjasdjk adhsjasd
         s dasd sa dsa dasdasdjaskjdjdbsmnbmnbjhsjk  hdkjahd kjsd sdhk sjkd skjd ksdhs kdsds 
          sdskj dksaksj kdhs khsad kjsdj ahdkjashdkjcnc mdj has jdds djwajndjflahd,b js''');


    List<Ingredients> ingredients3 = [
      Ingredients(name: 'Gurke', amount: 200, unit: 'g'),
      Ingredients(name: 'Basilikum', amount: 5, unit: 'Blätter'),
      Ingredients(name: '', amount: 3, unit: ''),
      Ingredients(name: '', amount: 3, unit: ''),
      Ingredients(name: '', amount: 3, unit: ''),
    ];
    Recipe recipe3 = Recipe(title: '', time: 1, difficulty: '', calories: 2, vegetarian: false,
        ingredients: ingredients3, description: '');


    List<Ingredients> ingredients4 = [
      Ingredients(name: '', amount: 3, unit: ''),
    ];
    Recipe recipe4 = Recipe(title: '', time: 1, difficulty: '', calories: 2, vegetarian: false,
        ingredients: ingredients4, description: '');


    List<Ingredients> ingredients5 = [
      Ingredients(name: '', amount: 3, unit: ''),
    ];
    Recipe recipe5 = Recipe(title: '', time: 1, difficulty: '', calories: 2, vegetarian: false,
        ingredients: ingredients5, description: '');

    exampleRecipes.add(recipe1);
    exampleRecipes.add(recipe2);
    exampleRecipes.add(recipe3);
    exampleRecipes.add(recipe4);
    exampleRecipes.add(recipe5);

  }




}

