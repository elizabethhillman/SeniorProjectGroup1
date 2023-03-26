import 'package:flutter/material.dart';

import '../model/Food.dart';
import '../model/user_database.dart';

class Results extends StatefulWidget {
  const Results({Key? key}) : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  List<Food> _foodList = []; //list of the foods that were calc

  List<Food> foodCalories = [];

  @override
  void initState() {
    super.initState();
    _getFood(); // add call to get exercises on initialization
  }

  Future<void> _getFood() async {
    //idk how to add to model
    try {
      Database db = Database();
      var conn = await db.getSettings();
      var id = await conn.query("SELECT * from fitlife.food ORDER BY foodName");
      var result = await conn
          .query('SELECT foodName, calorie, quantity FROM fitlife.food;');

      setState(() {
        for (var row in result) {
          foodCalories.add(Food(row[1], row[2], row[3]));
        }
      });
      await conn.close();
    } catch (e) {
      print("Error Occurred: $e");
    }
  }

  String _searchText = '';
  String? _selectedFood;
  final TextEditingController _quantityController = TextEditingController();
  int _totalCalories = 0;

  void _onSearchTextChanged(String text) {
    setState(() {
      _searchText = text;
      _selectedFood = null;
      _quantityController.clear();
      _totalCalories = 0;
    });
  }

  void _onFoodSelected(String food) {
    setState(() {
      _selectedFood = food;
    });

    FocusScope.of(context).unfocus();
  }

  void _calculateCalories() {
    Food food = foodCalories.firstWhere((f) => f.foodName == _selectedFood);
    int calories = food.calorie;
    int quantity = int.tryParse(_quantityController.text) ?? 0;
    _totalCalories = calories * quantity;
    DateTime dateToday = DateTime.now();
    String date = dateToday.toString().substring(0, 10);

    if (quantity > 0) {
      setState(() {
        _foodList.add(Food(_selectedFood!, _totalCalories, quantity));
        _selectedFood = null;
        _quantityController.clear();
        _totalCalories = 0;
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
                    Icon(
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
                        subtitle: Text('${food.calorie} calories'),
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
              padding: EdgeInsets.only(top: 150.0),
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
              padding: EdgeInsets.only(top: 150.0),
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
              onPressed: () {
                Navigator.pop(context, _foodList);
              },
              child: const Text('Add to Tracker'),
            ),
          const SizedBox(height: 100.0),
        ],
      ),
    );
  }
}
