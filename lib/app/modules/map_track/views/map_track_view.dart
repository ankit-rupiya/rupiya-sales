import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/map_track_controller.dart';

class MapTrackView extends GetView<MapTrackController> {
  const MapTrackView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title of app
        title: const Text("User plot"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: Get.width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: Get.width * .5,
                    child: Obx(
                      () => DropdownButtonFormField(
                          hint: const Text('Select salesman'),
                          items: List.generate(
                              controller.salesmans.length,
                              (index) => DropdownMenuItem<String>(
                                    value: controller.salesmans[index],
                                    child: Text(controller.salesmans[index]),
                                  )),
                          onChanged: (value) {
                            controller.selectedSalesman = value!;
                            controller.getLocationLogs();
                          }),
                    ),
                  ),
                  OutlinedButton(
                      onPressed: () {
                        controller.pickDate(context);
                      },
                      child: const Text('select date'))
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: controller.obx(
                  (_) => GoogleMap(
                    //given camera position
                    initialCameraPosition: controller.kGoogle,
                    // on below line we have given map type
                    mapType: MapType.normal,
                    // specified set of markers below
                    markers: controller.markers,
                    // on below line we have enabled location
                    // myLocationEnabled: true,
                    // myLocationButtonEnabled: true,
                    // on below line we have enabled compass location
                    compassEnabled: true,
                    // on below line we have added polylines
                    polylines: controller.polyline,
                    // displayed google map
                    onMapCreated: (GoogleMapController cc) {
                      controller.mapController.complete(cc);
                    },
                  ),
                  onEmpty: Text(
                    'No record found matching your query',
                    style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(.5)),
                  ),
                  onLoading: const CircularProgressIndicator(),
                  onError: (error) => Text(
                    error ?? 'Something went wrong',
                    style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .error
                            .withOpacity(.5)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
