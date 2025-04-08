import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/navigation/routes.dart';
import 'package:ecnx_ambient_listening/core/utils/ui_utils.dart';
import 'package:ecnx_ambient_listening/core/widgets/logo_widget.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:ecnx_ambient_listening/features/auth/presentation/widgets/registration_widget/registration_form.dart';
import 'package:ecnx_ambient_listening/features/auth/provider/registration_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterState(),
      builder: (context, _) {
        final pr = context.read<RegisterState>();
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
                        if (Responsive.isDesktop(context))
                          Flexible(flex: 1, child: Container()),
                        Flexible(
                            flex: 2,
                            child: RegistrationFormWidget(
                              onRegisterTap: () async {
                                /// Validate the form and save the data
                                /// If the form is valid, post the data to the server and navigate to the home page
                                /// If the form is invalid, show the error message
                                if (pr.formKey.currentState!.validate()) {
                                  pr.formKey.currentState!.save();
                                  final user = await pr.register();
                                  if (context.mounted && user != null) {
                                    HomeRoute().push(context);
                                  } else {
                                    showToast('Something went wrong',
                                        bgColor: AppColors.error);
                                  }
                                }
                              },
                              onSignInTap: () {
                                /// The dispose method is called to clear the form controller
                                pr.dispose();
                                LoginRoute().push(context);
                              },
                            )),
                        if (Responsive.isDesktop(context))
                          Flexible(flex: 1, child: Container()),
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
      },
    );
  }
}
