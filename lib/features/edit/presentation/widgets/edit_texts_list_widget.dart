import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/widgets/column_builder_widget.dart';
import 'package:doctor_ai_assistent/features/edit/presentation/widgets/edit_text_tile.dart';
import 'package:doctor_ai_assistent/features/edit/provider/edit_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTextsListWidget extends StatelessWidget {
  final List<int> list;

  const EditTextsListWidget({super.key, this.list = const []});

  @override
  Widget build(BuildContext context) {
    return ColumnBuilder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider(
            create: (context) => EditProvider(),
            child: const EditTextTile(),
          ).paddingOnly(bottom: 20);
        });
  }
}
