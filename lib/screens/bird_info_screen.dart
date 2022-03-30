import 'package:flutter/material.dart';
import 'package:navigator_app_2/models/bird_model.dart';

class NavigatorBirdInfoScreen extends StatelessWidget {
  final BirdModel birdModel;

  const NavigatorBirdInfoScreen(this.birdModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(birdModel.nameOfBird!),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  image: DecorationImage(
                      image: FileImage(birdModel.imageOfBird),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                birdModel.nameOfBird!,
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 6),
              Text(
                birdModel.describeOfBird!,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 6),
              TextButton(
                onPressed: () {
                  //TODO: - release deleteFunc()
                },
                child: const Text('Delete'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
