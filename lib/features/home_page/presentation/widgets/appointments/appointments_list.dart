import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/models/appointment_model/appointment_model.dart';
import 'package:ecnx_ambient_listening/core/models/log_model/log_model.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:ecnx_ambient_listening/features/home_page/presentation/widgets/appointments/appointment_tile.dart';
import 'package:flutter/material.dart';

class AppointmentsListWidget extends StatelessWidget {
  final List<AppointmentModel> appointments;
  final LogModel? Function(int) getLogByAppointment;

  const AppointmentsListWidget({
    super.key,
    required this.appointments,
    required this.getLogByAppointment,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context)
          .copyWith(scrollbars: Responsive.isDesktop(context) ? true : false),
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final appointment = appointments[index];
                return AppointmentTileWidget(
                  appointment: appointment,
                  log: getLogByAppointment(appointments[index].id),
                ).paddingOnly(
                    bottom: Responsive.isDesktop(context) ? 32 : 20,
                    right: Responsive.isDesktop(context) ? 20 : 0);
              },
              childCount: appointments.length,
            ),
          ),
        ],
      ),
    );
  }
}
