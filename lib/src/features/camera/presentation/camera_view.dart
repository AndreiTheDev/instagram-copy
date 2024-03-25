import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/exports.dart';
import '../data/camera_repository.dart';

class CameraView extends ConsumerStatefulWidget {
  const CameraView({super.key});

  @override
  ConsumerState<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends ConsumerState<CameraView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      ref.read(cameraRepositoryProvider).requireValue.pauseCamera();
    }
    if (state == AppLifecycleState.resumed) {
      ref.read(cameraRepositoryProvider).requireValue.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Consumer(
          builder: (context, ref, child) {
            final cameraRepository = ref.watch(cameraRepositoryProvider);
            print(cameraRepository);
            return switch (cameraRepository) {
              AsyncData(:final value) => SafeArea(
                  child: Container(
                    color: Colors.black,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CameraPreview(value.cameraController),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          width: MediaQuery.of(context).size.width,
                          child: const Padding(
                            padding: EdgeInsets.all(xsSize),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RowIcon(
                                  icon: Icons.close,
                                ),
                                RowIcon(
                                  icon: Icons.flash_off,
                                ),
                                RowIcon(
                                  icon: Icons.settings,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: MediaQuery.of(context).size.height / 11,
                          child: GestureDetector(
                            onTap: () async {
                              await value.takePicture();
                            },
                            child: AnimatedContainer(
                              padding: EdgeInsets.all(2),
                              duration: const Duration(milliseconds: 600),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(60),
                              ),
                              width: 70,
                              height: 70,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(60),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(xsSize),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                const Text(
                                  'Story',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 3,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await value.switchCamera();
                                  },
                                  child: Transform.rotate(
                                    angle: 90,
                                    child: const RowIcon(
                                      icon: Icons.sync,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              AsyncError(:final error, :final stackTrace) =>
                Center(child: Text(error.toString())),
              _ => const Center(
                  child: CircularProgressIndicator(),
                )
            };
          },
        ),
      ),
    );
  }
}

class RowIcon extends StatelessWidget {
  const RowIcon({
    required this.icon,
    super.key,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: Colors.white,
      size: 32,
      shadows: const [
        Shadow(
          color: Color.fromARGB(85, 0, 0, 0),
          blurRadius: 10,
        ),
      ],
    );
  }
}

// Material(
//                             borderRadius: BorderRadius.circular(60),
//                             child: InkWell(
//                               borderRadius: BorderRadius.circular(60),
//                               customBorder:
//                                   Border.all(color: Colors.transparent),
//                               onTap: () {
//                                 print('object');
//                               },
//                               child: Ink(
//                                 height: 60,
//                                 width: 60,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border: Border.all(
//                                     color: Colors.transparent,
//                                   ),
//                                   borderRadius: BorderRadius.circular(60),
//                                 ),
//                               ),
//                             ),
//                           ),