import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CalorieTile extends StatelessWidget {
  final String tileFoodName;
  final int tileCalorie;
  final int tileQuantity;
  //TODO final int tileProtein
  //TODO final int tileCarbs
  final void Function(BuildContext)? editTap; //TODO implement method
  final void Function(BuildContext)? deleteTap;//TODO  implement method

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
      padding: const EdgeInsets.all(16),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
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
          padding: EdgeInsets.only(
            top: 15.0,
            bottom: 1.0,
            left: 15.0,
            right: 15.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$tileFoodName x $tileQuantity',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    '$tileCalorie calories',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Chip(
                        backgroundColor: Colors.brown[100],
                        label: Text("50g protein",
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Chip(
                        backgroundColor: Colors.orange[100],
                        label: Text("50g carb",
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Transform.translate(
                offset: Offset(0,-7.0),
                child:  Text(
                  'Slide to edit',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0, -7.0),
                child: Icon(Icons.arrow_forward_ios_sharp),
              ),
              // SizedBox(width: 30),
            ],
          ),
        ),
      ),
    );
  }
}