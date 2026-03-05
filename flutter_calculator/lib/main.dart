import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Widget gốc của ứng dụng
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    );
  }
}

/// Trang Calculator
class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  // Controller để lấy dữ liệu từ TextField
  final TextEditingController number1Controller = TextEditingController();
  final TextEditingController number2Controller = TextEditingController();

  double result = 0;

  /// Hàm thực hiện phép toán
  void calculate(String operator) {
    double num1 = double.tryParse(number1Controller.text) ?? 0;
    double num2 = double.tryParse(number2Controller.text) ?? 0;

    setState(() {
      if (operator == '+') {
        result = num1 + num2;
      } else if (operator == '-') {
        result = num1 - num2;
      } else if (operator == '*') {
        result = num1 * num2;
      } else if (operator == '/') {
        result = num2 != 0 ? num1 / num2 : 0;
      }
    });
  }

  //Ô nhập thứ nhất
  Widget _buildFirstInput() {
    return TextField(
      controller: number1Controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Enter first number",
        border: OutlineInputBorder(),
      ),
    );
  }

  //Ô nhập thứ hai
  Widget _buildSecondInput() {
    return TextField(
      controller: number2Controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Enter second number",
        border: OutlineInputBorder(),
      ),
    );
  }

  //Hàng nút phép toán
  Widget _buildOperatorButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton('+'),
        _buildButton('-'),
        _buildButton('*'),
        _buildButton('/'),
      ],
    );
  }

  //Hàm tạo 1 nút dùng chung
  Widget _buildButton(String operator) {
    return ElevatedButton(
      onPressed: () => calculate(operator),
      child: Text(operator),
    );
  }

  //Hiển thị kết quả
  Widget _buildResult() {
    return Text(
      "Result: $result",
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Simple Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildFirstInput(),
            const SizedBox(height: 16),
            _buildSecondInput(),
            const SizedBox(height: 20),
            _buildOperatorButtons(),
            const SizedBox(height: 30),
            _buildResult(),
          ],
        ),
      ),
    );
  }
}
