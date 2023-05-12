import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../model/Exercises.dart';

class WorkoutTile extends StatefulWidget {
  final Exercise exercise;
  final int index;
  final void Function(BuildContext)? editTap;
  final void Function(BuildContext)? deleteTap;
  final void Function(Exercise)? updateFavoriteStatus;
  final Color? containerColor;

  const WorkoutTile({
    Key? key,
    required this.exercise,
    required this.index,
    this.editTap,
    this.deleteTap,
    this.updateFavoriteStatus,
    this.containerColor,
  }) : super(key: key);

  @override
  _WorkoutTileState createState() => _WorkoutTileState();
}

class _WorkoutTileState extends State<WorkoutTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: widget.editTap,
                backgroundColor: Colors.greenAccent,
                icon: Icons.edit,
                borderRadius: BorderRadius.circular(12),
              ),
              SlidableAction(
                onPressed: widget.deleteTap,
                backgroundColor: Colors.redAccent,
                icon: Icons.delete,
                borderRadius: BorderRadius.circular(12),
              )
            ],
          ),
          child: GestureDetector(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        CachedNetworkImage(
                          imageUrl: widget.exercise.workoutGif!,
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },

            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: widget.containerColor ?? Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Workout ${widget.index}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        ' ${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.exercise.name}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
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
                  Text(
                    '${widget.exercise.target}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.5,
                    ),
                  ),
                  Text(
                    widget.exercise.equipment!,
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    widget.exercise.muscleGroup!,
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reps/Sets:${widget.exercise.reps} x ${widget.exercise.sets}',
                        style: const TextStyle(
                          fontSize: 13,
                          textBaseline: TextBaseline.alphabetic,
                          height: 0.8,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: widget.exercise.isPressed!
                              ? const Icon(Icons.favorite, color: Colors.red)
                              : const Icon(Icons.favorite_border),
                          onPressed: () {
                            setState(() {
                              widget.exercise.isPressed =
                                  !widget.exercise.isPressed!;
                            });
                            if (widget.updateFavoriteStatus != null) {
                              widget.updateFavoriteStatus!(widget.exercise);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 35),
                ],
              ),
            ),
          ),
        ));
  }
}
