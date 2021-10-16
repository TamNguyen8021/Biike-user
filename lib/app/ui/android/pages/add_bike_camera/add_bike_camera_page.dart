import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
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
      ResolutionPreset.medium,
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
    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        appBar: AppBar(),
        hasShape: true,
        hasLeading: true,
        title: Text(
          CustomStrings.kAddBike.tr,
        ),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Vui lòng chụp mặt sau cà vẹt xe\n(mặt chứa thông tin xe)',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomTextButton(
                          backgroundColor: CustomColors.kBlue,
                          foregroundColor: Colors.white,
                          width: 100,
                          text: 'Chụp',
                          onPressedFunc: () async {
                            try {
                              await _initializeControllerFuture;

                              final image = await _controller.takePicture();

                              Navigator.of(context).pop(
                                image.path
                              );
                            } catch (e) {
                              print(e);
                            }
                          }),
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.grey
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}