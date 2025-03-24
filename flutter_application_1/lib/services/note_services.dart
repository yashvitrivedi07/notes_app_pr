import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/note_helper.dart';
import 'package:flutter_application_1/modal/note_modal.dart';
import 'package:get/get.dart';

class NoteServices extends GetxController {
  Future<List<NoteModal>>? modal;

  Future<void> addNotes(NoteModal modal) async {
    int? res = await NoteHelper.nh.addData(modal);
    if (res != null) {
      Get.snackbar("Added", "Done", backgroundColor: Colors.green);
    }
    getNotes();
  }

  void getNotes() {
    modal = NoteHelper.nh.fetchData();
    update();
  }

  Future<void> updateNotes(NoteModal modal) async {
    int? res = await NoteHelper.nh.updateData(modal);
    if (res != null) {
      getNotes();
      Get.snackbar("Updated", "done", backgroundColor: Colors.amber);
    } else {
      Get.snackbar("failed", "try again...");
    }
    update();
  }
}
