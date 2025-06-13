import 'package:db_practice/data/local/db_helper.dart';
import 'package:db_practice/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_alert/status_alert.dart';

class AddNotePage extends StatelessWidget {
  late bool isUpdate;
  late String title;
  late String desc;
  late int s_no;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  //DBHelper? dbRef = DBHelper.getInstance();

  AddNotePage({
    this.isUpdate = false,
    this.s_no = 0,
    this.title = "",
    this.desc = "",
  }) {
    titleController.text = title;
    descriptionController.text = desc;
  }

  @override
  Widget build(BuildContext context) {
    if (isUpdate) {
      titleController.text = title;
      descriptionController.text = desc;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isUpdate ? "UPDATE NOTE" : "ADD NOTE",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(11),
        child: Column(
          children: [
            Text(
              isUpdate ? "UPDATE NOTE" : "ADD NOTE",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "ENTER TITLE HERE",
                label: Text("TITLE"),
                hintStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.amber.shade300,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "DESCRIBE...",
                label: Text("DESCRIPTION"),
                hintStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.amber.shade100,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      var title = titleController.text;
                      var description = descriptionController.text;
                      if (title.isNotEmpty && description.isNotEmpty) {
                        if (isUpdate) {
                          Provider.of<DbProvider>(
                            context,
                            listen: false,
                          ).updateNote(
                            titleController.text,
                            descriptionController.text,
                            s_no,
                          );

                          StatusAlert.show(
                            context,
                            duration: Duration(seconds: 2),

                            title: 'Note Updated',
                            subtitle: "Successfully",
                            configuration: IconConfiguration(
                              icon: Icons.check_rounded,
                              color: Colors.green,
                            ),
                            backgroundColor: Colors.amber,
                          );
                        } else {
                          Provider.of<DbProvider>(
                            context,
                            listen: false,
                          ).addNote(
                            titleController.text,
                            descriptionController.text,
                          );
                          StatusAlert.show(
                            context,
                            duration: Duration(seconds: 2),
                            title: 'Note Added',
                            subtitle: "Successfully",

                            configuration: IconConfiguration(
                              icon: Icons.check_rounded,
                              color: Colors.green,
                            ),
                            backgroundColor: Colors.amber,
                          );
                        }
                        Navigator.pop(context);

                        /*bool check =
                            isUpdate
                                ? await dbRef!.updateNote(
                                  mtitle: title,
                                  mdesc: description,
                                  s_no: s_no,
                                )
                                : await dbRef!.addNote(
                                  mTitle: title,
                                  mDescription: description,
                                );
                        if (check == true) {
                          Navigator.pop(context);
                        }*/
                      }
                      titleController.clear();
                      descriptionController.clear();
                    },
                    child: Text(isUpdate ? "UPDATE NOTE" : "ADD NOTE"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("CANCEL"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
