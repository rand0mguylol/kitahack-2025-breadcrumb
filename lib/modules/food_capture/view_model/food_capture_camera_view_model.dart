import 'dart:io';

import 'package:breadcrumbs/repository/camera/camera_repository.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/utils/alert/alert.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FoodCaptureCameraViewModel extends ChangeNotifier {
  FoodCaptureCameraViewModel({required CameraRepository cameraRepository})
      : _cameraRepository = cameraRepository;

  final CameraRepository _cameraRepository;

  Future<void> onClickCapture(
      CameraController? cameraController, BuildContext context) async {
    if (cameraController == null) return;
    final alert = Alert.of(context);
    try {
      final XFile pictureFile = await cameraController.takePicture();
      final File file = File(pictureFile.path);
      _cameraRepository.file = file;

      if (context.mounted) {
        context.push(Routes.foodCapture.foodCapturePreview);
      }
    } catch (e) {
      if (kDebugMode) {}
      alert.showError("Something went wrong");
    }
  }
}
