import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/widgets/primary_button.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function() onSearch;
  final Function() onMicTap;
  final Function() onClear;
  final bool isListening;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onMicTap,
    required this.onClear,
    this.isListening = false,
  });

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController textEditingController = TextEditingController();
  late bool showCloseButton;

  @override
  void initState() {
    super.initState();
    showCloseButton = widget.controller.text.isNotEmpty;
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    if (!mounted) return; // Ensure widget is mounted before calling setState
    final shouldShow = widget.controller.text.isNotEmpty;
    if (showCloseButton != shouldShow) {
      setState(() {
        showCloseButton = shouldShow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.accentBlue),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Responsive.isDesktop(context) ? 16 : 12),
                  child: const Icon(Icons.search, color: AppColors.text),
                ),
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: AppTextStyles.regularPx16
                          .copyWith(color: AppColors.disabled),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) {
                      if (mounted) {
                        widget.onSearch(); // Ensure the widget is still active
                      }
                    },
                  ),
                ),
                if (showCloseButton)
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.accentBlue),
                    onPressed: () {
                      if (mounted) {
                        widget.controller.clear();
                        widget.onClear(); // Perform action safely
                      }
                    },
                  ).paddingOnly(left: Responsive.isDesktop(context) ? 16 : 12),
                IconButton(
                  icon: Icon(
                    Icons.mic,
                    color: widget.isListening
                        ? AppColors.accentGreen
                        : AppColors.accentBlue,
                  ),
                  onPressed: widget.onMicTap,
                ).paddingSymmetric(
                    horizontal: Responsive.isDesktop(context) ? 16 : 12),
                if (Responsive.isDesktop(context))
                  SizedBox(
                    width: 140,
                    height: 48,
                    child: PrimaryButton(
                      onPress: widget.onSearch,
                      color: AppColors.accentBlue,
                      textColor: AppColors.white,
                      text: 'Search',
                      textStyle: AppTextStyles.regularPx16
                          .copyWith(color: AppColors.white),
                      borderColor: AppColors.accentBlue,
                    ),
                  )
              ],
            ),
          ),
        )
      ],
    );
  }
}
