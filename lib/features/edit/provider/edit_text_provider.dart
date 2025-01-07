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

  ///TODO: The method for translation need be implemented
  /// Translates the plain text content of the Quill document to another language.
  Future<void> onTranslateTheText() async {
    final text = _quillController.document.toPlainText();
    try{

    } catch (e) {
      debugPrint('Error translating text: $e');
    }
  }

  ///TODO: The method for playing the text need to be implemented
  /// Plays the plain text content of the Quill document using text-to-speech.
  Future<void> onPlayTheText() async {
    try{

    } catch (e) {
      debugPrint('Error playing text: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // Resource Cleanup
  // ---------------------------------------------------------------------------

  /// Disposes of the [QuillController] when the provider is no longer needed.
  /// Ensures that any resources held by the controller are properly released.
  @override
  void dispose() {
    debugPrint('Disposing EditTextProvider');
    _quillController.dispose();
    super.dispose();
  }
}
