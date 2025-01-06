import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';

/// Provides editing functionality using the Quill rich text editor.
/// This class includes a Quill controller, clipboard interaction, and proper resource cleanup.
class EditTextProvider extends ChangeNotifier {
  // ---------------------------------------------------------------------------
  // Quill Controller
  // ---------------------------------------------------------------------------

  /// The controller for managing the Quill rich text editor's state.
  /// This is initialized with a basic configuration.
  final QuillController _quillController = QuillController.basic();

  /// Exposes the [QuillController] to external widgets for interacting with
  /// the rich text editor.
  QuillController get quillController => _quillController;

  // ---------------------------------------------------------------------------
  // Clipboard Functionality
  // ---------------------------------------------------------------------------

  /// Copies the plain text content of the Quill document to the clipboard.
  ///
  /// This converts the formatted Quill document to plain text before copying it.
  Future<void> onCopyToClipboard() async {
    final text = _quillController.document.toPlainText();
    await Clipboard.setData(ClipboardData(text: text)); // Copies text to system clipboard.
  }

  // ---------------------------------------------------------------------------
  // Resource Cleanup
  // ---------------------------------------------------------------------------

  /// Disposes of the [QuillController] when the provider is no longer needed.
  /// Ensures that any resources held by the controller are properly released.
  @override
  void dispose() {
    _quillController.dispose();
    super.dispose();
  }
}
