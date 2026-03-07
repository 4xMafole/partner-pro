// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<int> indexOfOffer(
  List<OfferStruct>? listOfOffers,
  OfferStruct? offer,
) async {
  // return the index of the offer in the list of offers
  if (listOfOffers == null || offer == null) {
    return -1;
  }
  for (int i = 0; i < listOfOffers.length; i++) {
    if (listOfOffers[i].id == offer.id) {
      return i;
    }
  }
  return -1;
}
