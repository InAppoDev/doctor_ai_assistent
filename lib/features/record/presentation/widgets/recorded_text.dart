import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class ColorCodedTextField extends StatefulWidget {
  const ColorCodedTextField({
    super.key,
    required this.height
  });

  final double height;

  @override
  State createState() => _ColorCodedTextFieldState();
}

class _ColorCodedTextFieldState extends State<ColorCodedTextField> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> _textData = [
    {'text': 'Speech-to-Text Implementation.Speech Input Indicator .Transcribed Patient Responses. Auto-populate Pre-defined Medical Forms. Speaker Identification: Multi-speaker Display, Dynamic Speaker Switching, Profiles, Timeline. Speech-to-Text Implementation.Speech Input Indicator .Transcribed Patient Responses. Auto-populate Pre-defined Medical Forms. Speaker Identification: Multi-speaker Display, Dynamic Speaker Switching, Profiles, Timeline.\n\n', 'color': Colors.green},
    {'text': 'Speech-to-Text Implementation.Speech Input Indicator .Transcribed Patient Responses. Auto-populate Pre-defined Medical Forms. Speaker Identification: Multi-speaker Display, Dynamic Speaker Switching, Profiles, Timeline. Speech-to-Text Implementation.Speech.\n\n', 'color': Colors.blue},
    {'text': 'Speech-to-Text Implementation.Speech Input Indicator .Transcribed Patient Responses. Auto-populate Pre-defined Medical For\n\n', 'color': Colors.red},
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0xff33333340),
            blurRadius: 5,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: RawScrollbar(
          thumbColor: AppColors.accentBlue,
          radius: const Radius.circular(10),
          thickness: 2,
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(10),
            child: SelectableText.rich(
              TextSpan(
                children: _textData.map((data) {
                  return TextSpan(
                    text: data['text'],
                    style: AppTextStyles.regularPx16.copyWith(color: data['color'])
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
