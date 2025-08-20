// Modify the Recipe class so its instances can be constants, and
// create a constant constructor that does the following:

// Has three parameters: ingredients, calories, and
// milligramsOfSodium (in that order).
// Uses this. syntax to automatically assign the parameter values
// to the object properties of the same name.
// Is constant, with the const keyword just before Recipe in the
// constructor declaration.

class Recipe {
 final  List<String> ingredients;
  final int calories;
  final double milligramsOfSodium;

  // TODO: Create a const constructor here.
  const Recipe(this.ingredients,this.calories,this.milligramsOfSodium);

}

void main() {
  final errs = <String>[];

  try {
    const obj = Recipe(['1 egg', 'Pat of butter', 'Pinch salt'], 120, 200);

    if (obj.ingredients.length != 3) {
      errs.add('Called Recipe([\'1 egg\', \'Pat of butter\', \'Pinch salt\'], 120, 200) \n and got an object with ingredient list of length ${obj.ingredients.length} rather than the expected length (3).');
    }

    if (obj.calories != 120) {
      errs.add('Called Recipe([\'1 egg\', \'Pat of butter\', \'Pinch salt\'], 120, 200) \n and got an object with a calorie value of ${obj.calories} rather than the expected value (120).');
    }

    if (obj.milligramsOfSodium != 200) {
      errs.add('Called Recipe([\'1 egg\', \'Pat of butter\', \'Pinch salt\'], 120, 200) \n and got an object with a milligramsOfSodium value of ${obj.milligramsOfSodium} rather than the expected value (200).');
    }

    try {
      obj.ingredients.add('Sugar to taste');
      errs.add('Tried adding an item to the \'ingredients\' list of a const Recipe and didn\'t get an error due to it being unmodifiable.');
    } on UnsupportedError catch (_) {
      // We expect an `UnsupportedError` due to
      // `ingredients` being a const, unmodifiable list.
    }
  } catch (e) {
    print('Tried calling Recipe([\'1 egg\', \'Pat of butter\', \'Pinch salt\'], 120, 200) \n and received a null.');
  }

  if (errs.isEmpty) {
    print('Success!');
  } else {
    errs.forEach(print);
  }
}