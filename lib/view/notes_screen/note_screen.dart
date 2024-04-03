import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/view/notes_screen/note_contoller.dart';
import 'package:notes_app/view/notes_screen/notecard.dart';

class NoteScreen extends StatefulWidget {
  NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  void initState() {
    NoteScreenController.getinitKeys();
    super.initState();
  }

  TextEditingController titleEditingController = TextEditingController();
  TextEditingController desEditingController = TextEditingController();
  TextEditingController dateEditingController = TextEditingController();
  int selectedColorIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "PENPAD",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final currentkey = NoteScreenController.notesListkeys[index];
                  final currentElement =
                      NoteScreenController.myBox.get(currentkey);
                  return ListViewScreen(
                    title: currentElement["title"],
                    desc: currentElement["dis"],
                    date: currentElement["date"],
                    colorindex: currentElement["colorIndex"],
                    onDeletePres: () {
                      NoteScreenController.delete(currentkey);
                      setState(() {});
                    },
                    oneditPres: () {
                      titleEditingController.text = currentElement["title"];
                      desEditingController.text = currentElement["dis"];
                      dateEditingController.text = currentElement["date"];
                      selectedColorIndex = currentElement["colorIndex"];

                      customBottomSheet(isEdit: true, key: index);
                    },
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                itemCount: NoteScreenController.notesListkeys.length)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titleEditingController.clear();
          desEditingController.clear();
          dateEditingController.clear();
          // ignore: unused_local_variable
          int selectedColorIndex = 0;
          customBottomSheet(isEdit: false);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> customBottomSheet({int key = 0, isEdit = false}) {
    return showModalBottomSheet(
      backgroundColor: Colors.grey.withOpacity(.8),
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, dsetState) => Container(
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleEditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    hintText: "Title",
                    fillColor: Colors.grey),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: desEditingController,
                maxLines: 4,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    hintText: "Description",
                    fillColor: Colors.grey),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                readOnly: true,
                controller: dateEditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    hintText: "Date",
                    suffixIcon: InkWell(
                      onTap: () async {
                        final selectedDateTime = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030));
                        if (selectedDateTime != null) {
                          String formateddate =
                              DateFormat("dd MMM yy").format(selectedDateTime);
                          dateEditingController.text = formateddate.toString();
                        }

                        dsetState(
                          () {},
                        );
                      },
                      child: Icon(
                        Icons.date_range_rounded,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                    fillColor: Colors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (index) => InkWell(
                      onTap: () {
                        selectedColorIndex = index;
                        dsetState(() {});
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            border: selectedColorIndex == index
                                ? Border.all(width: 3, color: Colors.black)
                                : null,
                            color: NoteScreenController.colorConstant[index],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      setState(() {});
                      if (isEdit == true) {
                        NoteScreenController.edit(
                            key: key,
                            title: titleEditingController.text,
                            date: dateEditingController.text,
                            des: desEditingController.text,
                            colorIndex: selectedColorIndex);
                      } else {
                        await NoteScreenController.addNote(
                            title: titleEditingController.text,
                            date: dateEditingController.text,
                            des: desEditingController.text,
                            colorIndex: selectedColorIndex);
                      }
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      child: Center(
                        child: Text(
                          isEdit == true ? "edit" : "Add",
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 100,
                      child: Center(
                        child: Text(
                          "Cancel",
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
