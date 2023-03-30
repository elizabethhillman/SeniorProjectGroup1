import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CalorieTile extends StatelessWidget {
  final String tileFoodName;
  final int tileCalorie;
  final int tileQuantity;

  //TODO final int tileProtein
  //TODO final int tileCarbs
  final void Function(BuildContext)? editTap; //TODO implement method
  final void Function(BuildContext)? deleteTap;
  const CalorieTile({
    Key? key,
    required this.tileFoodName,
    required this.tileCalorie,
    required this.tileQuantity,
    this.editTap,
    this.deleteTap,
  }) : super(key: key);

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
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
            child:  Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$tileFoodName x $tileQuantity',
                        style: const TextStyle(
                          color: Colors.black,
                          // fontWeight: FontWeight.bold,
                          fontSize: 14,
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
                          //  fontWeight: FontWeight.bold,
                          fontSize: 12.5,
                        ),
                      ),
                      Text(
                        '55g carb',
                        style: TextStyle(
                          color: Colors.red[800],
                          //  fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        '50g protein',
                        style: TextStyle(
                          color: Colors.brown[400],
                          //  fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        '50g fat',
                        style: TextStyle(
                          color: Colors.lime[700],
                          //  fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width:35),
                    ],
                  ),

                ],
              ),

              // SizedBox(width: 30),

        ),
      ),
    );
  }
}
