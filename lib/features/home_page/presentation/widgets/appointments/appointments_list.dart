import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:doctor_ai_assistent/features/home_page/data/models/appointment_model.dart';
import 'package:doctor_ai_assistent/features/home_page/presentation/widgets/appointments/appointment_tile.dart';
import 'package:flutter/material.dart';

class AppointmentsListWidget extends StatelessWidget {
  final List<AppointmentModel> appointments;

  const AppointmentsListWidget({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: Responsive.isDesktop(context) ? true : false),
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final appointment = appointments[index];
                return AppointmentTileWidget(appointment: appointment).paddingOnly(bottom: Responsive.isDesktop(context) ? 32 : 20, right: Responsive.isDesktop(context) ? 20 : 0);
              },
              childCount: appointments.length,
            ),
          ),
        ],
      ),
    );
  }
}
