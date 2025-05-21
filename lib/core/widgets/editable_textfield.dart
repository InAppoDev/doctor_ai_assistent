import 'dart:async';

import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/widgets/history_log_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class EditableTextfield extends StatefulWidget {
  final QuillController quillController;
  final Function()? onHistoryLogClick;
  final void Function(String updatedText) onChunkTextChanged;
  final bool showBoldButton;
  final bool showItalicButton;
  final bool showUnderLineButton;
  final bool shoEditButton;
  final String? searchQuery;

  const EditableTextfield({
    super.key,
    required this.quillController,
    this.onHistoryLogClick,
    required this.onChunkTextChanged,
    this.showBoldButton = true,
    this.shoEditButton = true,
    this.showItalicButton = true,
    this.showUnderLineButton = true,
    this.searchQuery,
  });

  @override
  State<EditableTextfield> createState() => _EditableTextfieldState();
}

class _EditableTextfieldState extends State<EditableTextfield> {
  late final QuillController _controller;
  late final StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _controller = widget.quillController;

    _subscription = _controller.document.changes.listen((event) {
      widget.onChunkTextChanged(_controller.document.toPlainText());
    });
    print('widget.searchQuery 1 - ${widget.searchQuery}');
    if (widget.searchQuery != null && widget.searchQuery!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        highlightSearchMatches();
      });
    }
  }

  @override
  void didUpdateWidget(covariant EditableTextfield oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != oldWidget.searchQuery) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        highlightSearchMatches();
      });
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  /// Public method to highlight all matches of a given search query
  void highlightSearchMatches() {
    if (widget.searchQuery == null || widget.searchQuery!.isEmpty) {
      clearAllHighlights();
      return;
    }

    clearAllHighlights();

    final query = widget.searchQuery!.toLowerCase();
    final plainText = _controller.document.toPlainText().toLowerCase();

    int start = 0;
    while (true) {
      final index = plainText.indexOf(query, start);
      if (index == -1) break;

      _controller.formatText(
        index,
        query.length,
        Attribute('background', AttributeScope.inline, '#1ECFA7'),
      );

      start = index + query.length;
    }
  }

  /// Optional method to remove all background highlights
  void clearAllHighlights() {
    final docLength = _controller.document.length;
    _controller.formatText(
      0,
      docLength,
      Attribute('background', AttributeScope.inline, null),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                QuillToolbar.simple(
                  controller: widget.quillController,
                  configurations: QuillSimpleToolbarConfigurations(
                    showBoldButton: widget.showBoldButton,
                    showItalicButton: widget.showItalicButton,
                    showUnderLineButton: widget.showUnderLineButton,
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
                    customButtons: [
                      if (widget.shoEditButton)
                        QuillToolbarCustomButtonOptions(
                          icon: const Icon(Icons.edit_outlined),
                          tooltip: 'Highlight Text',
                          iconTheme: QuillIconTheme(
                            iconButtonSelectedData: IconButtonData(
                              iconSize: 24,
                              color: AppColors.white,
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    AppColors.accentBlue),
                              ),
                            ),
                            iconButtonUnselectedData: IconButtonData(
                              iconSize: 24,
                              color: AppColors.text,
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(AppColors.white),
                              ),
                            ),
                          ),
                          onPressed: () {
                            final currentSelection =
                                widget.quillController.selection;
                            if (!currentSelection.isCollapsed) {
                              final currentAttributes = widget.quillController
                                  .getSelectionStyle()
                                  .attributes;
                              if (currentAttributes
                                  .containsKey(Attribute.background.key)) {
                                widget.quillController.formatSelection(
                                    Attribute.clone(
                                        Attribute.background, null));
                              } else {
                                widget.quillController.formatSelection(
                                    Attribute.clone(
                                        Attribute.background, '#FFFF00'));
                              }
                            }
                          },
                        ),
                    ],
                  ),
                ),
                if (widget.onHistoryLogClick != null &&
                    Responsive.isMobile(context))
                  HistoryLogButtonWidget(onTap: widget.onHistoryLogClick!),
              ],
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: widget.shoEditButton
                    ? BoxDecoration(
                        border: Border.all(color: AppColors.accentBlue),
                        borderRadius: BorderRadius.circular(10),
                      )
                    : null,
                child: QuillEditor.basic(
                  controller: widget.quillController,
                  configurations: const QuillEditorConfigurations(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
