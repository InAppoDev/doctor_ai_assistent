import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/widgets/column_builder_widget.dart';
import 'package:ecnx_ambient_listening/features/edit/provider/edit_text_provider.dart';
import 'package:ecnx_ambient_listening/features/medical_form/data/models/medical_form_model.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/widgets/history_log_modal.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/widgets/medical_history_widget.dart';
import 'package:ecnx_ambient_listening/features/medical_form/provider/medical_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicalFormDetailsBody extends StatelessWidget {
  final List<TitleAndTextModel> list;

  const MedicalFormDetailsBody({super.key, this.list = const []});

  @override
  Widget build(BuildContext context) {
    return ColumnBuilder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider(
            create: (context) => EditTextProvider()..initData(context.read<MedicalFormProvider>().quillControllers[index], null, list[index]), 
            child: MedicalHistoryTile(
              onHistoryLogClick: () {
                showDialog(context: context, builder: (context) => HistoryLogModal(before: 'Before the Symptop', after: 'After the Symptop', onCloseClick: () {}));
              },
            ),
          ).paddingOnly(bottom: 20);
        });
  }
}
