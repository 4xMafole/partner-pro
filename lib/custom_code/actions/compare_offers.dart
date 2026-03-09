// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Imports other custom actions

/// Compares two offer documents and returns whether they have any differences
/// Returns true if offers are different, false if they are identical
///
/// Usage in FlutterFlow:
/// - Call this before sending update emails to verify changes exist
/// - Returns false if oldOffer is null (creation scenario)
/// - Returns false if both offers are identical (no changes)
/// - Returns true if any tracked fields are different
bool compareOffers(
  dynamic newOffer,
  dynamic oldOffer,
) {
  // If no old offer, this is creation (not an update)
  if (oldOffer == null || oldOffer is! Map || oldOffer.isEmpty) {
    return false;
  }

  // If no new offer data, something is wrong
  if (newOffer == null || newOffer is! Map || newOffer.isEmpty) {
    return false;
  }

  // Helper function to safely compare values
  bool hasChanged(dynamic newValue, dynamic oldValue) {
    // Handle null cases
    if (newValue == null && oldValue == null) return false;
    if (newValue == null || oldValue == null) return true;

    // Convert to strings for comparison to handle type differences
    return newValue.toString() != oldValue.toString();
  }

  // Extract nested data structures
  final newPricing = newOffer['pricing'] ?? {};
  final oldPricing = oldOffer['pricing'] ?? {};

  final newFinancials = newOffer['financials'] ?? {};
  final oldFinancials = oldOffer['financials'] ?? {};

  final newConditions = newOffer['conditions'] ?? {};
  final oldConditions = oldOffer['conditions'] ?? {};

  final newTitleCompany = newOffer['title_company'] ?? {};
  final oldTitleCompany = oldOffer['title_company'] ?? {};

  final newParties = newOffer['parties'] ?? {};
  final oldParties = oldOffer['parties'] ?? {};

  final newBuyer = newParties['buyer'] ?? {};
  final oldBuyer = oldParties['buyer'] ?? {};

  final newSecondBuyer = newParties['second_buyer'] ?? {};
  final oldSecondBuyer = oldParties['second_buyer'] ?? {};

  final newAgent = newParties['agent'] ?? {};
  final oldAgent = oldParties['agent'] ?? {};

  // PRICING FIELDS (2 fields)
  if (hasChanged(newPricing['list_price'], oldPricing['list_price'])) {
    return true;
  }
  if (hasChanged(newPricing['purchase_price'], oldPricing['purchase_price'])) {
    return true;
  }

  // FINANCIAL FIELDS (9 fields)
  if (hasChanged(newFinancials['loan_type'], oldFinancials['loan_type'])) {
    return true;
  }
  if (hasChanged(newFinancials['down_payment_amount'],
      oldFinancials['down_payment_amount'])) {
    return true;
  }
  if (hasChanged(newFinancials['loan_amount'], oldFinancials['loan_amount'])) {
    return true;
  }
  if (hasChanged(
      newFinancials['deposit_amount'], oldFinancials['deposit_amount'])) {
    return true;
  }
  if (hasChanged(
      newFinancials['deposit_type'], oldFinancials['deposit_type'])) {
    return true;
  }
  if (hasChanged(newFinancials['additional_earnest'],
      oldFinancials['additional_earnest'])) {
    return true;
  }
  if (hasChanged(newFinancials['option_fee'], oldFinancials['option_fee'])) {
    return true;
  }
  if (hasChanged(
      newFinancials['credit_request'], oldFinancials['credit_request'])) {
    return true;
  }
  if (hasChanged(
      newFinancials['coverage_amount'], oldFinancials['coverage_amount'])) {
    return true;
  }

  // TIMELINE FIELDS (1 field)
  if (hasChanged(newOffer['closing_date'], oldOffer['closing_date'])) {
    return true;
  }

  // CONDITION FIELDS (3 fields)
  if (hasChanged(newConditions['property_condition'],
      oldConditions['property_condition'])) {
    return true;
  }
  if (hasChanged(
      newConditions['pre_approval'], oldConditions['pre_approval'])) {
    return true;
  }
  if (hasChanged(newConditions['survey'], oldConditions['survey'])) {
    return true;
  }

  // TITLE COMPANY FIELDS (2 fields)
  if (hasChanged(
      newTitleCompany['company_name'], oldTitleCompany['company_name'])) {
    return true;
  }
  if (hasChanged(newTitleCompany['choice'], oldTitleCompany['choice'])) {
    return true;
  }

  // BUYER INFORMATION (3 fields)
  if (hasChanged(newBuyer['name'], oldBuyer['name'])) {
    return true;
  }
  if (hasChanged(newBuyer['phone_number'], oldBuyer['phone_number'])) {
    return true;
  }
  if (hasChanged(newBuyer['email'], oldBuyer['email'])) {
    return true;
  }

  // SECOND BUYER INFORMATION (3 fields)
  if (hasChanged(newSecondBuyer['name'], oldSecondBuyer['name'])) {
    return true;
  }
  if (hasChanged(
      newSecondBuyer['phone_number'], oldSecondBuyer['phone_number'])) {
    return true;
  }
  if (hasChanged(newSecondBuyer['email'], oldSecondBuyer['email'])) {
    return true;
  }

  // AGENT INFORMATION (3 fields)
  if (hasChanged(newAgent['name'], oldAgent['name'])) {
    return true;
  }
  if (hasChanged(newAgent['phone_number'], oldAgent['phone_number'])) {
    return true;
  }
  if (hasChanged(newAgent['email'], oldAgent['email'])) {
    return true;
  }

  // PROPERTY ADDRESS (5 fields)
  final newProperty = newOffer['property'] ?? {};
  final oldProperty = oldOffer['property'] ?? {};
  final newAddress = newProperty['address'] ?? {};
  final oldAddress = oldProperty['address'] ?? {};

  if (hasChanged(newAddress['street_number'], oldAddress['street_number'])) {
    return true;
  }
  if (hasChanged(newAddress['street_name'], oldAddress['street_name'])) {
    return true;
  }
  if (hasChanged(newAddress['city'], oldAddress['city'])) {
    return true;
  }
  if (hasChanged(newAddress['state'], oldAddress['state'])) {
    return true;
  }
  if (hasChanged(newAddress['zip'], oldAddress['zip'])) {
    return true;
  }

  // If we got here, no changes detected
  return false;
}

// OPTIONAL: Enhanced version that returns list of changed fields
Map<String, dynamic> compareOffersDetailed(
  dynamic newOffer,
  dynamic oldOffer,
) {
  // If no old offer, this is creation (not an update)
  if (oldOffer == null || oldOffer is! Map || oldOffer.isEmpty) {
    return {
      'hasChanges': false,
      'isCreation': true,
      'changedFields': [],
      'changeCount': 0,
    };
  }

  // If no new offer data, something is wrong
  if (newOffer == null || newOffer is! Map || newOffer.isEmpty) {
    return {
      'hasChanges': false,
      'isCreation': false,
      'changedFields': [],
      'changeCount': 0,
      'error': 'Invalid new offer data',
    };
  }

  List<String> changedFields = [];

  // Helper function to safely compare values
  bool hasChanged(dynamic newValue, dynamic oldValue, String fieldName) {
    if (newValue == null && oldValue == null) return false;
    if (newValue == null || oldValue == null) {
      changedFields.add(fieldName);
      return true;
    }
    if (newValue.toString() != oldValue.toString()) {
      changedFields.add(fieldName);
      return true;
    }
    return false;
  }

  // Extract nested data structures
  final newPricing = newOffer['pricing'] ?? {};
  final oldPricing = oldOffer['pricing'] ?? {};
  final newFinancials = newOffer['financials'] ?? {};
  final oldFinancials = oldOffer['financials'] ?? {};
  final newConditions = newOffer['conditions'] ?? {};
  final oldConditions = oldOffer['conditions'] ?? {};
  final newTitleCompany = newOffer['title_company'] ?? {};
  final oldTitleCompany = oldOffer['title_company'] ?? {};
  final newParties = newOffer['parties'] ?? {};
  final oldParties = oldOffer['parties'] ?? {};
  final newBuyer = newParties['buyer'] ?? {};
  final oldBuyer = oldParties['buyer'] ?? {};
  final newSecondBuyer = newParties['second_buyer'] ?? {};
  final oldSecondBuyer = oldParties['second_buyer'] ?? {};
  final newAgent = newParties['agent'] ?? {};
  final oldAgent = oldParties['agent'] ?? {};
  final newProperty = newOffer['property'] ?? {};
  final oldProperty = oldOffer['property'] ?? {};
  final newAddress = newProperty['address'] ?? {};
  final oldAddress = oldProperty['address'] ?? {};

  // Check all fields
  hasChanged(newPricing['list_price'], oldPricing['list_price'], 'List Price');
  hasChanged(newPricing['purchase_price'], oldPricing['purchase_price'],
      'Purchase Price');
  hasChanged(
      newFinancials['loan_type'], oldFinancials['loan_type'], 'Loan Type');
  hasChanged(newFinancials['down_payment_amount'],
      oldFinancials['down_payment_amount'], 'Down Payment');
  hasChanged(newFinancials['loan_amount'], oldFinancials['loan_amount'],
      'Loan Amount');
  hasChanged(newFinancials['deposit_amount'], oldFinancials['deposit_amount'],
      'Earnest Money');
  hasChanged(newFinancials['deposit_type'], oldFinancials['deposit_type'],
      'Deposit Type');
  hasChanged(newFinancials['additional_earnest'],
      oldFinancials['additional_earnest'], 'Additional Earnest');
  hasChanged(
      newFinancials['option_fee'], oldFinancials['option_fee'], 'Option Fee');
  hasChanged(newFinancials['credit_request'], oldFinancials['credit_request'],
      'Seller Credit');
  hasChanged(newFinancials['coverage_amount'], oldFinancials['coverage_amount'],
      'Home Warranty');
  hasChanged(
      newOffer['closing_date'], oldOffer['closing_date'], 'Closing Date');
  hasChanged(newConditions['property_condition'],
      oldConditions['property_condition'], 'Property Condition');
  hasChanged(newConditions['pre_approval'], oldConditions['pre_approval'],
      'Pre-Approval');
  hasChanged(newConditions['survey'], oldConditions['survey'], 'Survey');
  hasChanged(newTitleCompany['company_name'], oldTitleCompany['company_name'],
      'Title Company');
  hasChanged(
      newTitleCompany['choice'], oldTitleCompany['choice'], 'Title Fees');
  hasChanged(newBuyer['name'], oldBuyer['name'], 'Buyer Name');
  hasChanged(newBuyer['phone_number'], oldBuyer['phone_number'], 'Buyer Phone');
  hasChanged(newBuyer['email'], oldBuyer['email'], 'Buyer Email');
  hasChanged(
      newSecondBuyer['name'], oldSecondBuyer['name'], 'Second Buyer Name');
  hasChanged(newSecondBuyer['phone_number'], oldSecondBuyer['phone_number'],
      'Second Buyer Phone');
  hasChanged(
      newSecondBuyer['email'], oldSecondBuyer['email'], 'Second Buyer Email');
  hasChanged(newAgent['name'], oldAgent['name'], 'Agent Name');
  hasChanged(newAgent['phone_number'], oldAgent['phone_number'], 'Agent Phone');
  hasChanged(newAgent['email'], oldAgent['email'], 'Agent Email');
  hasChanged(newAddress['street_number'], oldAddress['street_number'],
      'Street Number');
  hasChanged(
      newAddress['street_name'], oldAddress['street_name'], 'Street Name');
  hasChanged(newAddress['city'], oldAddress['city'], 'City');
  hasChanged(newAddress['state'], oldAddress['state'], 'State');
  hasChanged(newAddress['zip'], oldAddress['zip'], 'ZIP Code');

  return {
    'hasChanges': changedFields.isNotEmpty,
    'isCreation': false,
    'changedFields': changedFields,
    'changeCount': changedFields.length,
  };
}
