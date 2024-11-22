import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:mydairy/export.dart';

import '../../authentication/auth_controller.dart';
import '../../authentication/auth_model.dart';

final qrValuesProvider = StateProvider.autoDispose((ref) => 0);

class QRViewExample extends ConsumerStatefulWidget {
  const QRViewExample({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends ConsumerState<QRViewExample> {
  QRViewController? controller;
  String scanCodes = "";
  bool flash = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Txt.mydairy.tr(),
        actionList: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    flash = !flash;
                    controller?.toggleFlash();
                  });
                },
                icon: Icon(flash == true ? Icons.flash_on : Icons.flash_off)),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(flex: 3, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = MediaQuery.of(context).size.width / 1.3;
    // (MediaQuery.of(context).size.width < 400 ||
    //         MediaQuery.of(context).size.height < 400)
    //     ? 250.0
    //     : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          overlayColor: Colors.black87,
          borderColor: AppColor.appColor,
          borderRadius: 10,
          borderLength: 40,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen(
      (scanData) {
        scanCodes = scanData.code!;

        final data = jsonDecode(scanCodes);

        if (ref.watch(qrValuesProvider) == 0) {
          ref.read(qrLoginProvider).qrLoginFn(QrModel(
              browserId: data['id'].toString(),
              browserName: data['string'].toString()));
          ref.read(qrValuesProvider.notifier).update((state) => 1);
        } else {
          print("value ...1");
        }
      },
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');

    if (!p) {
      openAppSettings();
      snackBarMessage(msg: 'no Permission');
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:mydairy/export.dart';

// final qrValuesProvider = StateProvider.autoDispose((ref) => 0);

// class QRViewExample extends ConsumerStatefulWidget {
//   const QRViewExample({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _QRViewExampleState();
// }

// class _QRViewExampleState extends ConsumerState<QRViewExample> {
//   QRViewController? controller;
//   String scanCodes = "";
//   bool flash = false;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: BarcodeScannerWithZoom());
//   }
// }

// class BarcodeScannerWithZoom extends StatefulWidget {
//   const BarcodeScannerWithZoom({super.key});

//   @override
//   State<BarcodeScannerWithZoom> createState() => _BarcodeScannerWithZoomState();
// }

// class _BarcodeScannerWithZoomState extends State<BarcodeScannerWithZoom> {
//   final MobileScannerController controller = MobileScannerController(
//     torchEnabled: false,
//   );

//   double _zoomFactor = 0.0;

//   Widget _buildZoomScaleSlider() {
//     return ValueListenableBuilder(
//       valueListenable: controller,
//       builder: (context, state, child) {
//         if (!state.isInitialized || !state.isRunning) {
//           return const SizedBox.shrink();
//         }

//         final TextStyle labelStyle = Theme.of(context)
//             .textTheme
//             .headlineMedium!
//             .copyWith(color: Colors.white);

//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: Row(
//             children: [
//               Text(
//                 '0%',
//                 overflow: TextOverflow.fade,
//                 style: labelStyle,
//               ),
//               Expanded(
//                 child: Slider(
//                   value: _zoomFactor,
//                   onChanged: (value) {
//                     setState(() {
//                       _zoomFactor = value;
//                       controller.setZoomScale(value);
//                     });
//                   },
//                 ),
//               ),
//               Text(
//                 '100%',
//                 overflow: TextOverflow.fade,
//                 style: labelStyle,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('With zoom slider')),
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           MobileScanner(
//             controller: controller,
//             fit: BoxFit.contain,
//             errorBuilder: (context, error, child) {
//               // return ScannerErrorWidget(error: error);
//               print("qr error ${error}");
//               return Text('${error}');
//             },
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               alignment: Alignment.bottomCenter,
//               height: 100,
//               color: Colors.black.withOpacity(0.4),
//               child: Column(
//                 children: [
//                   if (!kIsWeb) _buildZoomScaleSlider(),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ToggleFlashlightButton(controller: controller),
//                       StartStopMobileScannerButton(controller: controller),
//                       Expanded(
//                         child: Center(
//                           child: ScannedBarcodeLabel(
//                             barcodes: controller.barcodes,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Future<void> dispose() async {
//     super.dispose();
//     await controller.dispose();
//   }
// }

// class ToggleFlashlightButton extends StatelessWidget {
//   const ToggleFlashlightButton({required this.controller, super.key});

//   final MobileScannerController controller;

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: controller,
//       builder: (context, state, child) {
//         if (!state.isInitialized || !state.isRunning) {
//           return const SizedBox.shrink();
//         }

//         switch (state.torchState) {
//           case TorchState.auto:
//             return IconButton(
//               color: Colors.white,
//               iconSize: 32.0,
//               icon: const Icon(Icons.flash_auto),
//               onPressed: () async {
//                 await controller.toggleTorch();
//               },
//             );
//           case TorchState.off:
//             return IconButton(
//               color: Colors.white,
//               iconSize: 32.0,
//               icon: const Icon(Icons.flash_off),
//               onPressed: () async {
//                 await controller.toggleTorch();
//               },
//             );
//           case TorchState.on:
//             return IconButton(
//               color: Colors.white,
//               iconSize: 32.0,
//               icon: const Icon(Icons.flash_on),
//               onPressed: () async {
//                 await controller.toggleTorch();
//               },
//             );
//           case TorchState.unavailable:
//             return const Icon(
//               Icons.no_flash,
//               color: Colors.grey,
//             );
//         }
//       },
//     );
//   }
// }

// class StartStopMobileScannerButton extends StatelessWidget {
//   const StartStopMobileScannerButton({required this.controller, super.key});

//   final MobileScannerController controller;

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: controller,
//       builder: (context, state, child) {
//         if (!state.isInitialized || !state.isRunning) {
//           return IconButton(
//             color: Colors.white,
//             icon: const Icon(Icons.play_arrow),
//             iconSize: 32.0,
//             onPressed: () async {
//               await controller.start();
//             },
//           );
//         }

//         return IconButton(
//           color: Colors.white,
//           icon: const Icon(Icons.stop),
//           iconSize: 32.0,
//           onPressed: () async {
//             await controller.stop();
//           },
//         );
//       },
//     );
//   }
// }

// class ScannedBarcodeLabel extends StatelessWidget {
//   const ScannedBarcodeLabel({
//     super.key,
//     required this.barcodes,
//   });

//   final Stream<BarcodeCapture> barcodes;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: barcodes,
//       builder: (context, snapshot) {
//         final scannedBarcodes = snapshot.data?.barcodes ?? [];

//         if (scannedBarcodes.isEmpty) {
//           return const Text(
//             'Scan something!',
//             overflow: TextOverflow.fade,
//             style: TextStyle(color: Colors.white),
//           );
//         }

//         return Text(
//           scannedBarcodes.first.displayValue ?? 'No display value.',
//           overflow: TextOverflow.fade,
//           style: const TextStyle(color: Colors.white),
//         );
//       },
//     );
//   }
// }
