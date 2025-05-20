import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/models/chunk_model/chunk_model.dart';
import 'package:ecnx_ambient_listening/core/widgets/column_builder_widget.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/widgets/edit_text_tile/edit_text_tile.dart';
import 'package:ecnx_ambient_listening/features/edit/provider/edit_text_provider.dart';
import 'package:ecnx_ambient_listening/features/medical_form/data/models/medical_form_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTextsListWidget extends StatelessWidget {
  final List<ChunkModel> chunks;

  const EditTextsListWidget({super.key, this.chunks = const []});

  @override
  Widget build(BuildContext context) {
    return ColumnBuilder(
        itemCount: chunks.length,
        itemBuilder: (context, index) {
          print('chunks[index] - ${chunks[index]}');
          return ChangeNotifierProvider(
            create: (context) => EditTextProvider()
              ..initData(
                TitleAndTextModel(
                    title: chunks[index].speaker,
                    text: chunks[index].transcription),
              ),
            child: EditTextTile(
              chunkModel: chunks[index],
            ),
          ).paddingOnly(bottom: 20);
        });
  }
}
