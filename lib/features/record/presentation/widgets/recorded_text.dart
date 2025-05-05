import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class ColorCodedTextField extends StatefulWidget {
  const ColorCodedTextField({
    super.key,
    required this.height,
    required this.recordedText,
  });

  final double height;
  final List<String> recordedText;

  @override
  State createState() => _ColorCodedTextFieldState();
}

class _ColorCodedTextFieldState extends State<ColorCodedTextField> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();

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
            child: Text(widget.recordedText.join(),
                style: AppTextStyles.regularPx16.copyWith(color: Colors.green)),
          ),
        ),
      ),
    );
  }
}
