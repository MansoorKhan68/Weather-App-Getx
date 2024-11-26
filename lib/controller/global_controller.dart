import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  // Reactive variables
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;

  // Getters for reactive variables
  bool get isLoading => _isLoading.value;
  double get latitude => _latitude.value;
  double get longitude => _longitude.value;

  @override
  void onInit() {
    super.onInit();
    getLocation();
  }

  // Function to check location permission and fetch coordinates
  Future<void> getLocation() async {
    try {
      // Check if location services are enabled
      bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        // Open location settings for the user
        await Geolocator.openLocationSettings();
        throw Exception("Location services are disabled. Please enable them.");
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Location permissions are denied.");
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          "Location permissions are permanently denied. Please enable them in settings.",
        );
      }

      // Fetch current position
      Position position = await Geolocator.getCurrentPosition();
      _latitude.value = position.latitude;
      _longitude.value = position.longitude;
      _isLoading.value = false;

      // Debug logs (optional)
      print("Latitude: ${_latitude.value}, Longitude: ${_longitude.value}");
    } catch (e) {
      _isLoading.value = false;
      // Log or show an error message
      print("Error getting location: $e");
      Get.snackbar(
        duration: Duration(seconds: 3),
        "Location Error",
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
