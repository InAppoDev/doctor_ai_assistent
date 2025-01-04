import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/widgets/column_builder_widget.dart';
import 'package:doctor_ai_assistent/features/edit/provider/edit_text_provider.dart';
import 'package:doctor_ai_assistent/features/medical_form/presentation/widgets/medical_history_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicalFormDetailsBody extends StatelessWidget {
  final List<int> list;

  const MedicalFormDetailsBody({super.key, this.list = const []});

  @override
  Widget build(BuildContext context) {
    return ColumnBuilder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider(
            create: (context) => EditTextProvider(),
            child: MedicalHistoryTile(
              onCopyClick: () {},
              onHistoryLogClick: () {},
            ),
          ).paddingOnly(bottom: 20);
        });
  }
}
