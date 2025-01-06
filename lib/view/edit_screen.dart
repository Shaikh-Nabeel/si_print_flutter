import 'package:flutter/material.dart';
class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 400,
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
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 40,
                  width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.yellow.shade300,
                ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Edit Document details",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("unit name"),
              ),
                SizedBox(height: 10,),
                Center(
                  child: Container(
                    height: 40,
                    width: 350,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Invoice',
                        hintText: 'Inoice',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Center(
                  child: Container(
                    height: 120,
                    width: 350,
                    child: TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        // labelText: 'SELF',
                        hintText: 'SELF',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Center(
                  child: Container(height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.brown,
                  ),
                    child: Center(child: Text("Update",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
                  ),
                ),
            ],),
          ),
        ),
      ),
    );
  }
}
