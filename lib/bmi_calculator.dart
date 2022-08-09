import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String output = "";
  String message = "";

  void calculate() {
    // Show dialog box message if any one field is empty
    if (weightController.text.isEmpty || heightController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Error',
                style: TextStyle(fontSize: 25.0),
              ),
              content: const Text(
                'Please fill the fields',
                style: TextStyle(fontSize: 20.0),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Ok",
                      style: TextStyle(fontSize: 20.0),
                    )),
              ],
            );
          });
    }
    double weight;
    double height;
    double result;

    weight = double.parse(weightController.text);
    height = double.parse(heightController.text);

    result = weight / pow(height, 2);

    // this will round the result in 3 digit after decimal point
    String roundData = result.toStringAsFixed(3);

    setState(() {
      if (result <= 18.5) {
        message = "Underweight";
      } else if (result > 18.5 && result <= 24.9) {
        message = "Normal Weight";
      } else if (result > 25 && result <= 39.9) {
        message = "Overweight";
      } else {
        message = "Obesity";
      }

      output = roundData.toString();
    });

    // Clear the textFields
    weightController.clear();
    heightController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xB32B4865),
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: const Color(0xB3002B5B),
      //   title: Text(
      //     "BMI Calculator",
      //     style:
      //         GoogleFonts.notoSans(fontSize: 34, fontWeight: FontWeight.bold),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Text("BMI Calculator",
                    style: GoogleFonts.notoSans(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: weightController,
                  style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0x4D256D85),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "Enter Weight in (KG)",
                      hintStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: heightController,
                  style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0x4D256D85),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "Enter height in (Meter)",
                      hintStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 55,
                  width: 350,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xB31C3879)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      onPressed: calculate,
                      child: Text(
                        "Calculate",
                        style: GoogleFonts.openSans(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  color: const Color(0xFF002B5B),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Your Result:",
                            style: GoogleFonts.notoSans(
                              fontSize: 34,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            )),
                        Text(output,
                            style: GoogleFonts.notoSans(
                              fontSize: 34,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(message,
                            style: GoogleFonts.notoSans(
                              fontSize: 34,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
