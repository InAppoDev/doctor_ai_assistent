import 'package:auto_route/auto_route.dart';
import 'package:doctor_ai_assistent/core/navigation/app_route_config.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text('Home Page'),
          ),
          ElevatedButton(
            onPressed: () {
              AutoRouter.of(context).push(const RecordRoute());
            },
            child: const Text('Record Page'),
          ),
        ],
      ),
    );
  }
}