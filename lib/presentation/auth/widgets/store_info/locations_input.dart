import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as https;
import 'package:location/location.dart';
import 'package:wcycle_bd_store/common/helper/dialog_loading/dialogs_helper.dart';
import 'package:wcycle_bd_store/common/widgets/other/reuse_list_tile.dart';
import 'package:wcycle_bd_store/core/config/theme/gap.dart';
import 'package:wcycle_bd_store/core/config/utility/string/app_string.dart';
import 'package:wcycle_bd_store/data/model/local/store_location_model.dart';

class LocationsInput extends StatefulWidget {
  const LocationsInput({super.key, required this.storeLocationFn});

  final void Function(StoreLocationModel stLocModel) storeLocationFn;

  @override
  State<LocationsInput> createState() => _LocationsInputState();
}

class _LocationsInputState extends State<LocationsInput> {
  StoreLocationModel? storeLocModel;

  String get locationImage {
    if (storeLocModel == null) {
      return "";
    }
    final lat = storeLocModel!.lat;
    final lon = storeLocModel!.lon;
    final address = storeLocModel!.address;
    return "https://maps.googleapis.com/maps/api/staticmap?center$lat,$lon=$address&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lon&key=${AppString.kMapApi}";
  }

  void getCurrentLocation() async {
    DialogsLoading.showProgressBar(context);
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lon = locationData.longitude;

    if (lat == null || lon == null) {
      return;
    }

    final uri = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=${AppString.kMapApi}");
    final response = await https.get(uri);
    final resultData = json.decode(response.body);
    final address = resultData["results"][0]["formatted_address"];
    setState(() {
      storeLocModel = StoreLocationModel(lat: lat, lon: lon, address: address);
    });
    widget.storeLocationFn(storeLocModel!);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              ReuseListTile(
                listTitle: "Get Current Locations",
                listIcon: FontAwesomeIcons.mapLocationDot,
                onTap: getCurrentLocation,
              ),
              ReuseListTile(
                listTitle: "Select On Map",
                listIcon: FontAwesomeIcons.locationDot,
                onTap: () => getCurrentLocation,
              ),
            ],
          ),
        ),
        const Gap(mediumGap),
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(border: Border.all(color: Colors.white)),
          child: storeLocModel == null
              ? Image.asset("assets/map/maps.png")
              : Image.network(
                  locationImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
        ),
      ],
    );
  }
}
