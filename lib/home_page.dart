import 'package:db_practice/add_note_page.dart';
import 'package:db_practice/data/local/db_helper.dart';
import 'package:db_practice/db_provider.dart';
import 'package:db_practice/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  //List<Map<String, dynamic>> allNotes = [];
  // DBHelper? dbRef;
  @override
  void initState() {
    super.initState();
    Provider.of<DbProvider>(context, listen: false).getInitialNotes();
    /*dbRef = DBHelper.getInstance();
    getNotes();*/
  }

  /*void getNotes() async {
    allNotes = await dbRef!.getAllNotes();
    setState(() {});
  } //fetching data
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NOTES',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton(
            borderRadius: BorderRadius.circular(50),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(width: 8),
                      Text(
                        'Settings',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      // all notes viewed here
      body: Consumer<DbProvider>(
        builder: (ctx, provider, __) {
          List<Map<String, dynamic>> allNotes = provider.getNotes();
          return allNotes.isNotEmpty
              ? ListView.builder(
                itemCount: allNotes.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    leading: Text(
                      (allNotes[index][DBHelper.COLUMN_NOTE_SNO]).toString(),
                    ),
                    title: Text(allNotes[index][DBHelper.COLUMN_NOTE_TITLE]),
                    subtitle: Text(allNotes[index][DBHelper.COLUMN_NOTE_DESC]),
                    trailing: SizedBox(
                      width: 50,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => AddNotePage(
                                        isUpdate: true,
                                        title:
                                            allNotes[index][DBHelper
                                                .COLUMN_NOTE_TITLE],
                                        desc:
                                            allNotes[index][DBHelper
                                                .COLUMN_NOTE_DESC],
                                        s_no:
                                            allNotes[index][DBHelper
                                                .COLUMN_NOTE_SNO],
                                      ),
                                ),
                              );
                              /*showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  titleController.text =
                                      allNotes[index][DBHelper
                                          .COLUMN_NOTE_TITLE];
                                  descriptionController.text =
                                      allNotes[index][DBHelper
                                          .COLUMN_NOTE_DESC];
                                  return getBottomSheetWidget(
                                    isUpdate: true,
                                    s_no:
                                        allNotes[index][DBHelper
                                            .COLUMN_NOTE_SNO],
                                  );
                                },
                              );*/
                            },
                            child: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
              : Center(child: Text('NO NOTES YET'));
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNotePage()),
          );
          /*showModalBottomSheet(
            context: context,
            builder: (context) {
              titleController.clear();
              descriptionController.clear();
              return getBottomSheetWidget();
            },
          );*/
        },

        //note to be added over here
        child: Icon(Icons.add),
      ),
    );
  }

  /*Widget getBottomSheetWidget({bool isUpdate = false, int s_no = 0}) {
    return Container(
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
                      bool check =
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
                        getNotes();
                      }
                    }
                    titleController.clear();
                    descriptionController.clear();

                    Navigator.pop(context);
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
    );
  }*/
}
