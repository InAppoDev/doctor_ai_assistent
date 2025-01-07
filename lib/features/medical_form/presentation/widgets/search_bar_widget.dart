import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/widgets/primary_button.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function() onSearch;
  final Function() onMicTap;

  const SearchBarWidget({super.key, required this.controller, required this.onSearch, required this.onMicTap});

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
                  padding: EdgeInsets.symmetric(horizontal: Responsive.isDesktop(context) ? 16 : 12),
                  child: const Icon(Icons.search, color: AppColors.text),
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: AppTextStyles.regularPx16.copyWith(color: AppColors.disabled),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) {
                      onSearch();
                    },
                  ),
                ),
                if (controller.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.accentBlue),
                    onPressed: () {
                      controller.clear();
                      debugPrint("clear the controller"); 
                    },
                  ).paddingOnly(left: 16),
                IconButton(
                  icon: const Icon(Icons.mic, color: AppColors.accentBlue),
                  onPressed: () {
                    // Handle voice input action
                    onMicTap();
                    debugPrint("Mic tapped");
                  },
                ).paddingSymmetric(horizontal: 16),
                if (Responsive.isDesktop(context))
                  SizedBox(
                    width: 140,
                    height: 48,
                    child: PrimaryButton(
                      onPress: () {
                        onSearch();
                      },
                      color: AppColors.accentBlue,
                      textColor: AppColors.white,
                      text: 'Search',
                      textStyle: AppTextStyles.regularPx16.copyWith(color: AppColors.white),
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
