import 'package:flutter/material.dart';

class EditCalorie extends StatefulWidget {
  final String foodItem;

  const EditCalorie({Key? key, required this.foodItem }) : super(key: key);

  @override
  State<EditCalorie> createState() => _EditCalorieState();
}

class _EditCalorieState extends State<EditCalorie> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.foodItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Food'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Food Item',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final updatedFoodItem = _textEditingController.text;
                Navigator.of(context).pop(updatedFoodItem);
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}