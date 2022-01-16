// Class for the Fee calculation functions.
class FeeCalFunctions {
  // Function calculates the total delivery cost
  static double totalDeliveryFee(double cartValue, double distance,
      int itemCount, String date, String time) {
    double totalDeliveryFee = 0.0;
    double maxDeliveryFee = 15.0;
    // return 0 if the Cart Value 0 and there is no item to deliver.
    if (cartValue == 0.0 && itemCount == 0.0) {
      return 0.0;
    }
    // Calculate for CartValue < 100 otherwise returns 0
    if (cartValue < 100) {
      totalDeliveryFee = cartValueSurcharge(cartValue) +
          distanceFee(distance) +
          itemsCountSurcharge(itemCount);
      bool fridayRush = isFridayRush(date, time);

      if (totalDeliveryFee > maxDeliveryFee) {
        return maxDeliveryFee;
      }
      if (fridayRush && totalDeliveryFee < maxDeliveryFee) {
        totalDeliveryFee = totalDeliveryFee * 1.1;
        if (totalDeliveryFee > maxDeliveryFee) {
          return maxDeliveryFee;
        }
        return totalDeliveryFee;
      }
      return totalDeliveryFee;
    }
    return totalDeliveryFee;
  }

// checks if it is friday rush
  static bool isFridayRush(String date, String time) {
    num rushStartTime = 15.0;
    num rushEndTime = 19.0;

    num givenTime =
        num.parse("${time.substring(0, 2)}.${time.substring(3, 5)}");
    bool isFriday = (DateTime.parse(date).weekday == DateTime.friday);
    bool isRushHr = givenTime >= rushStartTime && givenTime <= rushEndTime;

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
    double baseFee = 2;
    num addedFee = 0;
    if (distance < 1000) {
      return 0.0;
    } else if (distance > 1000) {
      if ((distance - 1000) % 500 == 0) {
        addedFee = ((distance - 1000) ~/ 500);
        return baseFee + addedFee;
      } else {
        // one is added for the remainder
        addedFee = ((distance - 1000) ~/ 500) + 1;
        return baseFee + addedFee;
      }
    }
    return baseFee + addedFee;
  }

  // Function calculates surcharge for food items over 4
  static double itemsCountSurcharge(int itemsCount) {
    double surcharge = 0;
    double additionalCharge = 0.50;
    if (itemsCount > 4) {
      surcharge = (itemsCount - 4) * additionalCharge;
      return surcharge;
    }
    return surcharge;
  }
}
