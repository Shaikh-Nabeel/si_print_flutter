import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/transaction_controller.dart';

class TransactionView extends StatelessWidget {
  final TransactionController controller = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.transactions.isEmpty) {
          return const Center(child: Text("No transactions found."));
        }

        return ListView.builder(
          itemCount: controller.transactions.length,
          itemBuilder: (context, index) {
            final transaction = controller.transactions[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text("Transaction ID: ${transaction.transactionId}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Amount: ₹${transaction.amount}"),
                    Text("Status: ${transaction.status}"),
                    Text("Date: ${transaction.date}"),
                  ],
                ),
                leading: Icon(
                  transaction.status == "SUCCESS"
                      ? Icons.check_circle
                      : Icons.error,
                  color: transaction.status == "SUCCESS" ? Colors.green : Colors.red,
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.fetchTransactions();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
