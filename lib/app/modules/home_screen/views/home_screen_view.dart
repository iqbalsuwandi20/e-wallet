import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_screen_controller.dart';

class HomeScreenView extends GetView<HomeScreenController> {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("SIMS PPOB"),
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Image.asset(
                "assets/images/logo.png",
                width: screenWidth * 0.08,
                height: screenWidth * 0.08,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: ClipOval(
                  child: Container(
                    width: screenWidth * 0.12,
                    height: screenWidth * 0.12,
                    color: Colors.white,
                    child: Image.asset(
                      "assets/images/profile.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: StreamBuilder<String>(
              stream: controller.getName(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.orange[900],
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.05,
                      horizontal: screenWidth * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat datang,",
                          style: TextStyle(fontSize: screenWidth * 0.05),
                        ),
                        SizedBox(height: 5),
                        Text(
                          snapshot.data!,
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        StreamBuilder<String>(
                          stream: controller.getBalance(),
                          builder: (context, snapshotGetBlance) {
                            if (snapshotGetBlance.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.orange[900],
                                ),
                              );
                            }
                            if (snapshotGetBlance.hasData) {
                              return Container(
                                padding: EdgeInsets.all(screenWidth * 0.05),
                                decoration: BoxDecoration(
                                  color: Colors.red[700],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Saldo anda",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          "Rp.",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: screenWidth * 0.08,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Obx(() => Text(
                                              controller.isBalanceVisible.value
                                                  ? controller.balance.value
                                                      .toStringAsFixed(0)
                                                  : "****",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: screenWidth * 0.08,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          "Lihat Saldo",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        IconButton(
                                          onPressed: () {
                                            controller
                                                .toggleBalanceVisibility();
                                          },
                                          icon: Icon(
                                            controller.isBalanceVisible.value
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            color: Colors.white,
                                            size: screenWidth * 0.05,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Center(
                                child: Text(""),
                              );
                            }
                          },
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        StreamBuilder<List<Map<String, dynamic>>>(
                          stream: controller.getServices(),
                          builder: (context, snapshotGetService) {
                            if (snapshotGetService.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.orange[900],
                                ),
                              );
                            }
                            if (snapshotGetService.hasData) {
                              final services = snapshotGetService.data!;
                              if (services.isEmpty) {
                                return Center(
                                  child: Text("Tidak ada layanan tersedia"),
                                );
                              }
                              return Center(
                                child: Wrap(
                                  spacing: screenWidth * 0.02,
                                  runSpacing: screenHeight * 0.02,
                                  alignment: WrapAlignment.start,
                                  children: services.map((service) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                              Routes.PAYMENT_SCREEN,
                                              arguments: service,
                                            );
                                          },
                                          child: Container(
                                            width: screenWidth * 0.2,
                                            height: screenWidth * 0.2,
                                            padding: EdgeInsets.all(
                                                screenWidth * 0.02),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ClipOval(
                                              child: Image.network(
                                                service['serviceIcon'],
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    color: Colors.red,
                                                    child: Icon(Icons.error,
                                                        color: Colors.white),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          service['serviceName']
                                              .split(' ')
                                              .first,
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              );
                            } else {
                              return Center(
                                child: Text("Tidak ada data layanan"),
                              );
                            }
                          },
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        Text(
                          "Temukan promo menarik",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        StreamBuilder<List<Map<String, String>>>(
                          stream: controller.getImageBanners(),
                          builder: (context, snapshotBanner) {
                            if (snapshotBanner.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: CircularProgressIndicator(
                                backgroundColor: Colors.orange[900],
                              ));
                            }
                            if (snapshotBanner.hasData &&
                                snapshotBanner.data!.isNotEmpty) {
                              return SizedBox(
                                height: screenHeight * 0.2,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshotBanner.data!.length,
                                  itemBuilder: (context, index) {
                                    final banner = snapshotBanner.data![index];
                                    return Container(
                                      margin: EdgeInsets.only(
                                          right: screenWidth * 0.02),
                                      width: screenWidth * 0.8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[300],
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              banner['banner_image']!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Center(
                                  child: Text("Tidak ada promo tersedia"));
                            }
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text("Tidak ada data"),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
