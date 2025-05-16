import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd_store/common/helper/dialog_loading/dialogs_helper.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';

import 'package:wcycle_bd_store/core/config/theme/gap.dart';

final formatter = DateFormat('hh:mm:ss');

class UploadFile extends StatefulWidget {
  const UploadFile(
      {super.key,
      required this.btnTittle,
      required this.fileExtension,
      required this.getPath,
      required this.elvationIcons});
  final String btnTittle;
  final List<String> fileExtension;
  final void Function(File filePath, String fileName) getPath;
  final IconData elvationIcons;

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  String? fileName;
  File? filePath;

  Future<String?> uploadDoc(List<String> extensions) async {
    DialogsLoading.showProgressBar(context);

    final pickFile = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: extensions);
    if (!mounted) return null;
    if (pickFile == null) {
      Navigator.pop(context);
      DialogsLoading.removeMessage(context);
      DialogsLoading.showMessage(context, "File Not picked");
      return null;
    } else {
      setState(() {
        fileName =
            "${formatter.format(DateTime.now())} ${pickFile.files[0].name}";
        filePath = File(pickFile.files[0].path!);
      });

      widget.getPath(filePath!, fileName!);
      Navigator.pop(context);
      return fileName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => uploadDoc(widget.fileExtension),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: Card(
            elevation: 5,
            color: AppColor.kDarkColor,
            shadowColor: Colors.lime,
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.white),
                borderRadius:
                    BorderRadius.all(Radius.elliptical(largeGap, largeGap))),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                    flex: 3,
                    child: (filePath == null)
                        ? SizedBox(
                            height: 42,
                            child: ElevatedButton.icon(
                                onPressed: () =>
                                    uploadDoc(widget.fileExtension),
                                style: ElevatedButton.styleFrom(),
                                iconAlignment: IconAlignment.end,
                                icon: FaIcon(
                                  widget.elvationIcons,
                                  size: 16,
                                  color: AppColor.kSecondColor,
                                ),
                                label: Text(
                                  widget.btnTittle,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )),
                          )
                        : SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: widget.fileExtension[0] == "pdf"
                                ? const Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.filePdf,
                                      size: 100,
                                      color: Colors.red,
                                    ),
                                  )
                                : Image.file(
                                    filePath!,
                                    fit: BoxFit.cover,
                                  ),
                          )),
                Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: AppColor.kPrimaryColor,
                          border: Border(top: BorderSide(color: Colors.white))),
                      child: Text(
                        fileName ?? "No ${widget.btnTittle} Yet",
                        textAlign: TextAlign.center,
                        style: AppFont.bodySmall(context)
                            .copyWith(color: Colors.white),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
