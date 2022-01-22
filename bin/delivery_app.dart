import 'dart:io';
import 'package:intl/intl.dart';
import 'fee_calculation_functions.dart' as fee_calculator;

// The variables used to calculate the Fee.
double cartValue = 0.0, distance = 0.0;
int itemCount = 0;

// innitailised to the current date and time.
String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
String time = DateFormat("HH:mm").format(DateTime.now());

void main(List<String> arguments) {
  print("********Welcome to Delivery Fee calculator********\n");

  print("Enter cart value:");
  cartValue = double.parse(stdin.readLineSync()!);

  print("Enter cart distance:");
  distance = double.parse(stdin.readLineSync()!);

  print("Enter Number of Items in your cart:");
  itemCount = int.parse(stdin.readLineSync()!);

  print("Enter date in yyyy-MM-dd format e.g  2021-12-01:");
  date = stdin.readLineSync()!;

  print("Enter date time in HH:mm format e.g 17:00:");
  time = stdin.readLineSync()!;

  double deliveryFeeTotal = fee_calculator.totalDeliveryFee(
      cartValue, distance, itemCount, date, time);
  print("\n\n********DeliveryFeeTotal is $deliveryFeeTotal********");
}
