import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/features/edit/presentation/widgets/transcribed_list/transcribed_list_item_widget.dart';
import 'package:doctor_ai_assistent/features/edit/provider/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TranscribedList extends StatelessWidget {
  /// The integer list should be changed to the actual data model list
  final List<int> list;

  const TranscribedList({super.key, this.list = const []});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: CustomScrollView(slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return TranscribedListItemWidget(
                text:
                    'Speech-to-Text Implementation.Speech Input Indicator .Transcribed Patient Responses. Speech-to-Text Implementation.Speech Input Indicator .Transcribed Patient Responses ',
                date: DateTime.now(),
                id: index,
                onTap: () {
                  context.read<PlayerProvider>().setTranscribedId(index);
                },
              ).paddingOnly(bottom: 20);
            },
            childCount: list.length,
          ),
        ),
      ]),
    );
  }
}
