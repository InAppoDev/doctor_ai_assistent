import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/constants/consts.dart';
import 'package:ecnx_ambient_listening/core/models/log_model/log_model.dart';
import 'package:ecnx_ambient_listening/core/widgets/avatar_widget.dart';
import 'package:ecnx_ambient_listening/core/widgets/editable_textfield.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/widgets/edit_text_tile/edit_text_tile_buttons.dart';
import 'package:ecnx_ambient_listening/features/edit/provider/edit_text_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTextTile extends StatelessWidget {
  const EditTextTile({
    super.key,
    required this.log,
  });

  final LogModel log;

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
                  color: AppColors.accentBlue.withValues(alpha: 0.4),
                  offset: const Offset(4, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Responsive.isDesktop(context))
                  const AvatarWidget().paddingOnly(right: 12),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (Responsive.isMobile(context))
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              EditTextTileButtons(
                                onCopyClick: () async {
                                  await context
                                      .read<EditTextProvider>()
                                      .onCopyToClipboard();
                                },
                                onTranslateClick: () {},
                                onPlayClick: () {},
                              ),
                            ]).paddingOnly(bottom: 16),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (Responsive.isMobile(context))
                            AvatarWidget(
                              color: avatarColors[int.parse(log.speaker) % avatarColors.length],
                            ).paddingOnly(right: 12),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    Responsive.isDesktop(context) ? 16 : 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.accentBlue,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Speaker ${log.speaker}',
                                style: AppTextStyles.regularPx16,
                              ),
                            ),
                          ),
                        ],
                      ).paddingOnly(bottom: 16),
                      EditableTextfield(
                        quillController:
                            context.read<EditTextProvider>().quillController,
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
                onCopyClick: () async {
                  await context.read<EditTextProvider>().onCopyToClipboard();
                },
                onTranslateClick: () {},
                onPlayClick: () {},
              ),
            ]),
          )
      ],
    );
  }
}
