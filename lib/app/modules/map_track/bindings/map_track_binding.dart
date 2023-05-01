import 'package:get/get.dart';

import '../controllers/map_track_controller.dart';

class MapTrackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapTrackController>(
      () => MapTrackController(),
    );
  }
}
