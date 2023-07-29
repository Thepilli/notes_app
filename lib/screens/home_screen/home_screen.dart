import 'package:flutter/material.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/models/notes.dart';
import 'package:notes_app/screens/edit_screen/edit_screen.dart';
import 'package:notes_app/screens/home_screen/note_card.dart';
import 'package:notes_app/utils/appstyle.dart';
import 'package:notes_app/utils/height_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> filteredNotes = [];
  bool sorted = false;

  @override
  void initState() {
    super.initState();
    filteredNotes = sampleNotes;
  }

  List<Note> sortNotesByModifiedTime(List<Note> notes) {
    if (sorted) {
      notes.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
    } else {
      notes.sort((b, a) => a.modifiedTime.compareTo(b.modifiedTime));
    }
    sorted = !sorted;
    return notes;
  }

  void onSearchTextChanged(String searchText) {
    setState(() {
      filteredNotes = sampleNotes
          .where((note) =>
              note.content.toLowerCase().contains(searchText.toLowerCase()) ||
              note.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  void addNote() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditScreen(),
      ),
    );
    if (result != null) {
      setState(() {
        sampleNotes.add(Note(id: sampleNotes.length, title: result[0], content: result[1], modifiedTime: DateTime.now()));
        filteredNotes = sampleNotes;
      });
    }
  }

  void deleteNote(int index) {
    setState(() {
      Note note = filteredNotes[index];
      sampleNotes.remove(note);
      filteredNotes.removeAt(index);
    });
  }

  Future<dynamic> deleteConfirmationDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.bgDark,
          icon: const Icon(Icons.info),
          title: const Text('Are you sure you want to delete this note?'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                color: Colors.red,
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('No'),
              ),
              MaterialButton(
                color: Colors.green,
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notes',
                    style: appstyle(30, AppColors.txtLight, FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          filteredNotes = sortNotesByModifiedTime(filteredNotes);
                        });
                      },
                      icon: const Icon(
                        Icons.sort,
                        color: AppColors.txtLight,
                      ))
                ],
              ),
              const HeightBox(size: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SearchBar(
                  onChanged: onSearchTextChanged,

                  leading: const Icon(Icons.search),
                  // hintStyle: apps,
                  hintText: 'Search notes...',
                ),
              ),
              const HeightBox(size: 30),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: filteredNotes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditScreen(note: filteredNotes[index]),
                            ),
                          );
                          if (result != null) {
                            setState(() {
                              int originalIndex = sampleNotes.indexOf(filteredNotes[index]);
                              sampleNotes[originalIndex] = Note(
                                  id: sampleNotes[originalIndex].id,
                                  title: result[0],
                                  content: result[1],
                                  modifiedTime: DateTime.now());
                              filteredNotes[index] = Note(
                                  id: sampleNotes[originalIndex].id,
                                  title: result[0],
                                  content: result[1],
                                  modifiedTime: DateTime.now());
                            });
                          }
                        },
                        child: NoteCard(
                          title: filteredNotes[index].title,
                          content: filteredNotes[index].content,
                          modifiedTime: filteredNotes[index].modifiedTime,
                          onPressedDelete: () async {
                            final result = await deleteConfirmationDialog(context);
                            if (result != null && result) {
                              deleteNote(index);
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        backgroundColor: AppColors.jPrimaryColor,
        child: const Icon(Icons.post_add),
      ),
    );
  }
}
