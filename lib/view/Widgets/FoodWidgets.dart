import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CalorieTile extends StatelessWidget {
  final String tileFoodName;
  final int tileCalorie;
  final int tileQuantity;
  final int? tileCarbs;
  final int? tileProtein;
  final int? tileFat;
  final Color? containerColor;
  final void Function(BuildContext)? editTap;
  final void Function(BuildContext)? deleteTap;

  const CalorieTile(
      {Key? key,
      required this.tileFoodName,
      required this.tileCalorie,
      required this.tileQuantity,
      this.tileCarbs,
      this.tileProtein,
      this.tileFat,
      this.editTap,
      this.deleteTap,
      this.containerColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: editTap,
              backgroundColor: Colors.greenAccent,
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(12),
            ),
            SlidableAction(
              onPressed: deleteTap,
              backgroundColor: Colors.redAccent,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.only(
            top: 12.0,
            bottom: 12.0,
            left: 15.0,
            right: 15.0,
          ),
          decoration: BoxDecoration(
            color: containerColor ?? Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '$tileFoodName ',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        const TextSpan(
                          text: '×',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: ' $tileQuantity',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1,
                    child: Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 20,
                      color: Colors.grey[700],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$tileCalorie calories',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.5,
                    ),
                  ),
                  Text(
                    '$tileCarbs g carb',
                    style: TextStyle(
                      color: Colors.red[800],
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    '$tileProtein g protein',
                    style: TextStyle(
                      color: Colors.brown[400],
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    '$tileFat g fat',
                    style: TextStyle(
                      color: Colors.lime[700],
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(width: 35),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
