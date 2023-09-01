import 'dart:io';
import 'package:all_in_one_image_converter/Ads_Section/banner_ads.dart';
import 'package:all_in_one_image_converter/app_config.dart';
import 'package:all_in_one_image_converter/helpers/colors.dart';
import 'package:all_in_one_image_converter/helpers/getter_setter.dart';
import 'package:all_in_one_image_converter/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image/image.dart' as ig;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:path_provider/path_provider.dart';

class ImageConverterView extends StatefulWidget {
  String extensionName;
  ImageConverterView({required this.extensionName, super.key});

  @override
  State<ImageConverterView> createState() => _ImageConverterViewState();
}

class _ImageConverterViewState extends State<ImageConverterView> {
  bool isLoading = false;
  bool isAdshow = false;

  getInitialState() {
    var addLoad = AdsController.showBannerAd(context).listener.onAdLoaded;
    if (addLoad != null) {
      setState(() {
        isAdshow = true;
      });
    }
  }

  @override
  void initState() {
    getInitialState();
    super.initState();
  }

  File? pickedFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: AppColors.appGradientColor),
        ),
        // elevation: 0,
        backgroundColor: Colors.grey.shade50,
        leading: Container(
          margin: const EdgeInsets.all(6),
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: IconButton(
            onPressed: () {
              AppServices.popView(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.blackColor,
            ),
          ),
        ),
        title: Text(
          "Convert Image to Png",
          style: GoogleFonts.nunito().copyWith(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(6),
            width: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: IconButton(
              onPressed: () {
                print("Ad Loading checker");
                print(AdsController.showBannerAd(context).request);
                AppServices.shareMyApp();
              },
              icon: Image.asset("assets/share.png"),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(gradient: AppColors.applightGradientColor),
          child: Column(
            children: [
              AppServices.addHeight(10),
              Text(
                "Upload Image to Convert",
                style: GoogleFonts.nunito()
                    .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              AppServices.addHeight(15),
              Align(
                alignment: Alignment.topCenter,
                child: pickedFile != null
                    ? Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            height: 240,
                            width: MediaQuery.of(context).size.width - 30,
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor.withOpacity(0.3),
                                border: Border.all(
                                    color:
                                        AppColors.greyColor.withOpacity(0.2)),
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.file(
                              File(pickedFile!.path),
                              fit: BoxFit.contain,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  pickedFile = null;
                                });
                              },
                              child: const Text("Change Image"))
                        ],
                      )
                    : InkWell(
                        onTap: () => pickImageFromGallery(),
                        child: DottedBorder(
                          strokeCap: StrokeCap.round,
                          borderType: BorderType.RRect,
                          dashPattern: const [2, 5],
                          radius: const Radius.circular(10),
                          child: Container(
                            alignment: Alignment.center,
                            height: 170,
                            width: MediaQuery.of(context).size.width - 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Select Image",
                                  style: GoogleFonts.nunito().copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                Image.asset(
                                  "assets/picture.png",
                                  width: 90,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 30,
              ),
              pickedFile != null
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.greyColor.withOpacity(0.5),
                              offset: const Offset(1, 3),
                              blurRadius: 6,
                            )
                          ],
                          gradient: AppColors.buttonGradientColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              backgroundColor: Colors.transparent),
                          onPressed: () {
                            getImage();
                          },
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                    child: CircularProgressIndicator.adaptive(
                                      backgroundColor: AppColors.whiteColor,
                                    ),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: AppColors.whiteColor),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: AppColors.greyColor,
                                                blurRadius: 4)
                                          ]),
                                      child: Image.asset(
                                        "assets/download.png",
                                        width: 30,
                                      ),
                                    ),
                                    AppServices.addWidth(10),
                                    Text(
                                      "Download Image",
                                      style: GoogleFonts.nunito().copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.whiteColor),
                                    ),
                                  ],
                                )),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: isAdshow
          ? SizedBox(
              height: 60,
              width: AppServices.getScreenWidth(context),
              child: AdWidget(ad: AdsController.showBannerAd(context)),
            )
          : const SizedBox(),
    );
  }

  Future pickImageFromGallery() async {
    var image = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        pickedFile = File(image.path);
      });
    }
  }

  Future getImage() async {
    try {
      var file = pickedFile!.readAsBytesSync();

      var img = ig.decodeImage(file.buffer.asUint8List());

      if (img == null) throw Exception();
      print("numChannels: ${img.numChannels}");

      ig.Image img2;
      if (img.numChannels == 4) {
        // The image has an alpha channel
        img2 = ig.Image(
            width: img.width, height: img.height, format: ig.Format.uint1);
        img2.clear(ig.ColorRgb8(
            255, 255, 255)); // clear the image with the color white.
        ig.compositeImage(
            img2, img); // alpha composite the image onto the white background
      } else {
        img2 =
            img; // no alpha channel, no need to put it on a white background;
      }
      var fileName =
          pickedFile!.path.split("/").last.toString().split(".").first;
      final data =
          ig.encodeNamedImage('$fileName${widget.extensionName}', img2);

      print("Data Checker ::; $data");

      final tempdir = await getTemporaryDirectory();
      print("temp dir ${tempdir.path}");

      File directory = File('${tempdir.path}/$fileName${widget.extensionName}');

      await directory.writeAsBytes(data!);

      final params = SaveFileDialogParams(sourceFilePath: directory.path);
      print("FileParams  Checker::: $params");
      final finalPath = await FlutterFileDialog.saveFile(params: params);
      if (finalPath != null) {
        pickedFile = null;
        print('Image saved to disk');
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print(e.toString());

      setState(() {
        isLoading = false;
      });
    }
  }
}
