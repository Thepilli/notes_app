import 'package:flutter/material.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/models/notes.dart';
import 'package:notes_app/utils/appstyle.dart';
import 'package:notes_app/utils/height_box.dart';

class EditScreen extends StatefulWidget {
  final Note? note;
  const EditScreen({super.key, this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      titleController = TextEditingController(text: widget.note!.title);
      contentController = TextEditingController(text: widget.note!.content);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
        backgroundColor: AppColors.bgDark.shade900,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                        hintText: 'Enter the Note title', hintStyle: appstyle(15, AppColors.txtLight, FontWeight.normal)),
                    style: appstyle(20, AppColors.txtLight, FontWeight.bold),
                  ),
                  const HeightBox(size: 20),
                  TextField(
                    maxLines: null,
                    controller: contentController,
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your Note',
                        hintStyle: appstyle(15, AppColors.txtLight, FontWeight.normal)),
                    style: appstyle(15, AppColors.txtLight, FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: isKeyboardOpen
              ? const Row(
                  children: [Icon(Icons.save), Text('Save Note')],
                )
              : const Icon(Icons.save),
          onPressed: () {
            Navigator.pop(context, [titleController.text.trim(), contentController.text.trim()]);
          },
          backgroundColor: AppColors.jPrimaryColor,
        ));
  }
}
