import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBikeCameraPage extends StatefulWidget {
  @override
  AddBikeCameraPageState createState() => AddBikeCameraPageState();
}

class AddBikeCameraPageState extends State<AddBikeCameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      Biike.camera,
      ResolutionPreset.max,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String text = '';
    switch (Get.arguments['type']) {
      case 'bike':
        text = CustomStrings.kPleaseTakeBikePicture.tr;
        break;
      case 'bike license':
        text = CustomStrings.kPleaseTakeRegistrationPicture.tr;
        break;
      case 'number plate':
        text = CustomStrings.kPleaseTakeNumberPlatePicture.tr;
        break;
      case 'driving license back':
        text = CustomStrings.kPleaseTakeNumberPlatePicture.tr;
        break;
      case 'driving license front':
        text = CustomStrings.kPleaseTakeNumberPlatePicture.tr;
        break;
      default:
    }

    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(),
        hasShape: true,
        hasLeading: true,
        onPressedFunc: () {
          Get.back();
        },
        title: Text(
          CustomStrings.kAddBike.tr,
        ),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              decoration: BoxDecoration(color: Colors.grey),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 30.0),
                    child: AspectRatio(
                      aspectRatio: 1 / 0.7,
                      child: ClipRect(
                        child: Transform.scale(
                          scale: _controller.value.aspectRatio / 0.7,
                          child: Center(
                            child: CameraPreview(_controller),
                          ),
                        ),
                      ),
                    ),
                  ),
                  CustomTextButton(
                      width: 100,
                      hasBorder: false,
                      backgroundColor: CustomColors.kBlue,
                      foregroundColor: Colors.white,
                      text: CustomStrings.kTakePicture.tr,
                      onPressedFunc: () async {
                        try {
                          await _initializeControllerFuture;

                          final image = await _controller.takePicture();

                          Get.back(result: image.path);
                        } catch (e) {
                          CommonFunctions.logBiike(error: e.toString());
                        }
                      })
                ],
              ),
            );
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
