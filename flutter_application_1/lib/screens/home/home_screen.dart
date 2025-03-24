import 'package:flutter/material.dart';
import 'package:flutter_application_1/modal/note_modal.dart';
import 'package:flutter_application_1/services/note_services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();


    TextEditingController utitleController = TextEditingController();
    TextEditingController udescController = TextEditingController();
    TextEditingController udateController = TextEditingController();
    TextEditingController utimeController = TextEditingController();

    DateTime? date;
    TimeOfDay? time;

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

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: StaggeredGrid.count(
                
                  crossAxisCount: 2, // 2 columns
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: List.generate(data.length, (index) {
                    if (index % 4 == 0 || index % 4 == 1) {
                      // First & second item (full width)
                      return StaggeredGridTile.count(
                
                        crossAxisCellCount: 2, // Full width
                        mainAxisCellCount: 1, // Normal height
                        child: GestureDetector(
                          onTap: () {
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
                          child: Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: index % 4 == 0 ? Colors.cyanAccent : Colors.yellow,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${data[index].title}",maxLines: 2,style: TextStyle(
                                        fontSize: 26.sp,
                                        fontWeight: FontWeight.bold,


                                    ),),
                                    Text("${data[index].description}",style: TextStyle(
                                        fontSize: 18.sp
                                    ),)
                                  ],
                                ),
                                IconButton(onPressed: () {
                                  ns.deleteNotes(id: data[index].id!);
                                }, icon: Icon(Icons.delete,color: Colors.red,size: 27,))
                              ],
                            )
                          ),
                        ),
                      );
                    } else {
                      // Other items (square size)
                      return StaggeredGridTile.count(
                        crossAxisCellCount: 1, // Half width
                        mainAxisCellCount: 1, // Square size
                        child: GestureDetector(
                          onTap: () {
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
                          child: Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: index % 2 == 0 ? Colors.purpleAccent.shade100 : Colors.lightGreenAccent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${data[index].title}",style: TextStyle(
                                        fontSize: 26.sp,
                                        fontWeight: FontWeight.bold

                                    ),),
                                    Text("${data[index].description}",style: TextStyle(
                                        fontSize: 18.sp
                                    ),)
                                  ],
                                ),
                                IconButton(onPressed: () {
                                  ns.deleteNotes(id: data[index].id!);
                                }, icon: Icon(Icons.delete,color: Colors.red,size: 25,))
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }),
                ),
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
                ElevatedButton(onPressed: () async {
                  date = await showDatePicker(context: context, firstDate: DateTime(2020), lastDate: DateTime(2050),initialDate: DateTime.now(),);

                }, child: (date!=null)?Text("${date?.day}/${date?.month}/${date?.year}"):Text("DATE")),
                ElevatedButton(onPressed: () async {
                 time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                }, child: (time!=null)?Text("${time?.minute}:${time?.hour}"):Text("TIME")),

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
                          date: "${date?.day}/${date?.month}/${date?.year}",
                          time: "${time?.hour}/${time?.minute}",
                        );
                        ns.addNotes(modal);

                        titleController.clear();
                        descController.clear();
                        date = null;
                        time = null;

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



