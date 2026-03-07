import 'dart:convert';
import 'dart:math' as math;

import 'package:intl/intl.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';

List<String>? imagesToBase64(List<FFUploadedFile>? files) {
  // convert images to base64
  if (files == null) {
    return null;
  }

  final List<String> base64Images = [];

  for (final file in files) {
    final bytes = file.bytes;
    final base64 = base64Encode(bytes!);

    base64Images.add(base64);
  }

  return base64Images;
}

DateTime? offerErexpirationDate(DateTime? offerDate) {
  // Add 3 days to the date specified in the parameter `offerDate` using Dart's `DateTime` and output the result in "dd.MM.yyyy" format.
  if (offerDate != null) {
    DateTime newDate = offerDate.add(Duration(days: 3));
    return newDate;
  }
  return null;
}

List<FFUploadedFile>? base64ToImages(List<String>? base64Images) {
  // convert base64 to images
  if (base64Images == null) {
    return null;
  }

  final List<FFUploadedFile> images = [];

  for (final base64Image in base64Images) {
    final bytes = base64.decode(base64Image);
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

    images.add(FFUploadedFile(bytes: bytes, name: fileName));
  }

  return images;
}

FFUploadedFile? base64ToImage(String? base64Image) {
  // convert base64 to image
// convert base64 to image
  if (base64Image == null) {
    return null;
  }

  final bytes = base64.decode(base64Image);
  final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

  return FFUploadedFile(bytes: bytes, name: fileName);
}

String? imageToBase64(FFUploadedFile? file) {
  // convert image to base 64
// convert image to base64
  if (file == null) {
    return null;
  }

  final bytes = file.bytes;
  final base64 = base64Encode(bytes!);

  return base64;
}

List<FFUploadedFile>? base64ToPDFs(List<String>? base64Files) {
  // convert base 64 to PDFs
  if (base64Files == null) return null;

  final List<FFUploadedFile> pdfFiles = [];

  for (final base64File in base64Files) {
    final bytes = base64.decode(base64File);
    pdfFiles.add(FFUploadedFile(
      bytes: bytes,
      name: '${DateTime.now().millisecondsSinceEpoch}.pdf',
    ));
  }

  return pdfFiles;
}

FFUploadedFile? base64ToPDF(String? file) {
  // convert base64 to pdf
  if (file == null) return null;
  final bytes = base64.decode(file);
  return FFUploadedFile(
    bytes: bytes,
    name: '${DateTime.now().millisecondsSinceEpoch}.pdf',
  );
}

UserType? userTypeStringToEnum(String? str) {
  // convert user type string to user type enum
  return deserializeEnum<UserType>(str);
}

List<PropertyStruct>? generateRandomProperties(int? count) {
  if (count == null || count <= 0) {
    return null;
  }

  final math.Random rnd = math.Random();

  // List of property types
  const List<String> propertyTypes = [
    'House',
    'Apartment',
    'Condo',
    'Townhouse',
    'Villa',
    'Cottage'
  ];

  // List of titles
  const List<String> titles = [
    'Beautiful Family Home',
    'Modern Apartment',
    'Luxurious Condo',
    'Cozy Townhouse',
    'Spacious Villa',
    'Charming Cottage'
  ];

  // List of descriptions
  const List<String> descriptions = [
    'A beautiful home located in a quiet neighborhood.',
    'A modern apartment with all the amenities.',
    'A luxurious condo with stunning views.',
    'A cozy townhouse perfect for small families.',
    'A spacious villa with a private pool.',
    'A charming cottage with a large backyard.'
  ];

  // List of free real estate image URLs
  const List<String> imageUrls = [
    'https://images.pexels.com/photos/3288103/pexels-photo-3288103.png',
    'https://images.pexels.com/photos/3935346/pexels-photo-3935346.jpeg',
    'https://images.pexels.com/photos/3935333/pexels-photo-3935333.jpeg',
    'https://images.pexels.com/photos/3958954/pexels-photo-3958954.jpeg',
  ];

  // Helper function to generate random strings
  String getRandomString(List<String> list) {
    return list[rnd.nextInt(list.length)];
  }

  // Helper function to generate random numbers
  int getRandomNumber(int min, int max) {
    return min + rnd.nextInt(max - min + 1);
  }

  // Helper function to get random image URLs
  List<String> getRandomImageUrls(int count) {
    return List.generate(
        count, (_) => imageUrls[rnd.nextInt(imageUrls.length)]);
  }

  List<PropertyStruct> properties = [];
  for (int i = 0; i < count; i++) {
    properties.add(PropertyStruct(
      id: getRandomNumber(1, 1000000).toString(),
      propertyType: getRandomString(propertyTypes),
      title: getRandomString(titles),
      description: getRandomString(descriptions),
      beds: getRandomNumber(1, 5).toString(),
      baths: getRandomNumber(1, 4).toString(),
      sqft: getRandomNumber(500, 5000).toString(),
      price: getRandomNumber(100000, 1000000),
      documents: List.generate(getRandomNumber(1, 5),
          (_) => getRandomString(['Document 1', 'Document 2', 'Document 3'])),
      location: LocationStruct(
        name: getRandomString(['Downtown', 'Suburb', 'Rural Area']),
        latlong:
            LatLng(rnd.nextDouble() * 180 - 90, rnd.nextDouble() * 360 - 180),
      ),
      images: getRandomImageUrls(getRandomNumber(1, 10)),
      isActive: rnd.nextBool(),
    ));
  }
  return properties;
}

String? stringToImagePath(String? imageUrl) {
  if (imageUrl == null) {
    return null;
  }

  return imageUrl;
}

List<MessageStruct>? orderByDate(List<MessageStruct>? messages) {
  // order messages by date in descending order
  if (messages == null || messages.isEmpty) {
    return null;
  }

  messages.sort((a, b) {
    if (a.createdTime == null && b.createdTime == null) return 0;
    if (a.createdTime == null) return 1;
    if (b.createdTime == null) return -1;
    return b.createdTime!.compareTo(a.createdTime!);
  });

  return messages;
}

List<NotificationStruct>? orderByReadNotifications(
    List<NotificationStruct>? notifications) {
  if (notifications == null || notifications.isEmpty) {
    return null;
  }

  final List<NotificationStruct> unread = [];
  final List<NotificationStruct> read = [];

  for (final notification in notifications) {
    if (notification.isRead) {
      read.add(notification);
    } else {
      unread.add(notification);
    }
  }

  unread.addAll(read);

  return unread;
}

bool? hasUnreadNotifications(List<NotificationStruct>? notifications) {
  if (notifications == null || notifications.isEmpty) {
    return false;
  }
  for (final notification in notifications) {
    if (!notification.isRead) {
      return true;
    }
  }
  return false;
}

List<String>? strToList(String? str) {
  // return a list from the string parameter
  if (str == null) {
    return null;
  }
  final List<String> list = [str];
  return list;
}

String? dateToUTC(DateTime? date) {
  if (date == null) return null; // Handle null case

  // Convert the date to UTC and format it as 'yyyy-MM-dd'T'HH:mm:ssZ'
  return DateFormat('yyyy-MM-dd\'T\'HH:mm:ssZ').format(date.toUtc());
}

String? imagePathToStr(String? imagePath) {
  // return image path as string
  if (imagePath == null) {
    return null;
  }

  return imagePath;
}

LatLng? doubleToLatLong(
  double? latitude,
  double? longitude,
) {
  // return longitude and latitude for the passed parameters.
  if (latitude == null || longitude == null) {
    return null;
  }
  return LatLng(latitude, longitude);
}

String? strToInt(int? data) {
  // convert string to integer
  return data?.toString();
}

double percentageToNumber(String percentage) {
  String trimmed = percentage.trim();
  if (trimmed.endsWith('%')) {
    trimmed = trimmed.substring(0, trimmed.length - 1);
  }
  double number = double.parse(trimmed);

  return number / 100;
}

List<String> addStringToList(
  List<String> existingList,
  String newString,
) {
  if (!existingList.contains(newString)) {
    existingList.add(newString);
  }

  return existingList;
}

int parseSquareFootage(String input) {
  // Remove non-numeric characters (commas, spaces, and "sqft")
  final cleanedInput = input.replaceAll(RegExp(r'[^\d.]'), '');

  // Parse the cleaned input as an integer
  try {
    return double.parse(cleanedInput).toInt();
  } catch (e) {
    // Handle any parsing errors (e.g., if the input is not a valid integer)
    print('Error parsing square footage: $e');
    return 0; // Return 0 as a default value
  }
}

List<ImageStruct>? addStrToImage(
  List<String>? images,
  bool hasUrl,
) {
  // add strings to image with true has url
  if (images == null) {
    return null;
  }

  final List<ImageStruct> imageStructs = [];

  for (final String imageUrl in images) {
    imageStructs.add(ImageStruct(
      url: imageUrl,
      hasUrl: hasUrl,
    ));
  }

  return imageStructs;
}

List<FFUploadedFile> removeMediaFromList(
  List<FFUploadedFile>? list,
  FFUploadedFile? media,
) {
  if (list == null || media == null) {
    return list ?? [];
  }

  list.removeWhere((item) => item == media);

  return list;
}

List<String> filterPredictions(List<dynamic> predictions) {
  final validAddresses = predictions
      .where((prediction) {
        final description = prediction['description'] as String;
        final secondary =
            prediction['structured_formatting']['secondary_text'] as String;

        // Check if it's in Texas (TX)
        final isTexas = secondary.contains('TX') || secondary.contains('Texas');

        return isTexas;
      })
      .map((prediction) => prediction['description'] as String)
      .toList();

  return validAddresses;
}

List<String>? mergeUrls(
  List<String>? media1,
  List<String>? media2,
) {
  // merge the lists
  if (media1 == null && media2 == null) {
    return null;
  } else if (media1 == null) {
    return media2;
  } else if (media2 == null) {
    return media1;
  } else {
    return [...media1, ...media2];
  }
}

double? getPosition(
  LatLng? location,
  bool? isLat,
) {
  // return either lat or long depending on isLat flag
  if (location == null) {
    return null;
  }
  return isLat == true ? location.latitude : location.longitude;
}

String getPercentageOfAmount(
  String percentage,
  String amount,
) {
  double value = (double.parse(percentage.replaceAll('%', '')) / 100);
  double newAmount = double.parse(amount.substring(1).replaceAll(',', ''));
  final result = (value * newAmount).toString();
  return '\$$result';
}

List<LatLng> convertToLatLng(List<PropertyDataClassStruct> properties) {
  // return a list of latlng
  return properties
      .map((property) => LatLng(property.latitude, property.longitude))
      .toList();
}

String addCommasToPrice(String propertyPrice) {
  // Parse the property price as a double to handle large numbers
  double price = double.parse(propertyPrice);

  // Format the price with commas and ensure it has two decimal places
  final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
  String formattedPrice = formatter.format(price);

  return formattedPrice;
}

DateTime? offerClosingDate(DateTime? openDate) {
  // Add 30 days to the date specified in the parameter `openDate` using Dart's `DateTime` and output the result in "dd.MM.yyyy" format.
  if (openDate != null) {
    DateTime closingDate = openDate.add(Duration(days: 30));
    return closingDate;
  }
  return null;
}

String? pecentage(
  double? loanType,
  int? purchasePrice,
) {
  // How can I calculate the amount using purchasePrice and the percentage loanType?
  if (loanType != null && purchasePrice != null) {
    double amount = (loanType / 100) * purchasePrice;
    return amount.toStringAsFixed(2);
  } else {
    return null;
  }
}

double? deletePercentage(String? percentege) {
  // Convert a stringpercentege to a double by removing the "%" and parsing the number, resulting in double
  if (percentege == null) {
    return null;
  }

  String cleanedString = percentege.replaceAll('%', '');
  double result = double.tryParse(cleanedString) ?? 0.0;

  return result;
}

String? loanPercentege(
  int? price,
  double? percentege,
) {
  // Calculate price * (percentege / 100) and return the result as a string containing only whole numbers, without decimals.
  if (price != null && percentege != null) {
    int result = (price * (percentege / 100)).round();
    return result.toString();
  }
  return null;
}

List<String>? listOfStringToListOfImagePath(List<String>? listOfStrings) {
  if (listOfStrings == null) {
    return null;
  }

  List<String> listOfImagePaths = [];
  for (String str in listOfStrings) {
    String imagePath = str;
    listOfImagePaths.add(imagePath);
  }

  return listOfImagePaths;
}

String stringToDouble(
  String loanAmount,
  String downPaymentAmount,
) {
  // The sum of the loanAmount and downPaymentAmount
  double loan = double.parse(loanAmount);
  double downPayment = double.parse(downPaymentAmount);
  double sum = loan + downPayment;
  return sum.toString();
}

double? calculateDepositeAmount(int? purschasePrice) {
  // Calculate 1 percent of purchasePrice
  if (purschasePrice != null) {
    return purschasePrice * 0.01;
  } else {
    return null;
  }
}

double convertStringToDouble(String input) {
  // convert string input to double
  try {
    return double.parse(input);
  } catch (e) {
    return 0.0;
  }
}

int? squareFootageTonteger(String? squareFootage) {
  // convert SquareFootage to integer
  if (squareFootage == null) {
    return null;
  }

  // Remove any non-digit characters from the squareFootage string
  String cleanedSquareFootage = squareFootage.replaceAll(RegExp(r'\D'), '');

  // Parse the cleaned squareFootage string to an integer
  int? squareFootageInt = int.tryParse(cleanedSquareFootage);

  return squareFootageInt;
}

String? getInitials(String? name) {
  if (name == null || name.isEmpty) {
    return null;
  }

  List<String> nameParts = name.split(' ');
  String initials = '';

  for (var part in nameParts) {
    if (part.isNotEmpty) {
      initials += part[0];
    }
  }

  return initials;
}

String? deleteDollarSign(String? price) {
  // delete dollar sign $ from string (price)
  if (price != null) {
    return price.replaceAll('\$', '');
  }
  return null;
}

int? doubleToInt(String? value) {
  // string to double
  if (value == null) {
    return null;
  }

  double doubleValue = double.tryParse(value) ?? 0.0;
  return doubleValue.toInt();
}

String? validateImage(String? imageStr) {
  // validate the image if it does have https://maps.googleapis.com/maps/api/streetview? if it doesn't return it if it does return this https://placehold.co/400x400?text=Home
  if (imageStr != null &&
      imageStr.contains('https://maps.googleapis.com/maps/api/streetview?')) {
    return 'https://placehold.co/400x400?text=Home';
  } else {
    return imageStr;
  }
}

PropertyDataClassStruct? findClosestProperty(
  LatLng centerMarkerCoordinate,
  List<PropertyDataClassStruct> properties,
) {
  double calculateDistance(LatLng coord1, LatLng coord2) {
    // Calculate the distance between two coordinates using the Pythagorean theorem
    return math.sqrt(math.pow(coord1.latitude - coord2.latitude, 2) +
        math.pow(coord1.longitude - coord2.longitude, 2));
  }

  // You need a function that compares each property’s coordinates (LatLng) in the list with your centerMarkerCoordinate and returns the closest property. This code calculates the distance between two coordinates and finds the closest property.
  PropertyDataClassStruct? closestProperty;
  double minDistance = double.infinity;

  for (var property in properties) {
    LatLng propertyLocation = LatLng(property.latitude, property.longitude);

    double distance =
        calculateDistance(centerMarkerCoordinate, propertyLocation);
    if (distance < minDistance) {
      minDistance = distance;
      closestProperty = property;
    }
  }

  return closestProperty;
}

PropertyDataClassStruct? getPropertyFromLatLng(
  LatLng? tappedLocation,
  List<PropertyDataClassStruct> properties,
) {
  if (tappedLocation == null || properties.isEmpty) {
    return null;
  }

  final property = properties.firstWhere((property) =>
      property.latitude == tappedLocation.latitude &&
      property.longitude == tappedLocation.longitude);

  return property;
}

String? imagePathFirstItemFromList(List<String>? listOfImages) {
  // receive List of Strings and return to me [0] item as imagePath type
  if (listOfImages != null && listOfImages.isNotEmpty) {
    return listOfImages[0];
  } else {
    return null;
  }
}

String? getCityAndState(
  bool? isCity,
  FFPlace? place,
) {
  if (isCity == true) {
    return place?.city;
  } else {
    return place?.state;
  }
}

String? placeNotEmptyChecker(FFPlace? place) {
  // {"latLng":"0,0","name":"","address":"","city":"","state":"","country":"","zipCode":""} this is empty FFPlace looks like. I want you to check this FFPlace is it empty if yes return empty String if not return zipCode
  if (place == null) {
    return '';
  }

  if (place.latLng.latitude == 0.0 &&
      place.latLng.longitude == 0.0 &&
      place.name.isEmpty &&
      place.address.isEmpty &&
      place.city.isEmpty &&
      place.state.isEmpty &&
      place.country.isEmpty &&
      place.zipCode.isEmpty) {
    return '';
  }

  return place.zipCode;
}

bool? isValidData(dynamic response) {
  if (response is List) {
    return true;
  }

  return false;
}

String? countPropertiesLength(List<PropertyDataClassStruct>? properties) {
  if (properties != null) {
    return properties.length.toString();
  } else {
    return null;
  }
}

double extractLatLong(
  bool isLatitude,
  LatLng location,
) {
  // extract latitude or longitude
  if (isLatitude) {
    return location.latitude;
  } else {
    return location.longitude;
  }
}

MyAddressStruct? extractZipCode(String address) {
// Regular expressions for different parts of the address
  final zipCodeRegExp = RegExp(r'\b\d{5}(?:-\d{4})?\b'); // Matches ZIP code
  final stateCityRegExp =
      RegExp(r', ([a-zA-Z\s]+), ([A-Z]{2})\s'); // Matches city and state
  final streetRegExp = RegExp(r'^(.+?),'); // Matches the street

  // Extract ZIP code
  final zipCodeMatch = zipCodeRegExp.firstMatch(address);
  final zipCode = zipCodeMatch != null ? zipCodeMatch.group(0) : 'Unknown ZIP';

  // Extract city and state
  final stateCityMatch = stateCityRegExp.firstMatch(address);
  final city =
      stateCityMatch != null ? stateCityMatch.group(1) : 'Unknown City';
  final state =
      stateCityMatch != null ? stateCityMatch.group(2) : 'Unknown State';

  // Extract street
  final streetMatch = streetRegExp.firstMatch(address);
  final street = streetMatch != null ? streetMatch.group(1) : 'Unknown Street';

  // Return the MyAddress object
  if (zipCode != 'Unknown ZIP' &&
      city != 'Unknown City' &&
      state != 'Unknown State' &&
      street != 'Unknown Street') {
    return MyAddressStruct(
      streetName: street,
      city: city,
      state: state,
      zip: zipCode,
    );
  } else {
    return null; // If the address couldn't be parsed
  }
}

String formatAddressFromModel(
  AddressDataClassStruct myAddress,
  String? zipCode,
) {
  String capitalizeWords(String input) {
    return input
        .split(' ')
        .map((word) => word.isEmpty
            ? word
            : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  // Format each component of the address
  String formattedStreet = capitalizeWords(myAddress.streetName);
  String formattedCity = capitalizeWords(myAddress.city);
  String formattedState =
      myAddress.state.toUpperCase(); // States are typically in uppercase
  String formattedZipCode = myAddress.zip.contains('null') && zipCode != null
      ? zipCode
      : myAddress.zip;

  // Combine components into a single formatted string
  return '$formattedStreet, $formattedCity, $formattedState $formattedZipCode';
}

int? parseSqtToInt(String? input) {
  // parse input as (1,456 sqft) to integer as 1456
  if (input == null) {
    return null;
  }

  // Remove all non-digit characters from the input string
  String digits = input.replaceAll(RegExp(r'\D+'), '');

  // Parse the remaining string as an integer
  return int.tryParse(digits);
}

String? myHomeChoiceEnumToStr(MyHomeChoice? value) {
  // convert my homes choice from enum to string
  return value?.serialize();
}

DateTime? convertToDateTime(String? dateValue) {
  // convert this "2024-09-27T20:00:00Z" - dateValue to DateTime
  if (dateValue == null) {
    return null;
  }

  try {
    DateTime dateTime = DateTime.parse(dateValue);
    return dateTime;
  } catch (e) {
    return null;
  }
}

DateTime combineDateAndTime(
  DateTime date,
  String timeString,
) {
  // Split the time string (e.g., "9:00 AM")
  List<String> parts = timeString.split(' ');
  List<String> timeParts = parts[0].split(':');

  int hour = int.parse(timeParts[0]);
  int minute = int.parse(timeParts[1]);

  // Convert to 24-hour format if necessary
  if (parts[1].toUpperCase() == "PM" && hour != 12) {
    hour += 12;
  } else if (parts[1].toUpperCase() == "AM" && hour == 12) {
    hour = 0; // Convert "12 AM" to 00:00
  }

  // Combine the parsed time with the given date
  return DateTime(date.year, date.month, date.day, hour, minute);
}

List<dynamic> parseShowingsResponse(dynamic jsonData) {
  if (jsonData == null) return [];

  if (jsonData is List) {
    return List<dynamic>.from(jsonData);
  } else if (jsonData is Map<String, dynamic>) {
    if (jsonData.containsKey("message")) return [];

    return [jsonData];
  }

  return [];
}

String cleanUrl(String url) {
  return url.replaceAll(RegExp(r'^"|"$'), '');
}

bool hasPropertyId(
  List<PropertyDataClassStruct> listOfSavedProperty,
  String propertyId,
) {
  for (final savedProperty in listOfSavedProperty) {
    if (savedProperty.id == propertyId) {
      return true;
    }
  }
  return false;
}

bool? filterListEquals(
  List<PropertyDataClassStruct>? initList,
  List<PropertyDataClassStruct>? filteredList,
) {
  // return if filtered list equals to initList use listEquals from foundation
  if (initList == null || filteredList == null) {
    return null;
  }
  if (filteredList.length != initList.length) return false;
  return filteredList.toSet().containsAll(initList) &&
      initList.toSet().containsAll(filteredList);
}

bool isFilterNull(List<PropertyDataClassStruct>? filteredItems) {
  // return null if filter is null
  return filteredItems == null;
}

bool isDateGreaterThanOrEqualToCurrent(DateTime date) {
  // Get the current datetime
  DateTime now = DateTime.now();

  // Create date-only versions (strip time components)
  DateTime dateOnly = DateTime(date.year, date.month, date.day);
  DateTime nowOnly = DateTime(now.year, now.month, now.day);

  // Compare dates without time
  return dateOnly.isAtSameMomentAs(nowOnly) || dateOnly.isAfter(nowOnly);
}

bool isPayButtonEnabled(DateTime showingDate) {
  final DateTime now = DateTime.now();

  return showingDate.isAfter(now) || showingDate.isAtSameMomentAs(now);
}

bool isEmptyListOrMap(dynamic data) {
  if (data == null) return true;

  if (data is Map) {
    return data.isEmpty;
  } else if (data is List) {
    return data.isEmpty;
  }

  // For other types, you might want to handle differently
  // Here we'll consider them "not empty" by default
  return false;
}

String extractLocation(
  String description,
  bool returnCity,
) {
  try {
    // Split the description by commas
    var parts = description.split(',').map((part) => part.trim()).toList();

    // Remove "USA" if it's the last part
    if (parts.isNotEmpty && parts.last.toUpperCase() == 'USA') {
      parts.removeLast();
    }

    // Return empty string if we don't have enough parts
    if (parts.length < 2) {
      return '';
    }

    // Return the last part (state) or second-to-last part (city)
    // This handles both "City, State" and "...City, State" formats
    if (returnCity) {
      return parts[parts.length - 2];
    } else {
      return parts[parts.length - 1];
    }
  } catch (e) {
    return '';
  }
}

dynamic updateJsonField(
  dynamic jsonData,
  dynamic updateData,
) {
  Map<String, dynamic> data;
  Map<String, dynamic> updates;

  // Handle different input types for original data
  if (jsonData is String) {
    try {
      data = json.decode(jsonData) as Map<String, dynamic>;
    } catch (e) {
      throw ArgumentError('Invalid JSON string for jsonData: $e');
    }
  } else if (jsonData is Map<String, dynamic>) {
    data = Map<String, dynamic>.from(jsonData);
  } else if (jsonData is Map) {
    data = Map<String, dynamic>.from(jsonData);
  } else {
    throw ArgumentError('jsonData must be a JSON string or Map');
  }

  // Handle different input types for update data
  if (updateData is String) {
    try {
      updates = json.decode(updateData) as Map<String, dynamic>;
    } catch (e) {
      throw ArgumentError('Invalid JSON string for updateData: $e');
    }
  } else if (updateData is Map<String, dynamic>) {
    updates = updateData;
  } else if (updateData is Map) {
    updates = Map<String, dynamic>.from(updateData);
  } else {
    throw ArgumentError('updateData must be a JSON string or Map');
  }

  // Update or add all fields from updateData
  data.addAll(updates);

  return data;
}

List<PropertyDataClassStruct> reverseList(List<PropertyDataClassStruct> data) {
  return data.reversed.toList();
}

String getNamePart(
  String fullName,
  bool isFirstName,
) {
  if (fullName.isEmpty) return '';

  List<String> nameParts = fullName.trim().split(RegExp(r'\s+'));

  if (isFirstName) {
    return nameParts.first;
  } else {
    return nameParts.length > 1 ? nameParts.last : '';
  }
}

MemberActivityChoice? memberActivityChoiceToEnum(String value) {
  return deserializeEnum<MemberActivityChoice>(value);
}

Status? statusStringToEnum(String? str) {
  return deserializeEnum<Status>(str);
}

List<MemberStruct>? emptyMemberList() {
  // return empty member list of items.
  return [];
}

List<ImageStruct>? strListToImageList(List<String>? urls) {
  // convert string list to imagelist
  if (urls == null) return null;
  return urls.map((url) => ImageStruct(url: url, hasUrl: true)).toList();
}

List<MemberStruct>? transformMemberData(dynamic jsonData) {
  // Return empty list for null or invalid input
  if (jsonData == null) {
    return [];
  }

  try {
    List<dynamic> apiData;

    // Handle both String and List<dynamic> inputs
    if (jsonData is String) {
      if (jsonData.isEmpty) {
        return [];
      }
      apiData = json.decode(jsonData);
    } else if (jsonData is List) {
      apiData = jsonData;
    } else {
      // Unsupported type
      return [];
    }

    return apiData.map((item) {
      // Add null checks for nested properties
      final firstName = item['firstname']?.toString() ?? '';
      final lastName = item['lastname']?.toString() ?? '';
      final fullName = '$firstName $lastName'.trim();

      return MemberStruct(
        clientID: item['id']?.toString() ?? '',
        agentID: item['agentID']?.toString() ?? '',
        fullName: fullName.isEmpty ? 'Unknown' : fullName,
        email: item['email']?.toString() ?? '',
        id: item['id']?.toString() ?? '',
        photoUrl: '',
        phoneNumber: item['phone']?.toString() ?? '',
      );
    }).toList();
  } catch (e) {
    // Log the error for debugging
    return [];
  }
}

DateTime onDaysChanged(int days) {
  DateTime today = DateTime.now();
  DateTime closingDate = today.add(Duration(days: days));

  return closingDate;
}

int onDateSelected(DateTime? selectedDate) {
  if (selectedDate == null) {
    return 0;
  }

  DateTime today = DateTime.now();
  int daysDifference = selectedDate.difference(today).inDays;

  return daysDifference;
}

String? normalizePhoneNumber(String? phone) {
  if (phone == null || phone.isEmpty) return null;

  // Remove all non-digit characters
  String digits = phone.replaceAll(RegExp(r'[^\d]'), '');

  // Handle empty result
  if (digits.isEmpty) return null;

  // Handle different formats
  if (digits.length == 10) {
    // US number without country code: 2146978938
    return '+1$digits';
  } else if (digits.length == 11 && digits.startsWith('1')) {
    // US number with country code: 12146978938
    return '+$digits';
  } else if (digits.length == 11) {
    // Number with other country code
    return '+$digits';
  } else if (digits.length > 11) {
    // Already has country code, just add +
    return '+$digits';
  }

  // Invalid format
  return null;
}
