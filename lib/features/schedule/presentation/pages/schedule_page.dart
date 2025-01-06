import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/extensions/datetime_extension.dart';
import 'package:doctor_ai_assistent/core/extensions/time_of_day_extension.dart';
import 'package:doctor_ai_assistent/core/widgets/logo_widget.dart';
import 'package:doctor_ai_assistent/core/widgets/primary_button.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:doctor_ai_assistent/features/home_page/presentation/widgets/date_picker_widget.dart';
import 'package:doctor_ai_assistent/features/schedule/presentation/provider/schedule_state.dart';
import 'package:doctor_ai_assistent/features/schedule/presentation/widgets/choose_time_and_date_widget.dart';
import 'package:doctor_ai_assistent/features/schedule/presentation/widgets/radio_with_time.dart';
import 'package:doctor_ai_assistent/features/schedule/presentation/widgets/schedule_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_text_styles.dart';

@RoutePage()
class SchedulePage extends StatelessWidget implements AutoRouteWrapper {
  const SchedulePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ScheduleState(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: Responsive.isDesktop(context) ? CrossAxisAlignment.start : CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    LogoWidget(onTap: () {}),
                  ]
                ).paddingOnly(bottom: Responsive.isDesktop(context) ? 40 : 24),
                if (Responsive.isMobile(context)) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: AppColors.accentBlue, size: 24),
                        onPressed: () {
                          
                        }
                      ),
                      const Text(
                        'Schedule a patient',
                        style: AppTextStyles.mediumPx24
                      ),
                      Container()
                    ]
                  ).paddingOnly(bottom: 12 ),
                  Consumer<ScheduleState>(builder: (context, state, _) {
                    return DatePickerWidget(
                      onDateSelected: (date) {
                        state.onScheduleDateTimeSelected(date);
                      },
                      selectedDate: state.scheduleDateTime,
                      needTitle: false,
                    );
                  }).paddingSymmetric(horizontal: 36, vertical: 12),
                  Consumer<ScheduleState>(
                    builder: (context, state, _) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: Responsive.isDesktop(context) ? 10 : 69,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3.5,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: context.read<ScheduleState>().availableTimes.length,
                        itemBuilder: (context, index) {
                          final time = state.availableTimes[index];
                          return RadioWithTimeWidget(
                            time: time,
                            onPressed: (selectedTime) {
                              state.onScheduleTimeSelected(selectedTime);
                            },
                            isAvailable: index % 2 == 0,
                            isSelected: state.scheduleTime == time,
                          );
                        },
                      );
                    }
                  ).paddingOnly(bottom: 24),
                  ChangeNotifierProvider(create: (context) => context.read<ScheduleState>(), child: const ScheduleFormWidget()).paddingOnly(bottom: 16),
                  Consumer<ScheduleState>(
                    builder: (context, state, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${state.scheduleDateTime.getMonthName()} ${state.scheduleDateTime.year}, ${state.scheduleDateTime.day}, ${state.scheduleTime.toUsaTime()}',
                            style: AppTextStyles.mediumPx16.copyWith(color: AppColors.accentGreen)
                          ),
                        ],
                      );
                    }
                  ).paddingOnly(bottom: 24)
                ],
                if (Responsive.isDesktop(context)) ...[
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Schedule a patient',
                        style: AppTextStyles.mediumPx32
                      )
                    ]
                  ).paddingOnly(bottom: 40),
                   Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ChangeNotifierProvider(create: (context) => context.read<ScheduleState>(), child: const ScheduleFormWidget()).paddingOnly(bottom: 24),
                            Consumer<ScheduleState>(
                              builder: (context, state, _) {
                                return Text(
                                  '${state.scheduleDateTime.getMonthName()} ${state.scheduleDateTime.year}, ${state.scheduleDateTime.day}, ${state.scheduleTime.toUsaTime()}',
                                  style: AppTextStyles.mediumPx16.copyWith(color: AppColors.accentGreen)
                                );
                              }
                            )
                          ]
                        )
                      ),
                      Flexible(flex: 1,child: Container()),
                      Flexible(
                        flex: 4,
                        child: ChangeNotifierProvider(create: (context) => context.read<ScheduleState>(), child: const ChooseTimeAndDateWidget())
                      )
                    ]
                  ).paddingOnly(bottom: 40),
                ],
                Responsive(
                  mobile: Column(
                    children: [
                      PrimaryButton(
                        text: 'Submit',
                        textColor: AppColors.white,
                        color: AppColors.accentBlue,
                        borderColor: AppColors.accentBlue,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        onPress: () {},
                      ).paddingOnly(bottom: 16),
                      PrimaryButton(
                        text: 'Cancel',
                        textColor: AppColors.text,
                        color: AppColors.bg,
                        borderColor: AppColors.accentBlue,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        onPress: () {},
                      )
                    ]
                  ), 
                  desktop: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryButton(
                        text: 'Submit',
                        textColor: AppColors.white,
                        color: AppColors.accentBlue,
                        borderColor: AppColors.accentBlue,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        onPress: () {},
                      ).paddingOnly(right: 20),
                      PrimaryButton(
                        text: 'Cancel',
                        textColor: AppColors.text,
                        color: AppColors.bg,
                        borderColor: AppColors.accentBlue,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        onPress: () {},
                      )
                    ]
                  )
                )
              ],
            ).paddingSymmetric(
              horizontal: Responsive.isDesktop(context) ? 40 : 16,
              vertical: Responsive.isDesktop(context) ? 56 : 24,
            ),
          ),
        ),
      )
    );
  }
}
