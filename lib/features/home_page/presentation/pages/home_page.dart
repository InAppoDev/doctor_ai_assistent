import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/core/widgets/logo_widget.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:doctor_ai_assistent/features/home_page/presentation/widgets/appointments/appointments_container_widget.dart';
import 'package:doctor_ai_assistent/features/home_page/presentation/widgets/appointments/appointments_list.dart';
import 'package:doctor_ai_assistent/features/home_page/presentation/widgets/date_picker_widget.dart';
import 'package:doctor_ai_assistent/features/home_page/presentation/widgets/schedule_patient_button.dart';
import 'package:doctor_ai_assistent/features/home_page/providers/home_state.dart';
import 'package:doctor_ai_assistent/features/medical_form/presentation/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomePage extends StatelessWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeState(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Row(
          children: [
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
                          LogoWidget(onTap: () {}).paddingOnly(bottom: 40),
                          Consumer<HomeState>(
                            builder: (context, state, _) {
                              return DatePickerWidget(
                                onDateSelected: (DateTime date) {
                                  state.onDateSelected(date);
                                }, 
                                selectedDate: state.selectedDate
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                    Flexible(flex: 1, child: Container())
                  ],
                )
              ),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: Responsive.isDesktop(context) ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                children: [
                  if (Responsive.isMobile(context))
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        LogoWidget(onTap: () {})
                      ]
                    ),
                  SizedBox(height: Responsive.isDesktop(context) ? 84 : 24),
                  Text(
                    'Appointments',
                    style: Responsive.isDesktop(context) ? AppTextStyles.mediumPx32 : AppTextStyles.mediumPx24,
                  ).paddingOnly(bottom: Responsive.isDesktop(context) ? 40 : 24),
                  if (Responsive.isMobile(context)) ...[
                    Consumer<HomeState>(
                      builder: (context, state, _) {
                        return DatePickerWidget(
                          onDateSelected: (DateTime date) {
                            state.onDateSelected(date);
                          }, 
                          selectedDate: state.selectedDate
                        );
                      }
                    ).paddingOnly(bottom: 24),
                    SearchBarWidget(controller: context.read<HomeState>().searchController, onSearch: () {}, onMicTap: () {}).paddingOnly(bottom: 24),
                    SchedulePatientButton(
                      onPressed: () {},
                    ).paddingOnly(bottom: 16),
                    Expanded(child: AppointmentsListWidget(
                      appointments: context.read<HomeState>().appointments,
                    ),)
                  ],
                  if (Responsive.isDesktop(context)) 
                    ChangeNotifierProvider(
                      create: (context) => HomeState(),
                      child: Expanded(
                        child: Row(
                          children: [
                            const Flexible(flex: 4, child: AppointmentsContainerWidget()),
                            Flexible(flex: 1, child: Container())
                          ],
                        ),
                      ),
                    )
                ]
              )
            )
          ]
        )
      ).paddingSymmetric(
        horizontal: Responsive.isDesktop(context) ? 40 : 16,
        vertical: Responsive.isDesktop(context) ? 56 : 24
      )
    );
  }
}