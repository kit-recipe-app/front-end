import 'package:flutter_frontend_recipes/pages/recipes/recipe.dart';
import 'package:flutter_frontend_recipes/pages/recipes/ingredients.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/shopping_list.dart';
import 'package:flutter_frontend_recipes/pages/profile/profile.dart';
import 'package:flutter_frontend_recipes/content_examples/unit_examples.dart';



// Dies ist eine Klasse, die in erster Linie nur fürs Testen gedacht ist und
// am Ende wieder gelöscht werden sollte
// Das ist eine Klasse, die ein besipiele von Rezepten Einkaufslisten und Profile instanziiert
// (die Klassen basieren auf anderen Testklassen, die vorher entwicket wurden)
// Muss auf jeden Fall am Ende wieder gelöscht werden
class InitiatingExamples {

  List<Recipe> exampleRecipes = [];
  List<ShoppingList> exampleLists = [];
  List<Profile> exampleProfiles = [];
  UnitExamples unitExamples = UnitExamples();

  InitiatingExamples() {
    createProfiles();
    createRecipes();
    createLists();
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
      Ingredients(name: 'Spaghetti', amount: 500, unit: unitExamples.gramm),
      Ingredients(name: 'Hackfleisch', amount: 200, unit: unitExamples.gramm),
      Ingredients(name: 'Käse', amount: 20, unit: unitExamples.gramm),
      Ingredients(name: 'Tomaten', amount: 4, unit: unitExamples.stueck),
    ];
    Recipe recipe1 = Recipe(title: 'Spaghetti Bolognese', time: 30, difficulty: 'normal',
        calories: 200, vegetarian: false, ingredients: ingredients1, tags: ['Fleisch', 'Italienisch'],
        description: '''Zuerst macht man die Spaghetti in heißes Wasser und fügt etwas Salz hinzu dann 
        lässt man sie kochen und dann mACHT MANn das kadhskada sjsdkjask iohfshakjh sad shdk l
        d ash alhs dhkalshd skhd ksjahdljhs akjhd akshdasd d ksahd ashd ahsdhasduhsfksbdniul
        hahd  djsabkjd  jdh s js js d hskjhs kjshd kds sdhkj skj hks  sdahdkahlsdk ahldhsadlkjahsdlsla
         sajkshdkjahiuwhsakdjkw hdukhsnckjiuh duwihaksdkjkawjhld idsjnkjnckhiualhdliu ''');



    List<Ingredients> ingredients2 = [
      Ingredients(name: 'Vegetarisches Schnitzel', amount: 1, unit: unitExamples.stueck),
      Ingredients(name: 'Kartoffel', amount: 4, unit: unitExamples.stueck),
      Ingredients(name: 'Salz', amount: 1, unit: unitExamples.prise),
      Ingredients(name: 'Pfeffer', amount: 1, unit: unitExamples.prise),
      Ingredients(name: 'Panade', amount: 200, unit: unitExamples.gramm),
    ];
    Recipe recipe2 = Recipe(title: 'Vegetarisches Schnitzel mit kartoffel', time: 40,
        difficulty: 'normal', calories: 400, vegetarian: true, tags: ['Vegetarisch'],
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
      Ingredients(name: 'Gurke', amount: 200, unit: unitExamples.gramm),
      Ingredients(name: 'Basilikum', amount: 5, unit: unitExamples.blaetter),
      Ingredients(name: 'Öl', amount: 20, unit: unitExamples.milliLiter),
      Ingredients(name: 'Essig', amount: 3, unit: unitExamples.spritzer),
    ];
    Recipe recipe3 = Recipe(title: 'Gurkensalat', time: 10, difficulty: 'easy', calories: 100,
        vegetarian: true, ingredients: ingredients3, tags: ['Vegetarisch', 'Einfach'],
        description: '''Zuerst die Gurke schälen und dann schneiden und dann in eine Schüssel
        Öl und Essig und Basilikum dazutun und dann umrühren''');


    List<Ingredients> ingredients4 = [
      Ingredients(name: 'Kartoffel', amount: 3, unit: unitExamples.stueck),
      Ingredients(name: 'Salz', amount: 2, unit: unitExamples.prise),
      Ingredients(name: 'Öl', amount: 1, unit: unitExamples.spritzer),
    ];
    Recipe recipe4 = Recipe(title: 'Bratkartoffel', time: 5, difficulty: 'easy', calories: 150,
        vegetarian: true, ingredients: ingredients4, tags: ['Vegetarisch', 'Einfach'],
        description: 'Öl in die Pfanne geben, die Kartoffel in die Pfanne und dann mit Salz umrühren');


    List<Ingredients> ingredients5 = [
      Ingredients(name: 'Schweinefleisch', amount: 500, unit: unitExamples.gramm),
      Ingredients(name: 'Salz', amount: 3, unit: unitExamples.prise),
      Ingredients(name: 'Karotten', amount: 200, unit: unitExamples.gramm),
      Ingredients(name: 'Paprika', amount: 100, unit: unitExamples.gramm),
    ];
    Recipe recipe5 = Recipe(title: 'Irgendwas mit Fleisch', time: 10, difficulty: 'normal',
        calories: 300, vegetarian: false, ingredients: ingredients5, tags: ['Fleisch'],
        description: '''Das Fleisch wird nakjdkajsdk adjsakl j saalskj dajdksdjhsakd saj lkj 
        asdkjhasjdh sad hjhsak dhj asdjkahs kjhjhsd khw liu hakjhd ksd kashd kjadka dkjhas 
         sadh askjdhaskjh dkas kjdha kjdh kasjhd lskhd ashd akjhdal dhas lkhd kashd ad 
         s jdadlsahd jsdhk hsdkaj ldjas döasldh skah kshkhda hs  skdha''');

    exampleRecipes.add(recipe1);
    exampleRecipes.add(recipe2);
    exampleRecipes.add(recipe3);
    exampleRecipes.add(recipe4);
    exampleRecipes.add(recipe5);

  }



  void createLists() {
    if (exampleRecipes.isNotEmpty && exampleProfiles.isNotEmpty){

      ShoppingList shoppingList1 = ShoppingList(title: 'Herberts Liste',
          allMembers: [exampleProfiles[0], exampleProfiles[1]],
          allRecipes: [exampleRecipes[0], exampleRecipes[3]]);


      ShoppingList shoppingList2 = ShoppingList(title: 'Margritts Liste',
          allMembers: [exampleProfiles[1], exampleProfiles[3]],
          allRecipes: [exampleRecipes[3]]);

      ShoppingList shoppingList3 = ShoppingList(title: 'Supertolle Liste',
          allMembers: [exampleProfiles[1], exampleProfiles[3], exampleProfiles[0]],
          allRecipes: [exampleRecipes[3], exampleRecipes[0], exampleRecipes[1], exampleRecipes[2]]);


      exampleLists.add(shoppingList1);
      exampleLists.add(shoppingList2);
      exampleLists.add(shoppingList3);
    }
  }


}

