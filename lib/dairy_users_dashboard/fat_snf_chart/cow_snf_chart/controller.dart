import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:mydairy/export.dart';

final chartFileProvider = StateProvider.autoDispose<File?>((ref) => null);

final exelfilePicProvider = StateNotifierProvider.autoDispose((ref) {
  return ExelFilePicNotifier(ref);
});

class ExelFilePicNotifier extends StateNotifier {
  Ref ref;
  ExelFilePicNotifier(this.ref) : super("Upload");

  // String? fileName;
  Future getPdfAndUpload() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xls', 'xlsx'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        ref.read(chartFileProvider.notifier).state = file;
        state = file.path.split('/').last;
        snackBarMessage(msg: "file Pic $state", color: AppColor.greenClr);
        print("files--> $state");
      } else {
        snackBarMessage(msg: "No file Selected");
        print("No file selected");
      }
    } catch (e) {
      print("::::${e.toString()}");
    }
  }

  @override
  void dispose() {
    state = '';
    super.dispose();
  }
}
