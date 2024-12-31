import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:doctor_ai_assistent/core/constants/app_colors.dart';
import 'package:doctor_ai_assistent/core/navigation/app_routes.dart';
import 'package:doctor_ai_assistent/core/widgets/logo_widget.dart';
import 'package:doctor_ai_assistent/core/widgets/responsive/responsive_widget.dart';
import 'package:doctor_ai_assistent/features/auth/presentation/widgets/registration_widget/registration_form.dart';
import 'package:doctor_ai_assistent/features/auth/provider/registration_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class RegistrationPage extends StatelessWidget implements AutoRouteWrapper {
  const RegistrationPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterState(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Form(
        key: context.read<RegisterState>().formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  LogoWidget(onTap: () {}),
                ]),
                Row(
                  children: [
                    if (Responsive.isDesktop(context)) Flexible(flex: 1, child: Container()),
                    Flexible(
                        flex: 2,
                        child: ChangeNotifierProvider(
                          create: (context) => context.read<RegisterState>(),
                          child: RegistrationFormWidget(
                            onRegisterTap: () {
                              if (context.read<RegisterState>().formKey.currentState!.validate()) {
                                context.read<RegisterState>().formKey.currentState!.save();
                                context.router.pushNamed(AppRoutes.home);
                              }
                            },
                            onSignInTap: () {
                              context.read<RegisterState>().dispose();
                              context.router.pushNamed(AppRoutes.login);
                            },
                          ),
                        )),
                    if (Responsive.isDesktop(context)) Flexible(flex: 1, child: Container()),
                  ],
                ),
              ],
            ).paddingSymmetric(
              horizontal: Responsive.isDesktop(context) ? 40 : 16,
              vertical: Responsive.isDesktop(context) ? 56 : 24,
            ),
          ),
        ),
      ),
    );
  }
}
