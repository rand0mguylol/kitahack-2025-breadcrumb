import 'dart:core';
import 'package:breadcrumbs/modules/food_capture/view_model/food_capture_camera_view_model.dart';
import 'package:breadcrumbs/utils/loading/loading.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:provider/provider.dart';

class FoodCaptureCameraScreen extends StatefulWidget {
  const FoodCaptureCameraScreen(
      {super.key,
      required FoodCaptureCameraViewModel foodCaptureCameraViewModel})
      : _foodCaptureCameraViewModel = foodCaptureCameraViewModel;

  final FoodCaptureCameraViewModel _foodCaptureCameraViewModel;
  @override
  State<FoodCaptureCameraScreen> createState() =>
      _FoodCaptureCameraScreenState();
}

class _FoodCaptureCameraScreenState extends State<FoodCaptureCameraScreen>
    with WidgetsBindingObserver {
  bool _isPermissionGranted = false;
  final imgPicker = ImagePicker();
  late final Future<void> _future;
  CameraController? _cameraController;
  OverlayEntry? overlayEntry = null;

  createOverlay() {
    overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return Container(
        color: Colors.black.withOpacity(0.4),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _future = _requestCameraPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopCamera();
    removeOverlay();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      _startCamera();
    }
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    setState(() {
      _isPermissionGranted = status == PermissionStatus.granted;
    });
  }

  void _startCamera() {
    if (_cameraController != null) {
      _cameraSelected(_cameraController!.description);
    }
  }

  void _stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }

  void _initCameraController(List<CameraDescription> cameras) {
    if (_cameraController != null) {
      return;
    }

    CameraDescription? camera;
    for (var current in cameras) {
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    if (camera != null) {
      _cameraSelected(camera);
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async {
    _cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    await _cameraController!.initialize();
    await _cameraController!.setFlashMode(FlashMode.off);

    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      child: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          return Stack(
            children: [
              if (_isPermissionGranted)
                FutureBuilder<List<CameraDescription>>(
                  future: availableCameras(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _initCameraController(snapshot.data!);
                      return Center(child: CameraPreview(_cameraController!));
                    } else {
                      return const LinearProgressIndicator();
                    }
                  },
                ),
              Scaffold(
                appBar: const CustomAppBar(
                  title: 'Capture',
                ),
                backgroundColor:
                    _isPermissionGranted ? Colors.transparent : null,
                body: _isPermissionGranted
                    ? Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  IconButton(
                                      icon: const Icon(Icons.photo_library,
                                          color: Colors.white),
                                      iconSize: 30.0,
                                      onPressed: () {}
                                      // _selectFromGallery(context, apiService),
                                      ),
                                  SizedBox(
                                    width: 70.0, // Custom width
                                    height: 70.0, // Custom height
                                    child: FloatingActionButton(
                                      onPressed: () async {
                                        final loadingProvider =
                                            Provider.of<LoadingProvider>(
                                                context,
                                                listen: false);
                                        loadingProvider.showLoading();
                                        await widget._foodCaptureCameraViewModel
                                            .onClickCapture(
                                                _cameraController, context);

                                        loadingProvider.hideLoading();
                                      },
                                      // _scanImageFromCamera(apiService),
                                      tooltip: 'Scan text from camera',
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      // Empty container to remove the icon
                                      shape: const CircleBorder(),
                                      // Ensures the button is a circle
                                      elevation: 6.0,
                                      // Custom elevation if needed
                                      highlightElevation: 12.0,
                                      // Elevation when the button is pressed
                                      heroTag: null,
                                      // Ensure each FloatingActionButton has a unique tag if using multiple
                                      mini: false,
                                      // Set to true if you want a smaller button
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.padded,
                                      child:
                                          Container(), // Ensures the button is easier to tap
                                    ),
                                  ),
                                  IconButton(
                                      icon: const Icon(Icons.file_copy,
                                          color: Colors.white),
                                      iconSize: 30.0,
                                      onPressed: () {}
                                      // _uploadFile(context, apiService),
                                      ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 24.0, right: 24.0),
                          child: const Text(
                            'Camera permission denied',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
