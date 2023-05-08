import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/Food.dart';
import '../model/User.dart';
import '../model/user_database.dart';
import 'calorie.dart';

class Results extends StatefulWidget {
  const Results({Key? key}) : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  final List<Food> _foodList = []; //list of the foods that were selected
  List<Food> foodCalories = []; //food from the database
  //TODO add custom food function

  @override
  void initState() {
    super.initState();
  }

  //WARNING: Food search limited to 10 api calls/min
  Future<void> _getFood(String userInput) async {
    // Clear existing data
    setState(() {
      foodCalories.clear();
    });

    // Make API request
    try {
      // Construct API URL
      const appId = '8c437815'; // Replace with your own API ID
      const appKey = '6acd4948d9f7cfa3cefeaed56f3f3b10'; // Replace with your own API Key
      final ingr = userInput;
      final apiUrl = 'https://api.edamam.com/api/food-database/v2/parser?app_id=$appId&app_key=$appKey&ingr=$ingr';

      // Make HTTP request
      final response = await http.get(Uri.parse(apiUrl));

      // Check for successful response
      if (response.statusCode == 200) {
        // Print API response for debugging
     //   print('API response: ${response.body}');
        // Parse response and update state
        final data = jsonDecode(response.body);
        setState(() {
          for (var food in data['hints']) {
            var foodName = food['food']['label'];
            var calorie = food['food']['nutrients']['ENERC_KCAL']?.toInt() ?? 0;
            var carbs = food['food']['nutrients']['CHOCDF']?.toInt() ?? 0 ;
            var protein = food['food']['nutrients']['PROCNT']?.toInt() ?? 0 ;
            var fat = food['food']['nutrients']['FAT']?.toInt() ?? 0 ;
            var measures = food['measures'];
            var servingMeasure = measures.firstWhere((measure) => measure['label'] == 'Serving', orElse: () => null);
            var grams = servingMeasure != null ? servingMeasure['weight'].toDouble() : 0.0;

            foodCalories.add(Food(0, foodName, calorie, 0, carbs,protein,fat,grams));
          }
        });
      } else {
        // Print error response for debugging
        print('API error: ${response.statusCode}');
      }
    } catch (e) {
      // Print exception for debugging
      print('Error occurred: $e');
    }
  }

  Future<void> insertUserFoodLog(int userId, List<Food> foodList) async {
    //idk how to add to model
    try {
      Database db = Database();
      var conn = await db.getSettings();
      var id = await conn.query("SELECT id from fitlife.userfoodlog;");
      // loop through the list of foods and insert each one
      for (var food in foodList) {
        await conn.query(
            'INSERT INTO fitlife.userfoodlog (user_id, food_id, foodName, calorie, quantity, carbs, protein, fat) VALUES (?,?,?,?,?,?,?,?);',
            [userId, food.foodId, food.foodName, food.calorie, food.quantity,food.carbs,food.protein,food.fat]);
      }
      await conn.close();
    } catch (e) {
      print("Error Occurred: $e");
    }
  }

  String _searchText = '';
  String? _selectedFood;
  final TextEditingController _quantityController = TextEditingController();
  int _totalCalories = 0;
  int _totalProtein = 0;
  int _totalCarbs = 0;
  int _totalFat = 0;

  void _onSearchTextChanged(String text) async {
    setState(() {
      _searchText = text;
      _selectedFood = null;
      _quantityController.clear();
      _totalCalories = 0;
    });
    await _getFood(_searchText);
  }

  void _onFoodSelected(String food) {
    setState(() {
      _selectedFood = food;
    });

    FocusScope.of(context).unfocus();
  }

  void _calculateCalories() {
    Food food = foodCalories.firstWhere((f) => f.foodName == _selectedFood);
    int id = food.foodId;
    int calories = food.calorie;
    int quantity = int.tryParse(_quantityController.text) ?? 0;
    int? carbs = food.carbs;
    int? protein = food.protein;
    int? fat = food.fat;
    double? grams = food.grams;
    _totalCalories = calories * quantity;
    _totalProtein = (protein! * quantity);
    _totalCarbs = (carbs! * quantity);
    _totalFat = (fat! * quantity);

    DateTime dateToday = DateTime.now();
    String date = dateToday.toString().substring(0, 10);

    if (quantity > 0) {
      setState(() {
        _foodList.add(Food(id, _selectedFood!, _totalCalories, quantity,_totalCarbs,_totalProtein,_totalFat,grams));
        _selectedFood = null;
        _quantityController.clear();
        _totalCalories = 0;
        _totalCarbs=0;
        _totalProtein=0;
        _totalFat=0;
        _searchText = ''; // clear search text
        FocusScope.of(context).unfocus(); // hide keyboard
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Log Food',
          style: TextStyle(color: Colors.grey[800]),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        //autofocus: true, //page opens up with keyboard open
                        onChanged: _onSearchTextChanged,
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.search,
                      color: Colors.grey,
                    )
                  ],
                )),
          ),
          if (_selectedFood != null)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "${_selectedFood!} serving size:",
                    style: TextStyle(fontSize: 20.0, color: Colors.grey[700]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _quantityController,
                              keyboardType: TextInputType.number,
                              autofocus: true,
                              //page opens up with keyboard open
                              onChanged: (text) {
                                setState(() {
                                  _calculateCalories();
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: 'Input Serving Size',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.fastfood_outlined,
                            color: Colors.grey,
                          )
                        ],
                      )),
                ),
              ],
            ),
          if (_searchText.isNotEmpty && _selectedFood == null)
            Expanded(
              child: ListView.builder(
                itemCount: foodCalories.length,
                itemBuilder: (context, index) {
                  Food food = foodCalories[index];
                  String foodName = food.foodName.toLowerCase();
                  String query = _searchText.toLowerCase();
                  if (foodName.contains(query)) {
                    return GestureDetector(
                      onTap: () => _onFoodSelected(food.foodName),
                      child: ListTile(
                        title: Text(food.foodName),
                        subtitle: Text( ' ${food.grams?.toStringAsFixed(2)} g'),
                        trailing:Text('${food.calorie} calories') ,
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          if (_searchText.isEmpty && _selectedFood == null && _foodList.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Text(
                "Search for a meal to log!",
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.grey[700]),
              ),
            ),
          if (_foodList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Text(
                "Food to be logged:",
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.grey[800]),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _foodList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      '${_foodList[index].foodName} x ${_foodList[index].quantity}'),
                  subtitle: Text('Calories: ${_foodList[index].calorie}'),
                );
              },
            ),
          ),
          if (_foodList.isNotEmpty)
            TextButton(
              onPressed: () async {
                print(currentUser.id);
                await insertUserFoodLog(currentUser.id, _foodList);
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Calorie()),
                );
                setState(() {});
              },
              child: const Text('Add to Tracker'),
            ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
