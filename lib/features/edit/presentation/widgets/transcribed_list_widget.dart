import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/features/edit/presentation/widgets/transcribed_list_item_widget.dart';
import 'package:doctor_ai_assistent/features/record/presentation/pages/record_page.dart';
import 'package:flutter/material.dart';

class TranscribedList extends StatelessWidget {

  final List<int> list;

  const TranscribedList({super.key, this.list = const []});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return TranscribedListItemWidget(
                text: 'Speech-to-Text Implementation.Speech Input Indicator .Transcribed Patient Responses. Speech-to-Text Implementation.Speech Input Indicator .Transcribed Patient Responses ',
                date: DateTime.now(),
              ).paddingOnly(bottom: 20);
            },
            childCount: list.length,
          ),
        ),
      ]
    );
  }
}
