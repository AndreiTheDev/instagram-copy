// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:camera/camera.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'camera_repository.g.dart';

@riverpod
Future<CameraRepository> cameraRepository(final CameraRepositoryRef ref) async {
  final cameras = await availableCameras();
  final cameraController = CameraController(cameras[0], ResolutionPreset.max);
  await cameraController.initialize();
  return CameraRepository(
    cameraController: cameraController,
    cameras: cameras,
  );
}

class CameraRepository {
  final CameraController cameraController;
  final List<CameraDescription> cameras;
  Timer? _debouncer;

  CameraRepository({required this.cameraController, required this.cameras});

  Future<void> switchCamera() async {
    final currentCamera = cameraController.description.lensDirection;
    if (_debouncer?.isActive ?? false) {
      _debouncer?.cancel();
    }
    _debouncer = Timer(const Duration(milliseconds: 400), () async {
      if (currentCamera == CameraLensDirection.front) {
        await cameraController.setDescription(
          cameras.firstWhere(
            (element) => element.lensDirection == CameraLensDirection.back,
          ),
        );
      } else {
        await cameraController.setDescription(
          cameras.firstWhere(
            (element) => element.lensDirection == CameraLensDirection.front,
          ),
        );
      }
    });
  }

  Future<void> takePicture() async {
    if (!cameraController.value.isTakingPicture) {
      final picture = await cameraController.takePicture();
      print(picture.path);
    }
  }

  Future<void> pauseCamera() async {
    await cameraController.pausePreview();
  }

  Future<void> resumeCamera() async {
    await cameraController.resumePreview();
  }
}
