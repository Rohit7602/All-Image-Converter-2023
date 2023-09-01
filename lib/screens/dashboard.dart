import 'package:all_in_one_image_converter/Ads_Section/banner_ads.dart';
import 'package:all_in_one_image_converter/helpers/colors.dart';
import 'package:all_in_one_image_converter/helpers/getter_setter.dart';
import 'package:all_in_one_image_converter/main.dart';
import 'package:all_in_one_image_converter/model/data_model.dart';
import 'package:all_in_one_image_converter/screens/convert_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:launch_review/launch_review.dart';

class Dashboardview extends StatefulWidget {
  const Dashboardview({super.key});

  @override
  State<Dashboardview> createState() => _DashboardviewState();
}

class _DashboardviewState extends State<Dashboardview> {
  var dataModel = ListOfImageModel();
  bool isAdshow = false;

  @override
  void initState() {
    initialState();

    super.initState();
  }

  initialState() {
    var getResponse = AdsController.showBannerAd(context).listener.onAdLoaded;
    if (getResponse != null) {
      setState(() {
        isAdshow = true;
      });
    }
    loadAd();
  }

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
            onPressed: null,
            icon: Image.asset(
              "assets/menu.png",
            ),
          ),
        ),
        title: Text(
          "All Image Converter",
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
                initialState();
                // AppServices.shareMyApp();
              },
              icon: Image.asset("assets/share.png"),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.82,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            decoration:
                BoxDecoration(gradient: AppColors.applightGradientColor),
            child: Column(
              children: [
                isAdshow
                    ? SizedBox(
                        height: 60,
                        width: AppServices.getScreenWidth(context),
                        child:
                            AdWidget(ad: AdsController.showBannerAd(context)))
                    : const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Select Any One to Convert",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito()
                      .copyWith(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),

                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, i) => AppServices.addHeight(20),
                    shrinkWrap: true,
                    itemCount: dataModel.listofImageModel.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          AppServices.pushTo(
                              context,
                              ImageConverterView(
                                extensionName:
                                    dataModel.listofImageModel[i].extension,
                              ));
                        },
                        child: Container(
                          height: 120,
                          width: 120,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(2, 8),
                                  color: AppColors.greyColor.withOpacity(0.2),
                                  blurRadius: 5)
                            ],
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            dataModel.listofImageModel[i].image,
                          ),
                        ),
                      );
                    }),
                AppServices.addHeight(30),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   alignment: Alignment.center,
                //   height: 50,
                //   decoration: BoxDecoration(
                //     boxShadow: [
                //       BoxShadow(
                //           offset: const Offset(2, 4),
                //           color: AppColors.greyColor.withOpacity(0.2),
                //           blurRadius: 5)
                //     ],
                //     borderRadius: BorderRadius.circular(10),
                //     color: AppColors.whiteColor,
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       const SizedBox(),
                //       Text(
                //         "Converted Images",
                //         style: GoogleFonts.nunito()
                //             .copyWith(fontWeight: FontWeight.w700),
                //       ),
                //       const Icon(
                //         Icons.arrow_forward_ios_sharp,
                //         size: 20,
                //       )
                //     ],
                //   ),
                // ),
                // AppServices.addHeight(15),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          AppServices.shareMyApp();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(2, 4),
                                    color: AppColors.greyColor.withOpacity(0.2),
                                    blurRadius: 5)
                              ],
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/share2.png",
                                width: 30,
                              ),
                              AppServices.addWidth(10),
                              Text(
                                "Share app",
                                style: GoogleFonts.nunito()
                                    .copyWith(fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    AppServices.addWidth(15),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await LaunchReview.launch(
                            androidAppId: "com.rohitDev.imageconverter",
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(2, 4),
                                    color: AppColors.greyColor.withOpacity(0.2),
                                    blurRadius: 5)
                              ],
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/rate.png",
                                width: 40,
                              ),
                              AppServices.addWidth(10),
                              Text(
                                "Rate us",
                                style: GoogleFonts.nunito()
                                    .copyWith(fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
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
}
