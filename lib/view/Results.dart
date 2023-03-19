import 'package:flutter/material.dart';

class Results extends StatefulWidget {
  const Results({Key? key}) : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
}

class Food{ //this go in model view or controler? or keep here
  String foodName ;
  int calorie;
  // int value1;//nutrition i.e. protein value
  // int value2;


  Food(this.foodName,this.calorie);
}

class _ResultsState extends State<Results> {
  List<Food> _foodList =
  []; //list of the foods that were calc


  Map<String, int> foodCalories = {
    //List of foods (fake backend)
    'Apple': 52,
    'Banana': 89,
    'Orange': 47,
    'Pear': 57,
    'Pineapple': 82,
    'Mango': 135,
    'Grapes': 62,
    'Steak': 90,
    'Avocado': (160),
    'Grilled Chicken Breast': (165),
    'White Rice': (205),
    'Salmon': (206),
    'Almonds': (164),
    'Broccoli': (55),
    'Peanut Butter': (190),
    'Oatmeal': (150),
    'Greek Yogurt': (120),
  };

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
    //calculates calories during search only not after
    int calories = foodCalories[_selectedFood!] ?? 0;
    int quantity = int.tryParse(_quantityController.text) ?? 0;
    _totalCalories = calories * quantity;
    DateTime dateToday = DateTime.now();
    String date = dateToday.toString().substring(0, 10);

    if (quantity > 0) {
      setState(() {
        _foodList.add(
            Food('${_selectedFood!}', _totalCalories));
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
        title: const Text('Log Food'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: TextField(
              //autofocus: true, //page opens  up with keyboard open
              onChanged: _onSearchTextChanged,
              decoration: const InputDecoration(
                hintText: 'Search for food to log',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          if (_selectedFood != null)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "${_selectedFood!} serving size:",
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Enter Quantity',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (text) {
                      setState(() {
                        _calculateCalories();
                      });
                    },
                  ),
                ),
                if (_totalCalories > 0)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: _calculateCalories,
                          child: const Text('Add to list'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Total Calories: $_totalCalories',
                          style: const TextStyle(fontSize: 24.0),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          if (_searchText.isNotEmpty && _selectedFood == null)
            Expanded(
              child: ListView.builder(
                itemCount: foodCalories.length,
                itemBuilder: (context, index) {
                  String food = foodCalories.keys.toList()[index].toLowerCase();
                  String query = _searchText.toLowerCase();
                  if (food.contains(query)) {
                    return GestureDetector(
                      onTap: () =>
                          _onFoodSelected(foodCalories.keys.toList()[index]),
                      child: ListTile(
                        title: Text(foodCalories.keys.toList()[index]),
                        subtitle: Text(
                            '${foodCalories.values.toList()[index]} calories'),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          if (_searchText.isEmpty && _selectedFood == null && _foodList.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 150.0),
              child: Text(
                "Search for a meal to log!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          if (_foodList.isNotEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 150.0),
              child: Text(
                "Food(s) to be logged:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _foodList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_foodList[index].foodName),
                  subtitle: Text('Calories: ${_foodList[index].calorie}'),
                );
              },
            ),
          ),
          const SizedBox(height: 100.0),
          if (_foodList.isNotEmpty)
            TextButton(
              onPressed: () {
                Navigator.pop(context, _foodList);
              },
              child: const Text('Add to Tracker'),
            ),
        ],
      ),
    );
  }
}
