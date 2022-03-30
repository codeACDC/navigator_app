import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:navigator_app_2/models/bird_model.dart';
import 'package:navigator_app_2/navigator_bloc/navigator_post_cubit.dart';

class BirdAddPage extends StatefulWidget {
  BirdAddPage(this.latLng, this.image, {Key? key}) : super(key: key);

  final LatLng latLng;
  File image;
  String? nameOfBird;
  String? describeOfBird;

  @override
  State<BirdAddPage> createState() => _BirdAddPageState();
}

class _BirdAddPageState extends State<BirdAddPage> {
  final _formKey = GlobalKey<FormState>();
  late final FocusNode _focusNode;

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    BirdModel birdModel = BirdModel(
        longitude: widget.latLng.longitude,
        latitude: widget.latLng.latitude,
        describeOfBird: widget.describeOfBird,
        nameOfBird: widget.nameOfBird,
        imageOfBird: widget.image);

    context.read<NavigatorPostCubit>().addNavigatorPost(birdModel);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add bird'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        image: DecorationImage(
                            image: FileImage(widget.image), fit: BoxFit.cover)),
                  ),
                  TextFormField(
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_focusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a bird name!';
                      }
                      if (value.length < 2) {
                        return 'Please enter a longer name!';
                      }
                      return null;
                    },
                    decoration:
                        const InputDecoration(hintText: 'Input bird name'),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      widget.nameOfBird = value!.trim();
                    },
                  ),
                  TextFormField(
                    focusNode: _focusNode,
                    onFieldSubmitted: (_) {
                      _submit();
                    },
                    validator: (description) {
                      if (description!.isEmpty) {
                        return 'Please enter a description!';
                      }
                      if (description.length < 2) {
                        return 'Please enter a longer description';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Input bird description'),
                    textInputAction: TextInputAction.done,
                    onSaved: (value) {
                      widget.describeOfBird = value!.trim();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _submit();
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
