import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/core/widgets/avatar_widget.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:doctor_ai_assistent/features/edit/presentation/widgets/edit_text_tile/edit_text_tile_buttons.dart';
import 'package:doctor_ai_assistent/features/edit/provider/edit_text_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

class EditTextTile extends StatefulWidget {
  const EditTextTile({super.key});

  @override
  State<EditTextTile> createState() => _EditTextTileState();
}

class _EditTextTileState extends State<EditTextTile> {
  late EditTextProvider _editProvider;

  @override
  void initState() {
    super.initState();
    _editProvider = context.read<EditTextProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 7,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.bg,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentBlue.withOpacity(0.4),
                  offset: const Offset(4, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Responsive.isDesktop(context)) const AvatarWidget().paddingOnly(right: 12),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (Responsive.isMobile(context))
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            EditTextTileButtons(
                              onCopyClick: () {},
                              onTranslateClick: () {},
                              onPlayClick: () {},
                            ),
                          ]
                        ).paddingOnly(bottom: 16),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (Responsive.isMobile(context))
                            const Expanded(
                              flex: 1,
                              child: AvatarWidget(),
                            ).paddingOnly(right: 12),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Responsive.isDesktop(context) ? 16 : 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.accentBlue,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'Doctor',
                                style: AppTextStyles.regularPx16,
                              ),
                            ),
                          ),
                        ],
                      ).paddingOnly(bottom: 16),
                      Flexible(
                        child: Container(
                          constraints: const BoxConstraints(
                            maxHeight: 400,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  QuillToolbar.simple(
                                    controller: _editProvider.quillController,
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
                                    controller: _editProvider.quillController,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (Responsive.isDesktop(context))
          Flexible(
            flex: 1,
            child: Row(children: [
              const SizedBox(width: 20),
              EditTextTileButtons(
                onCopyClick: () {},
                onTranslateClick: () {},
                onPlayClick: () {},
              ),
            ]),
          )
      ],
    );
  }

  Widget _buildHighlightButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.edit_outlined, color: AppColors.text),
          onPressed: () {
            final currentSelection = _editProvider.quillController.selection;
            if (!currentSelection.isCollapsed) {
              final currentAttributes = _editProvider.quillController.getSelectionStyle().attributes;
              if (currentAttributes.containsKey(Attribute.background.key)) {
                _editProvider.quillController.formatSelection(Attribute.clone(Attribute.background, null));
              } else {
                _editProvider.quillController.formatSelection(Attribute.clone(Attribute.background, '#FFFF00'));
              }
            }
          },
          tooltip: 'Highlight Text',
        ),
      ],
    );
  }
}
