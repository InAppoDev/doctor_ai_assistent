import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/features/medical_form/presentation/widgets/history_log_button_widget.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class EditableTextfield extends StatelessWidget {
  final QuillController quillController;
  final Function()? onHistoryLogClick;
  const EditableTextfield({
    super.key,
    required this.quillController,
    this.onHistoryLogClick,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 400,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QuillToolbar.simple(
                      controller: quillController,
                      configurations: const QuillSimpleToolbarConfigurations(
                        showBoldButton: true,
                        showItalicButton: true,
                        showUnderLineButton: true,
                        showStrikeThrough: false,
                        showColorButton: false,
                        showBackgroundColorButton: false,
                        showClearFormat: false,
                        showHeaderStyle: false,
                        showListNumbers: false,
                        showListBullets: false,
                        showCodeBlock: false,
                        showQuote: false,
                        showLink: false,
                        showClipboardCopy: false,
                        showUndo: false,
                        showRedo: false,
                        showAlignmentButtons: false,
                        showFontSize: false,
                        showIndent: false,
                        showCenterAlignment: false,
                        showClipboardCut: false,
                        showClipboardPaste: false,
                        showDirection: false,
                        showDividers: false,
                        showFontFamily: false,
                        showInlineCode: false,
                        showJustifyAlignment: false,
                        showLeftAlignment: false,
                        showLineHeightButton: false,
                        showListCheck: false,
                        showRightAlignment: false,
                        showSearchButton: false,
                        showSmallButton: false,
                        showSubscript: false,
                        showSuperscript: false,
                        toolbarIconAlignment: WrapAlignment.start,
                        toolbarSectionSpacing: 0,
                      ),
                    ),
                    _buildHighlightButton(),
                  ],
                ),
                if (onHistoryLogClick != null && Responsive.isMobile(context))
                  HistoryLogButtonWidget(onTap: onHistoryLogClick!),
              ],
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.accentBlue,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: QuillEditor.basic(
                  controller: quillController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.edit_outlined, color: AppColors.text),
          onPressed: () {
            final currentSelection = quillController.selection;
            if (!currentSelection.isCollapsed) {
              final currentAttributes = quillController.getSelectionStyle().attributes;
              if (currentAttributes.containsKey(Attribute.background.key)) {
                quillController.formatSelection(Attribute.clone(Attribute.background, null));
              } else {
                quillController.formatSelection(Attribute.clone(Attribute.background, '#FFFF00'));
              }
            }
          },
          tooltip: 'Highlight Text',
        ),
      ],
    );
  }
}
