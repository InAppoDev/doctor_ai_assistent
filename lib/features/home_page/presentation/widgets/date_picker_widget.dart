import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/core/extensions/datetime_extension.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerWidget extends StatelessWidget {
  final Function(DateTime) onDateSelected;
  final DateTime selectedDate;
  const DatePickerWidget({super.key, required this.onDateSelected, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: Responsive.isDesktop(context) ? CrossAxisAlignment.start : CrossAxisAlignment.center, 
      children: [
        Text(
          '${selectedDate.getWeekDay()}, ${selectedDate.toNameOfMonthAndDay()}',
          style: Responsive.isDesktop(context) ? AppTextStyles.mediumPx20 : AppTextStyles.mediumPx16,
        ).paddingOnly(bottom: 24), 
        SfDateRangePicker(
          backgroundColor: AppColors.bg,
          headerStyle: const DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
            textStyle: AppTextStyles.mediumPx16,
            backgroundColor: AppColors.bg
          ),
          selectionTextStyle: AppTextStyles.regularPx16,
          yearCellStyle: const DateRangePickerYearCellStyle(
            textStyle: AppTextStyles.regularPx16,
          ),
          monthCellStyle: const DateRangePickerMonthCellStyle(
            textStyle: AppTextStyles.regularPx16,
          ),
          viewSpacing: 8,
          view: DateRangePickerView.month,
          selectionShape: DateRangePickerSelectionShape.rectangle,
          showNavigationArrow: true,
          selectionColor: AppColors.accentBlue,
          todayHighlightColor: AppColors.accentBlue.withOpacity(0.5),
          rangeSelectionColor: AppColors.accentBlue.withOpacity(0.5),
          selectionMode: DateRangePickerSelectionMode.single,
          initialSelectedDate: selectedDate,
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            onDateSelected(args.value);
          },
        )
      ]
    );
  }
}
