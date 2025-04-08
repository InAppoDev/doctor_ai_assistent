import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/navigation/routes.dart';
import 'package:ecnx_ambient_listening/core/utils/ui_utils.dart';
import 'package:ecnx_ambient_listening/core/widgets/custom_text_button.dart';
import 'package:ecnx_ambient_listening/core/widgets/custom_textfield_widget.dart';
import 'package:ecnx_ambient_listening/core/widgets/logo_widget.dart';
import 'package:ecnx_ambient_listening/core/widgets/primary_button.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:ecnx_ambient_listening/features/auth/provider/auth_provider.dart';
import 'package:ecnx_ambient_listening/features/auth/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginState(),
      builder: (context, _) {
        final loginPr = context.read<LoginState>();
        final authPr = context.read<AuthProvider>();
        return Scaffold(
            backgroundColor: AppColors.bg,
            body: Form(
              key: loginPr.formKey,
              child: SafeArea(
                  child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  LogoWidget(
                    onTap: () {},
                  )
                ]),
                Row(
                  children: [
                    if (Responsive.isDesktop(context))
                      Flexible(flex: 1, child: Container()),
                    Flexible(
                      flex: 1,
                      child: Column(children: [
                        Text('Log in',
                                style: Responsive.isDesktop(context)
                                    ? AppTextStyles.mediumPx40
                                    : AppTextStyles.mediumPx24)
                            .paddingOnly(
                                bottom:
                                    Responsive.isDesktop(context) ? 56 : 24),

                        /// login form fields
                        CustomTextFieldWidget(
                          context: context,
                          controller: loginPr.loginController,
                          label: 'Login',
                          hintText: 'Login',
                          labelStyle: Responsive.isDesktop(context)
                              ? AppTextStyles.mediumPx16
                              : AppTextStyles.mediumPx14,
                        ).paddingOnly(
                            bottom: Responsive.isDesktop(context) ? 24 : 20),
                        Consumer<LoginState>(builder: (context, state, _) {
                          return CustomTextFieldWidget(
                            context: context,
                            controller: state.passwordController,
                            label: 'Password',
                            hintText: 'Password',
                            obscureText: !state.isPasswordVisible,
                            prefixIcon: false,
                            suffixIcon: IconButton(
                              icon: Icon(state.isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                state.togglePasswordVisibility();
                              },
                            ),
                            labelStyle: Responsive.isDesktop(context)
                                ? AppTextStyles.mediumPx16
                                : AppTextStyles.mediumPx14,
                          ).paddingOnly(
                              bottom: Responsive.isDesktop(context) ? 24 : 20);
                        }),

                        /// forgot password button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomTextButton(
                              text: 'Forgot your password?',
                              color: AppColors.accentBlue,
                              onPressed: () {},
                            )
                          ],
                        ).paddingOnly(
                            bottom: Responsive.isDesktop(context) ? 32 : 24),

                        /// buttons section
                        PrimaryButton(
                          text: 'Sign in',
                          textColor: AppColors.white,
                          color: AppColors.accentBlue,
                          borderColor: AppColors.accentBlue,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          textStyle: Responsive.isDesktop(context)
                              ? AppTextStyles.regularPx20
                                  .copyWith(color: AppColors.white)
                              : AppTextStyles.regularPx16
                                  .copyWith(color: AppColors.white),
                          fullWidth: true,
                          onPress: () async {
                            /// validate the form and login
                            /// if the form is valid, get the token and navigate to the home page
                            /// if the form is invalid, show the error message
                            if (loginPr.formKey.currentState!.validate()) {
                              final isSuccess = await loginPr.submitLogin();
                              if (isSuccess && context.mounted) {
                                authPr.login();
                                HomeRoute().pushReplacement(context);
                              } else {
                                showToast('Invalid email or password',
                                    bgColor: AppColors.error);
                              }
                            }
                          },
                        ).paddingOnly(
                            bottom: Responsive.isDesktop(context) ? 24 : 16),
                        PrimaryButton(
                          text: 'Register',
                          textColor: AppColors.text,
                          color: Colors.transparent,
                          borderColor: AppColors.accentBlue,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          textStyle: Responsive.isDesktop(context)
                              ? AppTextStyles.regularPx20
                              : AppTextStyles.regularPx16,
                          fullWidth: true,
                          onPress: () {
                            RegistrationRoute().push(context).then((_) {
                              if (context.mounted) {
                                loginPr.loginController.clear();
                                loginPr.passwordController.clear();
                              }
                            });
                          },
                        ).paddingOnly(
                            bottom: Responsive.isDesktop(context) ? 24 : 16),
                      ]),
                    ),
                    if (Responsive.isDesktop(context))
                      Flexible(flex: 1, child: Container()),
                  ],
                )
              ])).paddingSymmetric(
                  horizontal: Responsive.isDesktop(context) ? 40 : 16,
                  vertical: Responsive.isDesktop(context) ? 56 : 24),
            ));
      },
    );
  }
}
