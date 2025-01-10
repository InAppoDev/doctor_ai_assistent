import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/features/home_page/presentation/widgets/appointments/appointments_list.dart';
import 'package:ecnx_ambient_listening/features/home_page/providers/home_state.dart';
import 'package:ecnx_ambient_listening/features/medical_form/presentation/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentsContainerWidget extends StatelessWidget {
  const AppointmentsContainerWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
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
      child: Column(
        children: [
          SearchBarWidget(
            onMicTap: () {},
            onSearch: () {},
            controller: TextEditingController(),
          ).paddingOnly(right: 20),
          const SizedBox(height: 32),
          Expanded(
            child: AppointmentsListWidget(
              appointments: context.read<HomeState>().appointments
            ),
          )
        ]
      )
    ); 
  }
}
