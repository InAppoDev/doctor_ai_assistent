import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/widgets/editable_textfield.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/widgets/edit_text_tile/edit_text_tile_buttons.dart';
import 'package:ecnx_ambient_listening/features/edit/provider/edit_text_provider.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/widgets/history_log_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicalHistoryTile extends StatefulWidget {
  const MedicalHistoryTile({ 
    super.key,
    required this.onHistoryLogClick,
  });

  final Function() onHistoryLogClick;

  @override
  State<MedicalHistoryTile> createState() => _MedicalHistoryTileState();
}

class _MedicalHistoryTileState extends State<MedicalHistoryTile> {
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
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Responsive(
                        desktop: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(_editProvider.titleAndTextModel.title, style: AppTextStyles.mediumPx20),
                          HistoryLogButtonWidget(onTap: () {
                            widget.onHistoryLogClick();
                          })
                        ]).paddingOnly(bottom: 20),
                        mobile: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Expanded(child: Text(_editProvider.titleAndTextModel.title, style: AppTextStyles.mediumPx20, overflow: TextOverflow.ellipsis, maxLines: 2,)),
                          EditTextTileButtons(
                            onCopyClick: () async {
                              await _editProvider.onCopyToClipboard();
                            },
                          ),
                        ]).paddingOnly(bottom: 16),
                      ),
                      EditableTextfield(quillController: _editProvider.quillController, onHistoryLogClick: () {
                        widget.onHistoryLogClick();
                      },),
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
                onCopyClick: () {
                  _editProvider.onCopyToClipboard();
                },
              ),
            ]),
          )
      ],
    );
  }
}
