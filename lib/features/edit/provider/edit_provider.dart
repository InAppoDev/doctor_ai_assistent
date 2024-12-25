import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class EditProvider extends ChangeNotifier {
  // quill controller
  final QuillController _quillController = QuillController.basic();

  QuillController get quillController => _quillController;


  




  // dispose function
  void close() {
    _quillController.dispose();
    notifyListeners();
  }
}