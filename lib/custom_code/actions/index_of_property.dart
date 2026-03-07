// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<int> indexOfProperty(
  List<PropertyStruct>? listOfProperties,
  PropertyStruct? property,
) async {
  // returns index of the property in the list of properties
  if (listOfProperties == null || property == null) {
    return -1;
  }

  for (int i = 0; i < listOfProperties.length; i++) {
    if (listOfProperties[i].id == property.id) {
      return i;
    }
  }

  return -1;
}
