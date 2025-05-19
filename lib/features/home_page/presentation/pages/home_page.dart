import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/navigation/routes.dart';
import 'package:ecnx_ambient_listening/core/widgets/logo_widget.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:ecnx_ambient_listening/features/home_page/presentation/widgets/appointments/appointments_container_widget.dart';
import 'package:ecnx_ambient_listening/features/home_page/presentation/widgets/appointments/appointments_list.dart';
import 'package:ecnx_ambient_listening/features/home_page/presentation/widgets/date_picker_widget.dart';
import 'package:ecnx_ambient_listening/features/home_page/presentation/widgets/schedule_patient_button.dart';
import 'package:ecnx_ambient_listening/features/home_page/providers/home_state.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: false,
      create: (context) => HomeState(),
      builder: (context, _) {
        return Consumer<HomeState>(builder: (context, state, _) {
          final homeProvider = context.read<HomeState>();
          return Scaffold(
              backgroundColor: AppColors.bg,
              body: SafeArea(
                  child: Row(children: [
                if (Responsive.isDesktop(context))
                  Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LogoWidget(onTap: () {})
                                    .paddingOnly(bottom: 40),
                                DatePickerWidget(
                                  onDateSelected: (DateTime date) {
                                    /// call the view model method to update the selected date
                                    /// the view model should update the appointments list based on the selected date
                                    state.onDateSelected(date);
                                  },
                                  selectedDate: state.selectedDate,
                                  needTitle: false,
                                ),
                                SchedulePatientButton(
                                  onPressed: () async {
                                    await ScheduleRoute().push(context);
                                  },
                                )
                              ],
                            ),
                          ),
                          Flexible(flex: 1, child: Container())
                        ],
                      )),
                Flexible(
                    flex: 3,
                    child: Column(
                        crossAxisAlignment: Responsive.isDesktop(context)
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                        children: [
                          if (Responsive.isMobile(context))
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [LogoWidget(onTap: () {})]),
                          SizedBox(
                              height: Responsive.isDesktop(context) ? 84 : 24),
                          Text(
                            'Appointments',
                            style: Responsive.isDesktop(context)
                                ? AppTextStyles.mediumPx32
                                : AppTextStyles.mediumPx24,
                          ).paddingOnly(
                              bottom: Responsive.isDesktop(context) ? 40 : 24),

                          /// mobile appointment list section
                          if (Responsive.isMobile(context)) ...[
                            DatePickerWidget(
                              onDateSelected: (DateTime date) {
                                /// call the view model method to update the selected date
                                /// the view model should update the appointments list based on the selected date
                                state.onDateSelected(date);
                              },
                              selectedDate: state.selectedDate,
                              needTitle: false,
                            ).paddingOnly(bottom: 24),
                            SearchBarWidget(
                              isListening: state.isListening,
                              onClear: state.searchController.clear,
                              controller: state.searchController,
                              onSearch: () {
                                /// call the view model method to search for the patient
                                /// the view model should update the appointments list based on the search result
                                // context.read<HomeState>().searchPatient();
                              },
                              onMicTap: () {
                                homeProvider.onMicTap();
                              },
                            ).paddingOnly(bottom: 24),
                            SchedulePatientButton(
                              onPressed: () async {
                                await ScheduleRoute().push(context);
                                if (context.mounted) {
                                  await context
                                      .read<HomeState>()
                                      .getAppointments();
                                }
                              },
                            ).paddingOnly(bottom: 16),
                            state.isLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.accentBlue,
                                    ),
                                  )
                                : Expanded(
                                    child: AppointmentsListWidget(
                                      appointments: homeProvider.appointments,
                                      getLogByAppointment:
                                          homeProvider.getLogByAppointment,
                                    ),
                                  )
                          ],

                          /// desktop appointment list section
                          if (Responsive.isDesktop(context))
                            ChangeNotifierProvider(
                              create: (context) => HomeState(),
                              child: Expanded(
                                child: Row(
                                  children: [
                                    Flexible(
                                        flex: 4,
                                        child: AppointmentsContainerWidget(
                                          getLogByAppointment:
                                              homeProvider.getLogByAppointment,
                                        )),
                                    Flexible(flex: 1, child: Container())
                                  ],
                                ),
                              ),
                            )
                        ]))
              ])).paddingSymmetric(
                  horizontal: Responsive.isDesktop(context) ? 40 : 16,
                  vertical: Responsive.isDesktop(context) ? 56 : 24));
        });
      },
    );
  }
}
