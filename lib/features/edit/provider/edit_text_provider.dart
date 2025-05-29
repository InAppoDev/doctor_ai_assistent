import 'package:ecnx_ambient_listening/core/utils/ui_utils.dart';
import 'package:ecnx_ambient_listening/features/medical_form/data/models/medical_form_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';

/// Provides editing functionality using the Quill rich text editor.
/// This class includes a Quill controller, clipboard interaction, and proper resource cleanup.
class EditTextProvider extends ChangeNotifier {
  /// title and text model should be updated to accept the medical form model
  /// NOTE: The text should be replaced with the actual data
  void initData(TitleAndTextModel titleAndTextModel) {
    _titleAndTextModel = titleAndTextModel;
    _descriptionQuillController = QuillController.basic();
    _titleQuillController = QuillController.basic();
    _descriptionQuillController?.document.insert(0, titleAndTextModel.text);
    _titleQuillController?.document.insert(0, titleAndTextModel.title);
  }

  /// if it is used in medical form, the method should be updated to accept the medical form model
  /// and the quill controller should be updated to accept the medical form model
  TitleAndTextModel? _titleAndTextModel;

  TitleAndTextModel get titleAndTextModel => _titleAndTextModel!;

  QuillController? _descriptionQuillController;
  QuillController? _titleQuillController;

  /// Exposes the [QuillController] to external widgets for interacting with
  /// the rich text editor.
  QuillController get descriptionQuillController =>
      _descriptionQuillController ?? QuillController.basic();

  QuillController get titleQuillController =>
      _titleQuillController ?? QuillController.basic();

  // ---------------------------------------------------------------------------
  // Clipboard Functionality
  // ---------------------------------------------------------------------------

  /// Copies the plain text content of the Quill document to the clipboard.
  ///
  /// This converts the formatted Quill document to plain text before copying it.
  Future<void> onCopyToClipboard() async {
    final text = _titleQuillController!.document.toPlainText() +
        _descriptionQuillController!.document.toPlainText();
    await Clipboard.setData(ClipboardData(text: text));
    showToast('Text copied');
  }

  // ---------------------------------------------------------------------------
  // Resource Cleanup
  // ---------------------------------------------------------------------------

  /// Disposes of the [QuillController] when the provider is no longer needed.
  /// Ensures that any resources held by the controller are properly released.
  @override
  void dispose() {
    debugPrint('Disposing EditTextProvider');
    _descriptionQuillController?.dispose();
    _titleQuillController?.dispose();
    super.dispose();
  }
}
