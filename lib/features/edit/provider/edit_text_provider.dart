import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';

class EditTextProvider extends ChangeNotifier {
    // quill controller
  final QuillController _quillController = QuillController.basic();

  QuillController get quillController => _quillController;

  Future<void> onCopyToClipboard() async {
    final text = _quillController.document.toPlainText();
    await Clipboard.setData(ClipboardData(text: text));
  }

  @override
  void dispose() {
    _quillController.dispose();
    super.dispose();
  }
}