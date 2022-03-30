import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navigator_app_2/models/bird_model.dart';

import 'package:navigator_app_2/navigator_bloc/navigator_cubit.dart';
import 'package:navigator_app_2/navigator_bloc/navigator_post_cubit.dart';
import 'package:navigator_app_2/screens/bird_info_screen.dart';

import 'bird_add_screen.dart';

class NavigatorMainPage extends StatelessWidget {
  NavigatorMainPage({Key? key}) : super(key: key);

  final MapController _mapController = MapController();
  File? imageFile;

  Future<void> _pickImage(
      {required LatLng latLong, required BuildContext context}) async {
    final imagePicker = ImagePicker();
    final pickedOfImage = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 41);

    if (pickedOfImage != null) {
      imageFile = File(pickedOfImage.path);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return BirdAddPage(latLong, imageFile!);
          },
        ),
      );
    } else {
      print('Error!');
    }
  }

  List<Marker> _markersBuild(BuildContext context, List<BirdModel> birdPost) {
    List<Marker> markerList = [];

    birdPost.forEach(
          (postElem) {
        markerList.add(
          Marker(
            point: LatLng(postElem.latitude, postElem.longitude),
            width: 55,
            height: 55,
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return NavigatorBirdInfoScreen(postElem);
                    },),);
                },
                child: Container(
                  child: Image.asset('assets/images/bird_icon.png'),
                ),
              );
            },
          ),
        );
      },
    );

    return markerList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<NavigatorCubit, Navigator2State>(
        listener: (previousState, currentState) {
          if (currentState is NavigatorLoaded) {
            _mapController.onReady.then((_) =>
                _mapController.move(
                    LatLng(currentState.latitude, currentState.longitude), 11));
          }
          if (currentState is NavigatorError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'Error, unable to fetch location...',
                style: Theme
                    .of(context)
                    .textTheme
                    .headline5,
              ),
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red.withOpacity(0.6),
            ));
          }
        },
        child: BlocBuilder<NavigatorPostCubit, NavigatorPostState>(
          buildWhen: (previousState, currentState) =>
          (previousState.status != currentState.status),
          builder: (context, navigatorPostState) {
            return FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                onLongPress: (tap, latLong) {
                  _pickImage(latLong: latLong, context: context);
                },
                center: LatLng(0, 0),
                zoom: 13.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                  "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                  attributionBuilder: (_) {
                    return Text("© OpenStreetMap contributors");
                  },
                ),
                MarkerLayerOptions(
                  markers: _markersBuild(context, navigatorPostState.birdPost),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
