// Class for the Fee calculation functions.
import 'dart:math';

// Function calculates the total delivery cost
double totalDeliveryFee(double cartValue, double distance, int itemCount,
    String date, String time) {
  double totalDeliveryFee = 0.0;
  const double kMaxDeliveryFee = 15.0;
  const int kMinimumCartValueWithNoDeliveryFee = 100;

  // Case 0:  return 0 if the Cart Value 0 and there is no item to deliver.
  if (cartValue == 0.0 && itemCount == 0.0) {
    return totalDeliveryFee;
  }
  // Case 1: Calculate for CartValue < 100 otherwise returns 0
  if (cartValue < kMinimumCartValueWithNoDeliveryFee) {
    totalDeliveryFee = cartValueSurcharge(cartValue) +
        distanceFee(distance) +
        itemsCountSurcharge(itemCount);

    //Case 1.1: fridayRush
    bool fridayRush = isFridayRush(date, time);
    if (fridayRush) {
      const double kRushMultiplier = 1.1;
      totalDeliveryFee = totalDeliveryFee * kRushMultiplier;
    }
  }
  return min(totalDeliveryFee, kMaxDeliveryFee);
}

// checks if it is friday rush
bool isFridayRush(String date, String time) {
  const num kRushStartTime = 15.0;
  const num kRushEndTime = 19.0;

  num givenTime = num.parse("${time.substring(0, 2)}.${time.substring(3, 5)}");
  bool isFriday = (DateTime.parse(date).weekday == DateTime.friday);
  bool isRushHr = givenTime >= kRushStartTime && givenTime <= kRushEndTime;

  return isFriday && isRushHr;
}

// Function adds surcharge to cart value if necessary
double cartValueSurcharge(double cartValue) {
  const int kMinimumCartValue = 10;
  if (cartValue < kMinimumCartValue) {
    return kMinimumCartValue - cartValue;
  }
  return 0.0;
}

// Function calculates the distance fee
double distanceFee(double distance) {
  const double kBaseFee = 2;
  const int kBaseDistance = 1000;
  const int kAdditionalDistance = 500;

  if (distance < kBaseDistance) {
    return kBaseFee;
  }
  return kBaseFee + ((distance - kBaseDistance) / kAdditionalDistance).ceil();
}

// Function calculates surcharge for food items over 4
double itemsCountSurcharge(int itemsCount) {
  double surcharge = 0;
  const int kMaxNumberOfItemsWithNoSurcharge = 4;
  const double kAdditionalCharge = 0.50;
  if (itemsCount > kMaxNumberOfItemsWithNoSurcharge) {
    surcharge = (itemsCount - kMaxNumberOfItemsWithNoSurcharge) * kAdditionalCharge;
  }
  return surcharge;
}
