import 'package:flutter/material.dart';
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

    TextEditingController utitleController = TextEditingController();
    TextEditingController udescController = TextEditingController();
    TextEditingController udateController = TextEditingController();
    TextEditingController utimeController = TextEditingController();

    // Initialize NoteServices
    NoteServices ns = Get.put(NoteServices());
    ns.getNotes();

    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
      ),
      body: GetBuilder<NoteServices>(
        builder: (controller) {
          return FutureBuilder(
            future: controller.modal,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              List<NoteModal> data = snapshot.data ?? [];

              if (data.isEmpty) {
                return Center(child: Text("No notes available"));
              }

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Get.dialog(AlertDialog(
                        content: Column(
                          children: [
                            TextField(
                              controller: utitleController,
                              decoration: InputDecoration(
                                hintText: "Title",
                              ),
                            ),
                            TextField(
                              controller: udescController,
                              decoration: InputDecoration(
                                hintText: "Description",
                              ),
                            ),
                            TextField(
                              controller: udateController,
                              decoration: InputDecoration(
                                hintText: "Date",
                              ),
                            ),
                            TextField(
                              controller: utimeController,
                              decoration: InputDecoration(
                                hintText: "Time",
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text("Back")),
                          ElevatedButton(
                              onPressed: () {
                                Get.back();
                                NoteModal modal = NoteModal(
                                  date: udateController.text,
                                  description: udescController.text,
                                  time: utimeController.text,
                                  title: utitleController.text,
                                );
                                ns.updateNotes(modal);
                              },
                              child: Text("Update")),
                        ],
                      ));
                    },
                    title: Text("${data[index].title}"),
                  );
                },
              );
            },
          );
        },
      ),
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
                      hintText: "Date",
                    ),
                  ),
                  TextField(
                    controller: timeController,
                    decoration: InputDecoration(
                      hintText: "Time",
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                          NoteModal modal = NoteModal(
                            id: 0,
                            date: dateController.text,
                            description: descController.text,
                            time: timeController.text,
                            title: titleController.text,
                          );
                          ns.addNotes(modal);
                        },
                        child: Text("Add"),
                      ),
                    ],
                  ),
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
