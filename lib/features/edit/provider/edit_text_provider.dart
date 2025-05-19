import 'package:ecnx_ambient_listening/core/models/log_model/log_model.dart';
import 'package:ecnx_ambient_listening/features/edit/data/models/transcribed_text_model.dart';
import 'package:ecnx_ambient_listening/features/medical_form/data/models/medical_form_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';

/// Provides editing functionality using the Quill rich text editor.
/// This class includes a Quill controller, clipboard interaction, and proper resource cleanup.
class EditTextProvider extends ChangeNotifier {
  late final LogModel log;

  /// title and text model should be updated to accept the medical form model
  /// NOTE: The text should be replaced with the actual data
  void initData(QuillController controller, String text) {
    _quillController = controller;
    _quillController?.document.insert(0, text);
  }

  //  void initData(QuillController controller, TranscribedTextModel? transcribed,
  //       TitleAndTextModel? titleAndTextModel) {
  //     _quillController = controller;
  //     if (transcribed != null) {
  //       _quillController?.document.insert(0, transcribed.text);
  //       _transcribed = transcribed;
  //     } else {
  //       _quillController?.document.insert(0, titleAndTextModel!.text);
  //       _titleAndTextModel = titleAndTextModel;
  //     }
  //   }

  /// if it is used in medical form, the method should be updated to accept the medical form model
  /// and the quill controller should be updated to accept the medical form model
  TitleAndTextModel? _titleAndTextModel;

  TitleAndTextModel get titleAndTextModel => _titleAndTextModel!;

  // ---------------------------------------------------------------------------
  // Transcribed Text
  // ---------------------------------------------------------------------------

  TranscribedTextModel? _transcribed;

  TranscribedTextModel get transcribed => _transcribed!;

  // ---------------------------------------------------------------------------
  // Quill Controllers
  // ---------------------------------------------------------------------------

  /// Creation of a quill controllers for the fetched transcibed text
  /// The controller is used to interact with the Quill editor.

  QuillController? _quillController;

  /// Exposes the [QuillController] to external widgets for interacting with
  /// the rich text editor.
  QuillController get quillController =>
      _quillController ?? QuillController.basic();

  // ---------------------------------------------------------------------------
  // Clipboard Functionality
  // ---------------------------------------------------------------------------

  /// Copies the plain text content of the Quill document to the clipboard.
  ///
  /// This converts the formatted Quill document to plain text before copying it.
  Future<void> onCopyToClipboard() async {
    final text = _quillController?.document.toPlainText();
    await Clipboard.setData(
        ClipboardData(text: text ?? '')); // Copies text to system clipboard.
  }

  ///TODO: The method for translation need be implemented
  /// Translates the plain text content of the Quill document to another language.
  Future<void> onTranslateTheText() async {
    final text = _quillController?.document.toPlainText();
    try {} catch (e) {
      debugPrint('Error translating text: $e');
    }
  }

  ///TODO: The method for playing the text need to be implemented
  /// Plays the plain text content of the Quill document using text-to-speech.
  Future<void> onPlayTheText() async {
    try {} catch (e) {
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
    _quillController?.dispose();
    super.dispose();
  }
}
