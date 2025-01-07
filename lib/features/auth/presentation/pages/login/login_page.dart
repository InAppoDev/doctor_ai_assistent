import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/navigation/app_route_config.dart';
import 'package:ecnx_ambient_listening/core/services/get_it/get_it_service.dart';
import 'package:ecnx_ambient_listening/core/widgets/custom_text_button.dart';
import 'package:ecnx_ambient_listening/core/widgets/logo_widget.dart';
import 'package:ecnx_ambient_listening/core/widgets/primary_button.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:ecnx_ambient_listening/core/widgets/custom_textfield_widget.dart';
import 'package:ecnx_ambient_listening/features/auth/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class LoginPage extends StatelessWidget implements AutoRouteWrapper {
  const LoginPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginState(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bg,
        body: Form(
          key: context.read<LoginState>().formKey,
          child: SafeArea(
              child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              LogoWidget(
                onTap: () {},
              )
            ]),
            Row(
              children: [
                if (Responsive.isDesktop(context)) Flexible(flex: 1, child: Container()),
                Flexible(
                  flex: 1,
                  child: Column(children: [
                    Text('Log in',
                            style: Responsive.isDesktop(context) ? AppTextStyles.mediumPx40 : AppTextStyles.mediumPx24)
                        .paddingOnly(bottom: Responsive.isDesktop(context) ? 56 : 24),

                    /// login form fields
                    CustomTextFieldWidget(
                      context: context,
                      controller: context.read<LoginState>().loginController,
                      label: 'Login',
                      hintText: 'Login',
                      labelStyle: Responsive.isDesktop(context) ? AppTextStyles.mediumPx16 : AppTextStyles.mediumPx14,
                    ).paddingOnly(bottom: Responsive.isDesktop(context) ? 24 : 20),
                    Consumer<LoginState>(builder: (context, state, _) {
                      return CustomTextFieldWidget(
                        context: context,
                        controller: state.passwordController,
                        label: 'Password',
                        hintText: 'Password',
                        obscureText: !state.isPasswordVisible,
                        prefixIcon: false,
                        suffixIcon: IconButton(
                          icon: Icon(state.isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            state.togglePasswordVisibility();
                          },
                        ),
                        labelStyle: Responsive.isDesktop(context) ? AppTextStyles.mediumPx16 : AppTextStyles.mediumPx14,
                      ).paddingOnly(bottom: Responsive.isDesktop(context) ? 24 : 20);
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
                    ).paddingOnly(bottom: Responsive.isDesktop(context) ? 32 : 24),

                    /// buttons section
                    PrimaryButton(
                      text: 'Sign in',
                      textColor: AppColors.white,
                      color: AppColors.accentBlue,
                      borderColor: AppColors.accentBlue,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      textStyle: Responsive.isDesktop(context) ? AppTextStyles.regularPx20.copyWith(color: AppColors.white) : AppTextStyles.regularPx16.copyWith(color: AppColors.white),
                      fullWidth: true,
                      onPress: () {
                        /// validate the form and login
                        /// if the form is valid, get the token and navigate to the home page
                        /// if the form is invalid, show the error message
                        if (context.read<LoginState>().formKey.currentState!.validate()) {
                          // context.read<LoginState>().login();
                          getIt<AppRouter>().replace(const HomeRoute());
                        }
                      },
                    ).paddingOnly(bottom: Responsive.isDesktop(context) ? 24 : 16),
                    PrimaryButton(
                      text: 'Register',
                      textColor: AppColors.text,
                      color: Colors.transparent,
                      borderColor: AppColors.accentBlue,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      textStyle: Responsive.isDesktop(context) ? AppTextStyles.regularPx20 : AppTextStyles.regularPx16,
                      fullWidth: true,
                      onPress: () {
                        getIt<AppRouter>().replace(const RegistrationRoute()).then((_) {
                          if (context.mounted) {
                            context.read<LoginState>().loginController.clear();
                            context.read<LoginState>().passwordController.clear();
                          }
                        });
                      },
                    ).paddingOnly(bottom: Responsive.isDesktop(context) ? 24 : 16),
                  ]),
                ),
                if (Responsive.isDesktop(context)) Flexible(flex: 1, child: Container()),
              ],
            )
          ])).paddingSymmetric(
              horizontal: Responsive.isDesktop(context) ? 40 : 16, vertical: Responsive.isDesktop(context) ? 56 : 24),
        ));
  }
}
