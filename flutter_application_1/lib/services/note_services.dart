import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/note_helper.dart';
import 'package:flutter_application_1/modal/note_modal.dart';
import 'package:get/get.dart';

class NoteServices extends GetxController {
  Future<List<NoteModal>>? modal;
  Future<void> addNotes(NoteModal modal) async {
    int? res = await NoteHelper.nh.addData(modal);
    if (res != null) {
      Get.snackbar("Added", "DOne", backgroundColor: Colors.green);
    }
    update();
  }

  void getNotes() {
    modal = NoteHelper.nh.fetchData();
    update();
  }
}
