import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/transaction_screen_controller.dart';

class TransactionScreenView extends GetView<TransactionScreenController> {
  const TransactionScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transaksi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 2),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_outlined,
            ),
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<String>(
                stream: controller.getBalance(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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
                                "Rp. ${controller.balance.value.toStringAsFixed(0)}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(child: Text(""));
                  }
                },
              ),
              SizedBox(height: 50),
              Text(
                "Transaksi",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 30),
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: controller.getTransactionHistory(),
                builder: (context, snapshotgetTransaction) {
                  if (snapshotgetTransaction.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.orange[900],
                    ));
                  }
                  if (snapshotgetTransaction.hasData &&
                      snapshotgetTransaction.data!.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshotgetTransaction.data!.length,
                      itemBuilder: (context, index) {
                        final transaction = snapshotgetTransaction.data![index];
                        final createdOn =
                            DateTime.parse(transaction['created_on']);
                        Color amountColor;
                        IconData iconData;
                        if (transaction['transaction_type'] == 'TOPUP') {
                          amountColor = Colors.green[900]!;
                          iconData = Icons.add_outlined;
                        } else {
                          amountColor = Colors.red[900]!;
                          iconData = Icons.remove_outlined;
                        }

                        return Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.orange[900]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(iconData, color: amountColor),
                                        Text(
                                          "Rp.${transaction['total_amount']}",
                                          style: TextStyle(
                                            color: amountColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(transaction['description']
                                        .split(' ')
                                        .first),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      DateFormat.yMMMMEEEEd('id_ID')
                                          .format(createdOn),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      DateFormat.jms().format(createdOn),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text("Tidak ada transaksi"));
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
