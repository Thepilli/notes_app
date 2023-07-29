import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/utils/appstyle.dart';
import 'package:notes_app/utils/height_box.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.title,
    required this.content,
    required this.modifiedTime,
    required this.onPressedDelete,
  });

  final String title;
  final String content;
  final DateTime modifiedTime;
  final VoidCallback onPressedDelete;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Card(
        color: AppColors.randomColor(),
        child: Slidable(
          endActionPane: ActionPane(motion: const BehindMotion(), children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(12),
              onPressed: (context) {},
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ]),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: appstyle(15, AppColors.txtDark, FontWeight.bold),
                      ),
                      const HeightBox(size: 5),
                      Text(
                        content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: appstyle(12, AppColors.txtDark, FontWeight.normal),
                      ),
                      const HeightBox(size: 10),
                      Text(
                        DateFormat('EEE MMM d, yyyy h:mm a').format(modifiedTime),
                        maxLines: 2,
                        style: appstyle(12, AppColors.txtDark, FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                IconButton(onPressed: onPressedDelete, icon: const Icon(Icons.delete_forever_outlined))
              ],
            ),
          ),
        ));
  }
}
