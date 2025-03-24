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
          return FutureBuilder<List<NoteModal>>(
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
                    trailing: IconButton(onPressed: () {
                      ns.deleteNotes(id: data[index].id!);
                    }, icon: Icon(Icons.delete,color: Colors.red,)),
                    title: Text(data[index].title!),
                    subtitle: Text(data[index].description!),
                    onTap: () {
                      // Pre-fill update fields
                      utitleController.text = data[index].title!;
                      udescController.text = data[index].description!;
                      udateController.text = data[index].date!;
                      utimeController.text = data[index].time!;

                      Get.dialog(AlertDialog(
                        title: Text("Update Note"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: utitleController,
                              decoration: InputDecoration(hintText: "Title"),
                            ),
                            TextField(
                              controller: udescController,
                              decoration: InputDecoration(hintText: "Description"),
                            ),
                            TextField(
                              controller: udateController,
                              decoration: InputDecoration(hintText: "Date"),
                            ),
                            TextField(
                              controller: utimeController,
                              decoration: InputDecoration(hintText: "Time"),
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () => Get.back(),
                            child: Text("Back"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                              NoteModal modal = NoteModal(
                                id: data[index].id, // Ensure correct ID is passed
                                title: utitleController.text,
                                description: udescController.text,
                                date: udateController.text,
                                time: utimeController.text,
                              );
                              ns.updateNotes(modal);
                            },
                            child: Text("Update"),
                          ),
                        ],
                      ));
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: "Title"),
                ),
                TextField(
                  controller: descController,
                  decoration: InputDecoration(hintText: "Description"),
                ),
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(hintText: "Date"),
                ),
                TextField(
                  controller: timeController,
                  decoration: InputDecoration(hintText: "Time"),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => Get.back(),
                      child: Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                        NoteModal modal = NoteModal(
                          id: 0, // ID will be auto-generated in the database
                          title: titleController.text,
                          description: descController.text,
                          date: dateController.text,
                          time: timeController.text,
                        );
                        ns.addNotes(modal);
                      },
                      child: Text("Add"),
                    ),
                  ],
                ),
              ],
            ),
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
