import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/models/form_model/form_model.dart';
import 'package:ecnx_ambient_listening/core/widgets/column_builder_widget.dart';
import 'package:ecnx_ambient_listening/features/edit/provider/edit_text_provider.dart';
import 'package:ecnx_ambient_listening/features/medical_form/data/models/medical_form_model.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/widgets/history_log_modal.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/widgets/medical_history_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicalFormDetailsBody extends StatelessWidget {
  final List<FormModel> list;
  final void Function(int, String) onTitleTextChanged;
  final void Function(int, String) onConclusionChanged;
  final String searchQuery;

  const MedicalFormDetailsBody({
    super.key,
    this.list = const [],
    required this.onTitleTextChanged,
    required this.onConclusionChanged,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return ColumnBuilder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider(
            create: (context) => EditTextProvider()
              ..initData(TitleAndTextModel(
                title: list[index].name,
                text: list[index].conclusion ?? '',
              )),
            child: MedicalHistoryTile(
              searchQuery: searchQuery,
              onHistoryLogClick: () {
                showDialog(
                    context: context,
                    builder: (context) => HistoryLogModal(
                        before: 'Before the Symptop',
                        after: 'After the Symptop',
                        onCloseClick: () {}));
              },
              onTitleTextChanged: (updatedText) {
                onTitleTextChanged(index, updatedText);
              },
              onConclusionChanged: (updatedText) {
                onConclusionChanged(index, updatedText);
              },
            ),
          ).paddingOnly(bottom: 20);
        });
  }
}
