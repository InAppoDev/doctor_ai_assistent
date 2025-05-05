import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/models/log_model/log_model.dart';
import 'package:ecnx_ambient_listening/core/widgets/column_builder_widget.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/widgets/edit_text_tile/edit_text_tile.dart';
import 'package:ecnx_ambient_listening/features/edit/provider/edit_state.dart';
import 'package:ecnx_ambient_listening/features/edit/provider/edit_text_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTextsListWidget extends StatelessWidget {
  final List<LogModel> logList;

  const EditTextsListWidget({super.key, this.logList = const []});

  @override
  Widget build(BuildContext context) {
    return ColumnBuilder(
        itemCount: logList.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider(
            create: (context) => EditTextProvider()
              ..initData(
                context.read<EditState>().quillControllers[index],
                logList[index].transcription,
              ),
            child: EditTextTile(
              log: logList[index],
            ),
          ).paddingOnly(bottom: 20);
        });
  }
}
