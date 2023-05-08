class Food{
  int foodId; //ID of the food in the database
  String foodName ;
  int calorie;
  int quantity;
  int? carbs;
  int? protein;
  int? fat;
  double? grams;
  DateTime date;




  Food(this.foodId,this.foodName,this.calorie,this.quantity,this.carbs,this.protein,this.fat,this.grams,
      {DateTime? date})
      : date = date ?? DateTime.now();
}