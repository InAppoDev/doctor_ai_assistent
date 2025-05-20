import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/models/chunk_model/chunk_model.dart';
import 'package:ecnx_ambient_listening/features/edit/presentation/widgets/transcribed_list/transcribed_list_item_widget.dart';
import 'package:ecnx_ambient_listening/features/edit/provider/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TranscribedList extends StatelessWidget {
  /// The integer list should be changed to the actual data model list
  final List<ChunkModel> chunks;

  const TranscribedList({super.key, this.chunks = const []});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: CustomScrollView(slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return TranscribedListItemWidget(
                speaker: int.parse(chunks[index].speaker),
                text: chunks[index].transcription,
                date: DateTime.now(),
                id: index,
                onTap: () {
                  context
                      .read<PlayerProvider>()
                      .setTranscribedId(index, chunks[index].time);
                },
              ).paddingOnly(bottom: 20);
            },
            childCount: chunks.length,
          ),
        ),
      ]),
    );
  }
}
