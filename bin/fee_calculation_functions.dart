// Class for the Fee calculation functions.
import 'dart:math';

class FeeCalFunctions {
  // Function calculates the total delivery cost
  static double totalDeliveryFee(double cartValue, double distance,
      int itemCount, String date, String time) {

    double totalDeliveryFee = 0.0;
    double kMaxDeliveryFee = 15.0;

    // Case 0:  return 0 if the Cart Value 0 and there is no item to deliver.
    if (cartValue == 0.0 && itemCount == 0.0) {
      return totalDeliveryFee;
    }
    // Case 1: Calculate for CartValue < 100 otherwise returns 0
    if (cartValue < 100) {
      totalDeliveryFee = cartValueSurcharge(cartValue) +
          distanceFee(distance) +
          itemsCountSurcharge(itemCount);

      //Case 1.2: fridayRush && totalDeliveryFee < kMaxDeliveryFee
      bool fridayRush = isFridayRush(date, time);
      if (fridayRush && totalDeliveryFee < kMaxDeliveryFee) {
        totalDeliveryFee = totalDeliveryFee * 1.1;
      }
    }
    return min(totalDeliveryFee, kMaxDeliveryFee);
  }

// checks if it is friday rush
  static bool isFridayRush(String date, String time) {
    num kRushStartTime = 15.0;
    num kRushEndTime = 19.0;

    num givenTime =
        num.parse("${time.substring(0, 2)}.${time.substring(3, 5)}");
    bool isFriday = (DateTime.parse(date).weekday == DateTime.friday);
    bool isRushHr = givenTime >= kRushStartTime && givenTime <= kRushEndTime;

    return isFriday && isRushHr;
  }

  // Function adds surcharge to cart value if necessary
  static double cartValueSurcharge(double cartValue) {
    if (cartValue < 10) {
      return 10 - cartValue;
    }
    return 0.0;
  }

  // Function calculates the distance fee
  static double distanceFee(double distance) {
    double kBaseFee = 2;
    int kBaseDistance = 1000;
    int kAdditionalDistance = 500;

    if (distance < kBaseDistance) {
      return kBaseFee;
    }
    return kBaseFee + ((distance - kBaseDistance)/kAdditionalDistance).ceil();
  }

  // Function calculates surcharge for food items over 4
  static double itemsCountSurcharge(int itemsCount) {
    double surcharge = 0;
    double kAdditionalCharge = 0.50;
    if (itemsCount > 4) {
      surcharge = (itemsCount - 4) * kAdditionalCharge;
      return surcharge;
    }
    return surcharge;
  }
}

