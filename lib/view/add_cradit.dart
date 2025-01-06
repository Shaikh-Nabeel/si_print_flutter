import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCredit extends StatefulWidget {
  const AddCredit({super.key});

  @override
  State<AddCredit> createState() => _AddCreditState();
}

class _AddCreditState extends State<AddCredit> {
  final TextEditingController _controller = TextEditingController(); // Controller for TextField

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Icon(Icons.ac_unit_outlined),
                  Text(
                    "SI PRINT",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                "Add Credits",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.brown,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 50,
              width: 380,
              child: TextField(
                controller: _controller, // Connect the TextField to the controller
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: 'Enter your amount',
                  hintText: 'Enter Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 100 Button
                _buildAmountButton("100"),
                // 500 Button
                _buildAmountButton("500"),
                // 1000 Button
                _buildAmountButton("1000"),
              ],
            ),
            SizedBox(height: 30),
            Container(
              height: 45,
              width: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.cyan,
              ),
              child: Center(
                child: Text(
                  "Pay",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.brown,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build buttons for amounts
  Widget _buildAmountButton(String amount) {
    return GestureDetector(
      onTap: () {
        // Update the TextField value when the button is clicked
        _controller.text = amount;
      },
      child: Container(
        height: 35,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            amount,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
