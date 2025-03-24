import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/note_helper.dart';
import 'package:flutter_application_1/modal/note_modal.dart';
import 'package:flutter_application_1/services/note_services.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController timeController = TextEditingController();

    NoteServices ns = Get.put(NoteServices());
    ns.getNotes();
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: GetBuilder<NoteServices>(builder: (context) {
        return FutureBuilder(
          future: ns.modal,
          builder: (context, snapshot) {
            List<NoteModal> data = snapshot.data ?? [];
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${data[index].title}"),
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Title",
                    ),
                  ),
                  TextField(
                    controller: descController,
                    decoration: InputDecoration(
                      hintText: "Description",
                    ),
                  ),
                  TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                      hintText: "date",
                    ),
                  ),
                  TextField(
                    controller: timeController,
                    decoration: InputDecoration(
                      hintText: "time",
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("Cancel")),
                      GetBuilder<NoteServices>(builder: (context) {
                        return ElevatedButton(
                            onPressed: () {
                              Get.back();
                              NoteModal modal = NoteModal(
                                  date: dateController.text,
                                  description: descController.text,
                                  time: timeController.text,
                                  title: titleController.text);

                              ns.addNotes(modal);
                            },
                            child: Text("add"));
                      })
                    ],
                  )
                ],
              );
            },
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
