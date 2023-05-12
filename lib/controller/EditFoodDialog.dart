import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/Food.dart';

class EditFoodDialog extends StatefulWidget {
  final Food food;

  const EditFoodDialog({Key? key, required this.food})
      : super(key: key);

  @override
  _EditFoodDialogState createState() => _EditFoodDialogState();
}

class _EditFoodDialogState extends State<EditFoodDialog> {
  late TextEditingController _quantityController;

  num calculateUpdatedValue(num? oldValue, num oldQuantity, num newQuantity) {
    if (oldValue == null) return 0;
    return oldValue * newQuantity / oldQuantity;
  }

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(text: widget.food.quantity.toString());
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Quantity Size'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantity Size',
              ),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final newQuantity = int.tryParse(_quantityController.text) ?? 0;

            final updatedFood = Food(
                widget.food.foodId,
                widget.food.foodName,
                calculateUpdatedValue(widget.food.calorie, widget.food.quantity, newQuantity).round(),
                newQuantity,
                calculateUpdatedValue(widget.food.carbs, widget.food.quantity, newQuantity).round(),
                calculateUpdatedValue(widget.food.protein, widget.food.quantity, newQuantity).round(),
                calculateUpdatedValue(widget.food.fat, widget.food.quantity, newQuantity).round(),
                widget.food.grams,
            );
            Navigator.of(context).pop(updatedFood);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
