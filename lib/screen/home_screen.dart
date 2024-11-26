import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/global_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalController globalController = Get.put(GlobalController());
    return Scaffold(
      appBar: AppBar(title: const Text("Location Example")),
      body: Obx(() {
        if (globalController.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Latitude: ${globalController.latitude}"),
                Text("Longitude: ${globalController.longitude}"),
              ],
            ),
          );
        }
      }),
    );
  }
}
