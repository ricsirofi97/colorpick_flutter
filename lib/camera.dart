import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'Controller/camera_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/colorpick_localization.dart';

class CameraPage extends StatefulWidget {

  final CameraDescription camera;

  CameraPage({
  required this.camera,
  });

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late Future<void> _initializeControllerFuture;
  late CameraManager cameraManager;
  void initState() {
    super.initState();
    cameraManager = CameraManager(camera: widget.camera);

    _initializeControllerFuture = cameraManager.initialize();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.camera),
            backgroundColor: Colors.grey,
          ),
          body: FutureBuilder(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(cameraManager.cameraController);
            }
            else{
              return Center(
                  child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          child: Icon(Icons.camera_alt),
          onPressed: () async {
            try {
              await _initializeControllerFuture;

              final path = (await getApplicationDocumentsDirectory()).path + 'profilePicture.png';
              final file = File(path);
              if (file.existsSync()) {
              file.deleteSync();
              }

              final picture = await cameraManager.cameraController.takePicture();
              final pictureFile = File(picture.path);
              await pictureFile.copy(file.path);

              Navigator.pop(context, file);
            }
            catch (e) {
              print(e);
            }
          },
        ),

      );
    }
  }