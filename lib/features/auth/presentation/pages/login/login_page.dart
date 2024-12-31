import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/constants/app_text_styles.dart';
import 'package:doctor_ai_assistent/core/widgets/custom_text_button.dart';
import 'package:doctor_ai_assistent/core/widgets/logo_widget.dart';
import 'package:doctor_ai_assistent/core/widgets/primary_button.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:doctor_ai_assistent/features/auth/presentation/widgets/auth_textfield_widget.dart';
import 'package:doctor_ai_assistent/features/auth/provider/login_provider.dart';
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
                    AuthTextFieldWidget(
                      context: context,
                      controller: context.read<LoginState>().loginController,
                      label: 'Login',
                      hintText: 'Login',
                      labelStyle: Responsive.isDesktop(context) ? AppTextStyles.mediumPx16 : AppTextStyles.mediumPx14,
                    ).paddingOnly(bottom: Responsive.isDesktop(context) ? 24 : 20),
                    Consumer<LoginState>(builder: (context, state, _) {
                      return AuthTextFieldWidget(
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
                    PrimaryButton(
                      text: 'Sign in',
                      textColor: AppColors.white,
                      color: AppColors.accentBlue,
                      borderColor: AppColors.accentBlue,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      textStyle: Responsive.isDesktop(context) ? AppTextStyles.regularPx20.copyWith(color: AppColors.white) : AppTextStyles.regularPx16.copyWith(color: AppColors.white),
                      fullWidth: true,
                      onPress: () {
                        if (context.read<LoginState>().formKey.currentState!.validate()) {
                          // context.read<LoginState>().login();
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
                        context.read<LoginState>().dispose();
                        // AutoRouter.of(context).replace(RegisterRoute());
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
