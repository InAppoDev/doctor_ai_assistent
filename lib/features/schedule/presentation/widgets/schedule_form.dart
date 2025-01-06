import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/widgets/custom_textfield_widget.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:doctor_ai_assistent/features/schedule/presentation/provider/schedule_state.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class ScheduleFormWidget extends StatelessWidget {
  const ScheduleFormWidget ({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFieldWidget(
          context: context,
          controller: context.read<ScheduleState>().firstNameController,
          hintText: 'First name',
          label: 'First name',
        ).paddingOnly(bottom: Responsive.isDesktop(context) ? 24 : 20),
        CustomTextFieldWidget(
          context: context,
          controller: context.read<ScheduleState>().lastNameController,
          hintText: 'Last name',
          label: 'Last name',
        ).paddingOnly(bottom: Responsive.isDesktop(context) ? 24 : 20),
        CustomTextFieldWidget(
          context: context,
          controller: context.read<ScheduleState>().dateOfBirthController,
          hintText: '__/__/____',
          label: 'Date of birth',
          inputFormatters: [
            MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')}),
          ],
        )
      ]
    );
  }
}