import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/features/home_page/presentation/widgets/date_picker_widget.dart';
import 'package:ecnx_ambient_listening/features/schedule/presentation/provider/schedule_state.dart';
import 'package:ecnx_ambient_listening/features/schedule/presentation/widgets/radio_with_time.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseTimeAndDateWidget extends StatelessWidget {
  const ChooseTimeAndDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.bg,
        boxShadow: [
          BoxShadow(
            color: AppColors.text.withOpacity(0.1),
            offset: const Offset(0, 6),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(children: [
        Flexible(
          flex: 3,
          child: Consumer<ScheduleState>(
            builder: (context, state, _) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
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
          ),
        ),
        Flexible(flex: 1, child: Container()),
        Flexible(
            flex: 3,
            child: Consumer<ScheduleState>(builder: (context, state, _) {
              return DatePickerWidget(
                onDateSelected: (date) {
                  state.onScheduleDateTimeSelected(date);
                },
                selectedDate: state.scheduleDateTime,
                needTitle: false,
              );
            }))
      ]),
    );
  }
}
