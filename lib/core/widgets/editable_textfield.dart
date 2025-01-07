import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/widgets/history_log_button_widget.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Theme(
                      data: ThemeData(
                        colorScheme: const ColorScheme.light(
                          primary: AppColors.accentBlue,
                          onPrimary: AppColors.white,
                        ),
                        iconButtonTheme: IconButtonThemeData(
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            padding: WidgetStateProperty.all(EdgeInsets.zero), 
                            minimumSize: WidgetStateProperty.all(const Size(32, 32)),
                          ),
                        ),
                      ),
                      child: QuillToolbar.simple(
                        controller: quillController,
                        configurations: QuillSimpleToolbarConfigurations(
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
                          toolbarSize: 24,
                          customButtons: [
                            QuillToolbarCustomButtonOptions(
                              icon: const Icon(Icons.edit_outlined),
                              tooltip: 'Highlight Text',
                              iconTheme: QuillIconTheme(
                                iconButtonSelectedData: IconButtonData(
                                  iconSize: 24,
                                  color: AppColors.white,
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(AppColors.accentBlue),
                                  ),
                                ),
                                iconButtonUnselectedData: IconButtonData(
                                  iconSize: 24,
                                  color: AppColors.text,
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(AppColors.white),
                                  ),
                                ),
                              ),
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
                            ),
                          ],
                        ),
                      ),
                    ),
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
                  configurations: QuillEditorConfigurations(

                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildHighlightButton() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       IconButton(
  //         icon: const Icon(Icons.edit_outlined, color: AppColors.text),
  //         style: ButtonStyle(
  //           shape: WidgetStateProperty.all(
  //             RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(4),
  //             ),
  //           ),
  //           minimumSize: WidgetStateProperty.all(const Size(32, 32)),
  //         ),
  //         onPressed: () {
  //           final currentSelection = quillController.selection;
  //           if (!currentSelection.isCollapsed) {
  //             final currentAttributes = quillController.getSelectionStyle().attributes;
  //             if (currentAttributes.containsKey(Attribute.background.key)) {
  //               quillController.formatSelection(Attribute.clone(Attribute.background, null));
  //             } else {
  //               quillController.formatSelection(Attribute.clone(Attribute.background, '#FFFF00'));
  //             }
  //           }
  //         },
  //         tooltip: 'Highlight Text',
  //       ),
  //     ],
  //   );
  // }
}
