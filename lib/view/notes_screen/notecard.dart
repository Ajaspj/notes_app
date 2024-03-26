import 'package:flutter/material.dart';
import 'package:notes_app/view/notes_screen/note_contoller.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen(
      {super.key,
      required this.title,
      required this.desc,
      required this.date,
      required this.colorindex,
      this.onDeletePres,
      this.oneditPres});
  final String title;
  final String desc;
  final String date;
  final int colorindex;
  final void Function()? onDeletePres;
  final void Function()? oneditPres;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: NoteScreenController.colorConstant[colorindex],
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Spacer(),
              InkWell(onTap: oneditPres, child: Icon(Icons.edit)),
              SizedBox(
                width: 10,
              ),
              InkWell(onTap: onDeletePres, child: Icon(Icons.delete))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            desc,
            style: TextStyle(color: Colors.black.withOpacity(.4)),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                date,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 15,
              ),
              Icon(Icons.share)
            ],
          )
        ],
      ),
    );
  }
}
