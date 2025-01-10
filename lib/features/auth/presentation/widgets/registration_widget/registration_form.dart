import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/widgets/primary_button.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:ecnx_ambient_listening/core/widgets/custom_textfield_widget.dart';
import 'package:ecnx_ambient_listening/features/auth/provider/registration_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationFormWidget extends StatelessWidget {
  final Function() onSignInTap;
  final Function onRegisterTap;

  const RegistrationFormWidget({super.key, required this.onSignInTap, required this.onRegisterTap});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Column(
        children: [
          Text(
            'Register',
            style: Responsive.isDesktop(context) ? AppTextStyles.mediumPx40 : AppTextStyles.mediumPx24,
          ).paddingOnly(bottom: Responsive.isDesktop(context) ? 56 : 24),
          CustomTextFieldWidget(
            context: context,
            controller: context.read<RegisterState>().firstNameController,
            label: 'First Name',
            hintText: 'First name',
            labelStyle: Responsive.isDesktop(context) ? AppTextStyles.mediumPx16 : AppTextStyles.mediumPx14,
          ).paddingOnly(bottom: Responsive.isDesktop(context) ? 24 : 20),
          CustomTextFieldWidget(
            context: context,
            controller: context.read<RegisterState>().lastNameController,
            label: 'Last Name',
            hintText: 'Last name',
            labelStyle: Responsive.isDesktop(context) ? AppTextStyles.mediumPx16 : AppTextStyles.mediumPx14,
          ).paddingOnly(bottom: Responsive.isDesktop(context) ? 24 : 20),
          CustomTextFieldWidget(
            context: context,
            controller: context.read<RegisterState>().phoneNumberController,
            label: 'Phone Number',
            hintText: 'Phone number',
            labelStyle: Responsive.isDesktop(context) ? AppTextStyles.mediumPx16 : AppTextStyles.mediumPx14,
          ).paddingOnly(bottom: Responsive.isDesktop(context) ? 24 : 20),
          CustomTextFieldWidget(
            context: context,
            controller: context.read<RegisterState>().emailController,
            label: 'E-mail',
            hintText: 'E-mail',
            labelStyle: Responsive.isDesktop(context) ? AppTextStyles.mediumPx16 : AppTextStyles.mediumPx14,
          ).paddingOnly(bottom: Responsive.isDesktop(context) ? 24 : 20),
          Consumer<RegisterState>(
            builder: (context, state, _) {
              return CustomTextFieldWidget(
                context: context,
                controller: state.passwordController,
                label: 'Password',
                hintText: 'Password',
                obscureText: !state.isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(state.isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => state.togglePasswordVisibility(),
                ),
                labelStyle: Responsive.isDesktop(context) ? AppTextStyles.mediumPx16 : AppTextStyles.mediumPx14,
              ).paddingOnly(bottom: Responsive.isDesktop(context) ? 24 : 20);
            },
          ),
          Consumer<RegisterState>(
            builder: (context, state, _) {
              return CustomTextFieldWidget(
                context: context,
                controller: state.confirmPasswordController,
                label: 'Password Confirmation',
                hintText: 'Password confirmation',
                obscureText: !state.isPasswordConfirmationVisible,
                suffixIcon: IconButton(
                  icon: Icon(state.isPasswordConfirmationVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => state.togglePasswordConfirmationVisibility(),
                ),
                labelStyle: Responsive.isDesktop(context) ? AppTextStyles.mediumPx16 : AppTextStyles.mediumPx14,
              ).paddingOnly(bottom: Responsive.isDesktop(context) ? 24 : 20);
            },
          ).paddingOnly(bottom: Responsive.isDesktop(context) ? 32 : 24),
          PrimaryButton(
            text: 'Register',
            textColor: AppColors.white,
            color: AppColors.accentBlue,
            borderColor: AppColors.accentBlue,
            textStyle: AppTextStyles.regularPx16.copyWith(color: AppColors.white),
            padding: const EdgeInsets.symmetric(vertical: 12),
            fullWidth: true,
            onPress: () {
              if (context.read<RegisterState>().formKey.currentState!.validate()) {
                // Handle registration logic
              }
            },
          ).paddingOnly(bottom: Responsive.isDesktop(context) ? 24 : 16),
          PrimaryButton(
            text: 'Sign in',
            textColor: AppColors.text,
            color: Colors.transparent,
            borderColor: AppColors.accentBlue,
            textStyle: AppTextStyles.regularPx16.copyWith(color: AppColors.accentBlue),
            padding: const EdgeInsets.symmetric(vertical: 12),
            onPress: () {
              onSignInTap();
            },
          ).paddingOnly(bottom: Responsive.isDesktop(context) ? 24 : 16),
        ],
      ),
      desktop: Column(
        children: [
          Text(
            'Register',
            style: Responsive.isDesktop(context) ? AppTextStyles.mediumPx40 : AppTextStyles.mediumPx24,
          ).paddingOnly(bottom: Responsive.isDesktop(context) ? 56 : 24),
          Row(
            children: [
              Expanded(
                child: CustomTextFieldWidget(
                  context: context,
                  controller: context.read<RegisterState>().firstNameController,
                  label: 'First Name',
                  hintText: 'First name',
                  labelStyle: Responsive.isDesktop(context) ? AppTextStyles.mediumPx16 : AppTextStyles.mediumPx14,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: CustomTextFieldWidget(
                  context: context,
                  controller: context.read<RegisterState>().lastNameController,
                  label: 'Last Name',
                  hintText: 'Last name',
                  labelStyle: Responsive.isDesktop(context) ? AppTextStyles.mediumPx16 : AppTextStyles.mediumPx14,
                ),
              ),
            ],
          ).paddingOnly(bottom: Responsive.isDesktop(context) ? 24 : 20),
          Row(
            children: [
              Expanded(
                  child: CustomTextFieldWidget(
                context: context,
                controller: context.read<RegisterState>().phoneNumberController,
                label: 'Phone Number',
                hintText: 'Phone number',
                labelStyle: Responsive.isDesktop(context) ? AppTextStyles.mediumPx16 : AppTextStyles.mediumPx14,
              )),
              const SizedBox(width: 20),
              Expanded(
                  child: CustomTextFieldWidget(
                context: context,
                controller: context.read<RegisterState>().emailController,
                label: 'E-mail',
                hintText: 'E-mail',
                labelStyle: Responsive.isDesktop(context) ? AppTextStyles.mediumPx16 : AppTextStyles.mediumPx14,
              ))
            ],
          ).paddingOnly(bottom: Responsive.isDesktop(context) ? 24 : 20),
          Row(
            children: [
              Consumer<RegisterState>(
                builder: (context, state, _) {
                  return Expanded(
                      child: CustomTextFieldWidget(
                    context: context,
                    controller: state.passwordController,
                    label: 'Password',
                    hintText: 'Password',
                    obscureText: !state.isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        size: Responsive.isDesktop(context) ? 24 : 20,
                      ),
                      onPressed: () => state.togglePasswordVisibility(),
                    ),
                    labelStyle: Responsive.isDesktop(context) ? AppTextStyles.mediumPx16 : AppTextStyles.mediumPx14,
                  ));
                },
              ),
              const SizedBox(width: 20),
              Consumer<RegisterState>(builder: (context, state, _) {
                return Expanded(
                    child: CustomTextFieldWidget(
                  context: context,
                  controller: state.confirmPasswordController,
                  label: 'Password Confirmation',
                  hintText: 'Password confirmation',
                  obscureText: !state.isPasswordConfirmationVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      state.isPasswordConfirmationVisible ? Icons.visibility : Icons.visibility_off,
                      size: Responsive.isDesktop(context) ? 24 : 20,
                    ),
                    onPressed: () => state.togglePasswordConfirmationVisibility(),
                  ),
                  labelStyle: Responsive.isDesktop(context) ? AppTextStyles.mediumPx16 : AppTextStyles.mediumPx14,
                ));
              })
            ],
          ).paddingOnly(bottom: Responsive.isDesktop(context) ? 32 : 24),
          PrimaryButton(
            text: 'Register',
            textColor: AppColors.white,
            color: AppColors.accentBlue,
            borderColor: AppColors.accentBlue,
            padding: const EdgeInsets.symmetric(vertical: 12),
            onPress: () {
              onRegisterTap();
            },
          ).paddingOnly(bottom: Responsive.isDesktop(context) ? 24 : 16),
          PrimaryButton(
            text: 'Sign in',
            textColor: AppColors.text,
            color: Colors.transparent,
            borderColor: AppColors.accentBlue,
            padding: const EdgeInsets.symmetric(vertical: 12),
            onPress: () {
              onSignInTap();
            },
          ).paddingOnly(bottom: Responsive.isDesktop(context) ? 24 : 16),
        ],
      ),
    );
  }
}
