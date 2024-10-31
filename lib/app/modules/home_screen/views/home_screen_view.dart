import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_screen_controller.dart';

class HomeScreenView extends GetView<HomeScreenController> {
  const HomeScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("SIMS PPOB"),
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Image.asset(
                "assets/images/logo.png",
                width: 30,
                height: 30,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: ClipOval(
                  child: Container(
                    width: 50,
                    height: 50,
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
                    padding: EdgeInsets.only(
                      top: 30,
                      left: 10,
                      right: 10,
                      bottom: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat datang,",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        Text(
                          snapshot.data!,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30),
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
                            if (snapshot.hasData) {
                              return Container(
                                padding: EdgeInsets.all(20),
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
                                            fontSize: 30,
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
                                                fontSize: 30,
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
                                            size: 20,
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
                        SizedBox(height: 30),
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
                                  spacing: 10,
                                  runSpacing: 10,
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
                                            width: 50,
                                            height: 50,
                                            padding: EdgeInsets.all(10),
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
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Temukan promo menarik",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 20),
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
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshotBanner.data!.length,
                                  itemBuilder: (context, index) {
                                    final banner = snapshotBanner.data![index];
                                    return Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      width: 320,
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
