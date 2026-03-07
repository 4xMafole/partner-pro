// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ResoFactsStruct extends FFFirebaseStruct {
  ResoFactsStruct({
    bool? hasAttachedProperty,
    String? frontageType,
    String? poolFeatures,
    List<String>? flooring,
    List<String>? foundationDetails,
    String? accessibilityFeatures,
    bool? hasGarage,
    String? hasPetsAllowed,
    String? bodyType,
    String? topography,
    String? landLeaseExpirationDate,
    bool? hasAdditionalParcels,
    String? parkName,
    LivingQuartersStruct? livingQuarters,
    int? taxAssessedValue,
    List<AtAGlanceFactsStruct>? atAGlanceFacts,
    String? offerReviewDate,
    String? horseYN,
    List<String>? view,
    RoomsStruct? rooms,
    String? belowGradeFinishedArea,
    FeesAndDuesStruct? feesAndDues,
    String? cityRegion,
    String? mainLevelBathrooms,
    String? hasPrivatePool,
    String? landLeaseAmount,
    List<String>? waterSource,
    List<String>? exteriorFeatures,
    String? inclusions,
    String? gas,
    String? propertyCondition,
    String? elevationUnits,
    String? exclusions,
    String? mainLevelBedrooms,
    String? numberOfUnitsVacant,
    String? hasWaterfrontView,
    String? bathroomsOneQuarter,
    String? lotSize,
    String? entryLevel,
    String? irrigationWaterRightsAcres,
    String? greenWaterConservation,
    int? stories,
    String? livingArea,
    String? commonWalls,
    String? listingTerms,
    String? otherParking,
    String? associationFee,
    String? marketingType,
    String? greenIndoorAirQuality,
    String? greenSustainability,
    String? livingAreaRangeUnits,
    String? associationPhone,
    String? greenBuildingVerificationType,
    bool? hasAttachedGarage,
    int? bedrooms,
    String? architecturalStyle,
    String? listingId,
    String? structureType,
    List<String>? interiorFeatures,
    String? horseAmenities,
    int? garageParkingCapacity,
    String? developmentStatus,
    String? lotFeatures,
    String? roofType,
    String? compensationBasedOn,
    String? greenEnergyGeneration,
    int? daysOnZillow,
    String? listAOR,
    String? buildingAreaSource,
    String? elementarySchool,
    String? zoningDescription,
    List<String>? constructionMaterials,
    String? fireplaceFeatures,
    String? hoaFeeTotal,
    List<String>? appliances,
    String? builderModel,
    String? bathroomsPartial,
    String? fencing,
    int? yearBuiltEffective,
    String? waterfrontFeatures,
    String? buildingName,
    String? attic,
    String? petsMaxWeight,
    String? specialListingConditions,
    String? storiesTotal,
    String? additionalParcelsDescription,
    bool? canRaiseHorses,
    bool? hasLandLease,
    bool? isNewConstruction,
    bool? waterViewYN,
    String? middleOrJuniorSchool,
    String? lotSizeDimensions,
    String? associationName,
    String? contingency,
    int? yearBuilt,
    String? waterBodyName,
    String? virtualTour,
    int? bathroomsFull,
    String? greenEnergyEfficient,
    String? incomeIncludes,
    String? highSchool,
    String? utilities,
    String? totalActualRent,
    int? parkingCapacity,
    int? taxAnnualAmount,
    String? subdivisionName,
    List<String>? windowFeatures,
    String? ownership,
    String? woodedArea,
    String? middleOrJuniorSchoolDistrict,
    String? associationPhone2,
    String? spaFeatures,
    List<String>? sewer,
    String? frontageLength,
    String? openParkingCapacity,
    String? associationAmenities,
    List<String>? roadSurfaceType,
    List<String>? propertySubType,
    int? coveredParkingCapacity,
    String? foundationArea,
    String? zoning,
    String? hoaFee,
    String? livingAreaRange,
    bool? hasCarport,
    List<String>? parkingFeatures,
    String? cropsIncludedYN,
    String? tenantPays,
    String? parcelNumber,
    int? bathroomsHalf,
    String? otherStructures,
    OtherFactsStruct? otherFacts,
    bool? hasView,
    String? additionalFeeInfo,
    String? securityFeatures,
    int? onMarketDate,
    String? numberOfUnitsInCommunity,
    bool? hasHomeWarranty,
    bool? basementYN,
    String? ownershipType,
    String? doorFeatures,
    AssociationsStruct? associations,
    String? waterView,
    String? aboveGradeFinishedArea,
    String? electric,
    String? cumulativeDaysOnMarket,
    bool? hasOpenParking,
    String? hasElectricOnProperty,
    String? homeType,
    String? municipality,
    int? bathroomsThreeQuarter,
    bool? hasSpa,
    String? basement,
    String? associationFee2,
    bool? hasHeating,
    String? associationName2,
    String? elementarySchoolDistrict,
    String? otherEquipment,
    int? bathrooms,
    String? buildingArea,
    bool? furnished,
    String? vegetation,
    List<String>? patioAndPorchFeatures,
    String? builderName,
    String? highSchoolDistrict,
    String? entryLocation,
    String? laundryFeatures,
    String? buildingFeatures,
    List<String>? heating,
    String? availabilityDate,
    int? carportParkingCapacity,
    String? hasAssociation,
    String? irrigationWaterRightsYN,
    String? associationFeeIncludes,
    String? leaseTerm,
    String? levels,
    String? elevation,
    bool? hasRentControl,
    bool? hasFireplace,
    bool? hasCooling,
    bool? isSeniorCommunity,
    List<String>? cooling,
    List<String>? fireplaces,
    double? bathroomsFloat,
    int? pricePerSquareFoot,
    List<String>? communityFeatures,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _hasAttachedProperty = hasAttachedProperty,
        _frontageType = frontageType,
        _poolFeatures = poolFeatures,
        _flooring = flooring,
        _foundationDetails = foundationDetails,
        _accessibilityFeatures = accessibilityFeatures,
        _hasGarage = hasGarage,
        _hasPetsAllowed = hasPetsAllowed,
        _bodyType = bodyType,
        _topography = topography,
        _landLeaseExpirationDate = landLeaseExpirationDate,
        _hasAdditionalParcels = hasAdditionalParcels,
        _parkName = parkName,
        _livingQuarters = livingQuarters,
        _taxAssessedValue = taxAssessedValue,
        _atAGlanceFacts = atAGlanceFacts,
        _offerReviewDate = offerReviewDate,
        _horseYN = horseYN,
        _view = view,
        _rooms = rooms,
        _belowGradeFinishedArea = belowGradeFinishedArea,
        _feesAndDues = feesAndDues,
        _cityRegion = cityRegion,
        _mainLevelBathrooms = mainLevelBathrooms,
        _hasPrivatePool = hasPrivatePool,
        _landLeaseAmount = landLeaseAmount,
        _waterSource = waterSource,
        _exteriorFeatures = exteriorFeatures,
        _inclusions = inclusions,
        _gas = gas,
        _propertyCondition = propertyCondition,
        _elevationUnits = elevationUnits,
        _exclusions = exclusions,
        _mainLevelBedrooms = mainLevelBedrooms,
        _numberOfUnitsVacant = numberOfUnitsVacant,
        _hasWaterfrontView = hasWaterfrontView,
        _bathroomsOneQuarter = bathroomsOneQuarter,
        _lotSize = lotSize,
        _entryLevel = entryLevel,
        _irrigationWaterRightsAcres = irrigationWaterRightsAcres,
        _greenWaterConservation = greenWaterConservation,
        _stories = stories,
        _livingArea = livingArea,
        _commonWalls = commonWalls,
        _listingTerms = listingTerms,
        _otherParking = otherParking,
        _associationFee = associationFee,
        _marketingType = marketingType,
        _greenIndoorAirQuality = greenIndoorAirQuality,
        _greenSustainability = greenSustainability,
        _livingAreaRangeUnits = livingAreaRangeUnits,
        _associationPhone = associationPhone,
        _greenBuildingVerificationType = greenBuildingVerificationType,
        _hasAttachedGarage = hasAttachedGarage,
        _bedrooms = bedrooms,
        _architecturalStyle = architecturalStyle,
        _listingId = listingId,
        _structureType = structureType,
        _interiorFeatures = interiorFeatures,
        _horseAmenities = horseAmenities,
        _garageParkingCapacity = garageParkingCapacity,
        _developmentStatus = developmentStatus,
        _lotFeatures = lotFeatures,
        _roofType = roofType,
        _compensationBasedOn = compensationBasedOn,
        _greenEnergyGeneration = greenEnergyGeneration,
        _daysOnZillow = daysOnZillow,
        _listAOR = listAOR,
        _buildingAreaSource = buildingAreaSource,
        _elementarySchool = elementarySchool,
        _zoningDescription = zoningDescription,
        _constructionMaterials = constructionMaterials,
        _fireplaceFeatures = fireplaceFeatures,
        _hoaFeeTotal = hoaFeeTotal,
        _appliances = appliances,
        _builderModel = builderModel,
        _bathroomsPartial = bathroomsPartial,
        _fencing = fencing,
        _yearBuiltEffective = yearBuiltEffective,
        _waterfrontFeatures = waterfrontFeatures,
        _buildingName = buildingName,
        _attic = attic,
        _petsMaxWeight = petsMaxWeight,
        _specialListingConditions = specialListingConditions,
        _storiesTotal = storiesTotal,
        _additionalParcelsDescription = additionalParcelsDescription,
        _canRaiseHorses = canRaiseHorses,
        _hasLandLease = hasLandLease,
        _isNewConstruction = isNewConstruction,
        _waterViewYN = waterViewYN,
        _middleOrJuniorSchool = middleOrJuniorSchool,
        _lotSizeDimensions = lotSizeDimensions,
        _associationName = associationName,
        _contingency = contingency,
        _yearBuilt = yearBuilt,
        _waterBodyName = waterBodyName,
        _virtualTour = virtualTour,
        _bathroomsFull = bathroomsFull,
        _greenEnergyEfficient = greenEnergyEfficient,
        _incomeIncludes = incomeIncludes,
        _highSchool = highSchool,
        _utilities = utilities,
        _totalActualRent = totalActualRent,
        _parkingCapacity = parkingCapacity,
        _taxAnnualAmount = taxAnnualAmount,
        _subdivisionName = subdivisionName,
        _windowFeatures = windowFeatures,
        _ownership = ownership,
        _woodedArea = woodedArea,
        _middleOrJuniorSchoolDistrict = middleOrJuniorSchoolDistrict,
        _associationPhone2 = associationPhone2,
        _spaFeatures = spaFeatures,
        _sewer = sewer,
        _frontageLength = frontageLength,
        _openParkingCapacity = openParkingCapacity,
        _associationAmenities = associationAmenities,
        _roadSurfaceType = roadSurfaceType,
        _propertySubType = propertySubType,
        _coveredParkingCapacity = coveredParkingCapacity,
        _foundationArea = foundationArea,
        _zoning = zoning,
        _hoaFee = hoaFee,
        _livingAreaRange = livingAreaRange,
        _hasCarport = hasCarport,
        _parkingFeatures = parkingFeatures,
        _cropsIncludedYN = cropsIncludedYN,
        _tenantPays = tenantPays,
        _parcelNumber = parcelNumber,
        _bathroomsHalf = bathroomsHalf,
        _otherStructures = otherStructures,
        _otherFacts = otherFacts,
        _hasView = hasView,
        _additionalFeeInfo = additionalFeeInfo,
        _securityFeatures = securityFeatures,
        _onMarketDate = onMarketDate,
        _numberOfUnitsInCommunity = numberOfUnitsInCommunity,
        _hasHomeWarranty = hasHomeWarranty,
        _basementYN = basementYN,
        _ownershipType = ownershipType,
        _doorFeatures = doorFeatures,
        _associations = associations,
        _waterView = waterView,
        _aboveGradeFinishedArea = aboveGradeFinishedArea,
        _electric = electric,
        _cumulativeDaysOnMarket = cumulativeDaysOnMarket,
        _hasOpenParking = hasOpenParking,
        _hasElectricOnProperty = hasElectricOnProperty,
        _homeType = homeType,
        _municipality = municipality,
        _bathroomsThreeQuarter = bathroomsThreeQuarter,
        _hasSpa = hasSpa,
        _basement = basement,
        _associationFee2 = associationFee2,
        _hasHeating = hasHeating,
        _associationName2 = associationName2,
        _elementarySchoolDistrict = elementarySchoolDistrict,
        _otherEquipment = otherEquipment,
        _bathrooms = bathrooms,
        _buildingArea = buildingArea,
        _furnished = furnished,
        _vegetation = vegetation,
        _patioAndPorchFeatures = patioAndPorchFeatures,
        _builderName = builderName,
        _highSchoolDistrict = highSchoolDistrict,
        _entryLocation = entryLocation,
        _laundryFeatures = laundryFeatures,
        _buildingFeatures = buildingFeatures,
        _heating = heating,
        _availabilityDate = availabilityDate,
        _carportParkingCapacity = carportParkingCapacity,
        _hasAssociation = hasAssociation,
        _irrigationWaterRightsYN = irrigationWaterRightsYN,
        _associationFeeIncludes = associationFeeIncludes,
        _leaseTerm = leaseTerm,
        _levels = levels,
        _elevation = elevation,
        _hasRentControl = hasRentControl,
        _hasFireplace = hasFireplace,
        _hasCooling = hasCooling,
        _isSeniorCommunity = isSeniorCommunity,
        _cooling = cooling,
        _fireplaces = fireplaces,
        _bathroomsFloat = bathroomsFloat,
        _pricePerSquareFoot = pricePerSquareFoot,
        _communityFeatures = communityFeatures,
        super(firestoreUtilData);

  // "hasAttachedProperty" field.
  bool? _hasAttachedProperty;
  bool get hasAttachedProperty => _hasAttachedProperty ?? false;
  set hasAttachedProperty(bool? val) => _hasAttachedProperty = val;

  bool hasHasAttachedProperty() => _hasAttachedProperty != null;

  // "frontageType" field.
  String? _frontageType;
  String get frontageType => _frontageType ?? '';
  set frontageType(String? val) => _frontageType = val;

  bool hasFrontageType() => _frontageType != null;

  // "poolFeatures" field.
  String? _poolFeatures;
  String get poolFeatures => _poolFeatures ?? '';
  set poolFeatures(String? val) => _poolFeatures = val;

  bool hasPoolFeatures() => _poolFeatures != null;

  // "flooring" field.
  List<String>? _flooring;
  List<String> get flooring => _flooring ?? const [];
  set flooring(List<String>? val) => _flooring = val;

  void updateFlooring(Function(List<String>) updateFn) {
    updateFn(_flooring ??= []);
  }

  bool hasFlooring() => _flooring != null;

  // "foundationDetails" field.
  List<String>? _foundationDetails;
  List<String> get foundationDetails => _foundationDetails ?? const [];
  set foundationDetails(List<String>? val) => _foundationDetails = val;

  void updateFoundationDetails(Function(List<String>) updateFn) {
    updateFn(_foundationDetails ??= []);
  }

  bool hasFoundationDetails() => _foundationDetails != null;

  // "accessibilityFeatures" field.
  String? _accessibilityFeatures;
  String get accessibilityFeatures => _accessibilityFeatures ?? '';
  set accessibilityFeatures(String? val) => _accessibilityFeatures = val;

  bool hasAccessibilityFeatures() => _accessibilityFeatures != null;

  // "hasGarage" field.
  bool? _hasGarage;
  bool get hasGarage => _hasGarage ?? false;
  set hasGarage(bool? val) => _hasGarage = val;

  bool hasHasGarage() => _hasGarage != null;

  // "hasPetsAllowed" field.
  String? _hasPetsAllowed;
  String get hasPetsAllowed => _hasPetsAllowed ?? '';
  set hasPetsAllowed(String? val) => _hasPetsAllowed = val;

  bool hasHasPetsAllowed() => _hasPetsAllowed != null;

  // "bodyType" field.
  String? _bodyType;
  String get bodyType => _bodyType ?? '';
  set bodyType(String? val) => _bodyType = val;

  bool hasBodyType() => _bodyType != null;

  // "topography" field.
  String? _topography;
  String get topography => _topography ?? '';
  set topography(String? val) => _topography = val;

  bool hasTopography() => _topography != null;

  // "landLeaseExpirationDate" field.
  String? _landLeaseExpirationDate;
  String get landLeaseExpirationDate => _landLeaseExpirationDate ?? '';
  set landLeaseExpirationDate(String? val) => _landLeaseExpirationDate = val;

  bool hasLandLeaseExpirationDate() => _landLeaseExpirationDate != null;

  // "hasAdditionalParcels" field.
  bool? _hasAdditionalParcels;
  bool get hasAdditionalParcels => _hasAdditionalParcels ?? false;
  set hasAdditionalParcels(bool? val) => _hasAdditionalParcels = val;

  bool hasHasAdditionalParcels() => _hasAdditionalParcels != null;

  // "parkName" field.
  String? _parkName;
  String get parkName => _parkName ?? '';
  set parkName(String? val) => _parkName = val;

  bool hasParkName() => _parkName != null;

  // "livingQuarters" field.
  LivingQuartersStruct? _livingQuarters;
  LivingQuartersStruct get livingQuarters =>
      _livingQuarters ?? LivingQuartersStruct();
  set livingQuarters(LivingQuartersStruct? val) => _livingQuarters = val;

  void updateLivingQuarters(Function(LivingQuartersStruct) updateFn) {
    updateFn(_livingQuarters ??= LivingQuartersStruct());
  }

  bool hasLivingQuarters() => _livingQuarters != null;

  // "taxAssessedValue" field.
  int? _taxAssessedValue;
  int get taxAssessedValue => _taxAssessedValue ?? 0;
  set taxAssessedValue(int? val) => _taxAssessedValue = val;

  void incrementTaxAssessedValue(int amount) =>
      taxAssessedValue = taxAssessedValue + amount;

  bool hasTaxAssessedValue() => _taxAssessedValue != null;

  // "atAGlanceFacts" field.
  List<AtAGlanceFactsStruct>? _atAGlanceFacts;
  List<AtAGlanceFactsStruct> get atAGlanceFacts => _atAGlanceFacts ?? const [];
  set atAGlanceFacts(List<AtAGlanceFactsStruct>? val) => _atAGlanceFacts = val;

  void updateAtAGlanceFacts(Function(List<AtAGlanceFactsStruct>) updateFn) {
    updateFn(_atAGlanceFacts ??= []);
  }

  bool hasAtAGlanceFacts() => _atAGlanceFacts != null;

  // "offerReviewDate" field.
  String? _offerReviewDate;
  String get offerReviewDate => _offerReviewDate ?? '';
  set offerReviewDate(String? val) => _offerReviewDate = val;

  bool hasOfferReviewDate() => _offerReviewDate != null;

  // "horseYN" field.
  String? _horseYN;
  String get horseYN => _horseYN ?? '';
  set horseYN(String? val) => _horseYN = val;

  bool hasHorseYN() => _horseYN != null;

  // "view" field.
  List<String>? _view;
  List<String> get view => _view ?? const [];
  set view(List<String>? val) => _view = val;

  void updateView(Function(List<String>) updateFn) {
    updateFn(_view ??= []);
  }

  bool hasViewField() => _view != null;

  // "rooms" field.
  RoomsStruct? _rooms;
  RoomsStruct get rooms => _rooms ?? RoomsStruct();
  set rooms(RoomsStruct? val) => _rooms = val;

  void updateRooms(Function(RoomsStruct) updateFn) {
    updateFn(_rooms ??= RoomsStruct());
  }

  bool hasRooms() => _rooms != null;

  // "belowGradeFinishedArea" field.
  String? _belowGradeFinishedArea;
  String get belowGradeFinishedArea => _belowGradeFinishedArea ?? '';
  set belowGradeFinishedArea(String? val) => _belowGradeFinishedArea = val;

  bool hasBelowGradeFinishedArea() => _belowGradeFinishedArea != null;

  // "feesAndDues" field.
  FeesAndDuesStruct? _feesAndDues;
  FeesAndDuesStruct get feesAndDues => _feesAndDues ?? FeesAndDuesStruct();
  set feesAndDues(FeesAndDuesStruct? val) => _feesAndDues = val;

  void updateFeesAndDues(Function(FeesAndDuesStruct) updateFn) {
    updateFn(_feesAndDues ??= FeesAndDuesStruct());
  }

  bool hasFeesAndDues() => _feesAndDues != null;

  // "cityRegion" field.
  String? _cityRegion;
  String get cityRegion => _cityRegion ?? '';
  set cityRegion(String? val) => _cityRegion = val;

  bool hasCityRegion() => _cityRegion != null;

  // "mainLevelBathrooms" field.
  String? _mainLevelBathrooms;
  String get mainLevelBathrooms => _mainLevelBathrooms ?? '';
  set mainLevelBathrooms(String? val) => _mainLevelBathrooms = val;

  bool hasMainLevelBathrooms() => _mainLevelBathrooms != null;

  // "hasPrivatePool" field.
  String? _hasPrivatePool;
  String get hasPrivatePool => _hasPrivatePool ?? '';
  set hasPrivatePool(String? val) => _hasPrivatePool = val;

  bool hasHasPrivatePool() => _hasPrivatePool != null;

  // "landLeaseAmount" field.
  String? _landLeaseAmount;
  String get landLeaseAmount => _landLeaseAmount ?? '';
  set landLeaseAmount(String? val) => _landLeaseAmount = val;

  bool hasLandLeaseAmount() => _landLeaseAmount != null;

  // "waterSource" field.
  List<String>? _waterSource;
  List<String> get waterSource => _waterSource ?? const [];
  set waterSource(List<String>? val) => _waterSource = val;

  void updateWaterSource(Function(List<String>) updateFn) {
    updateFn(_waterSource ??= []);
  }

  bool hasWaterSource() => _waterSource != null;

  // "exteriorFeatures" field.
  List<String>? _exteriorFeatures;
  List<String> get exteriorFeatures => _exteriorFeatures ?? const [];
  set exteriorFeatures(List<String>? val) => _exteriorFeatures = val;

  void updateExteriorFeatures(Function(List<String>) updateFn) {
    updateFn(_exteriorFeatures ??= []);
  }

  bool hasExteriorFeatures() => _exteriorFeatures != null;

  // "inclusions" field.
  String? _inclusions;
  String get inclusions => _inclusions ?? '';
  set inclusions(String? val) => _inclusions = val;

  bool hasInclusions() => _inclusions != null;

  // "gas" field.
  String? _gas;
  String get gas => _gas ?? '';
  set gas(String? val) => _gas = val;

  bool hasGas() => _gas != null;

  // "propertyCondition" field.
  String? _propertyCondition;
  String get propertyCondition => _propertyCondition ?? '';
  set propertyCondition(String? val) => _propertyCondition = val;

  bool hasPropertyCondition() => _propertyCondition != null;

  // "elevationUnits" field.
  String? _elevationUnits;
  String get elevationUnits => _elevationUnits ?? '';
  set elevationUnits(String? val) => _elevationUnits = val;

  bool hasElevationUnits() => _elevationUnits != null;

  // "exclusions" field.
  String? _exclusions;
  String get exclusions => _exclusions ?? '';
  set exclusions(String? val) => _exclusions = val;

  bool hasExclusions() => _exclusions != null;

  // "mainLevelBedrooms" field.
  String? _mainLevelBedrooms;
  String get mainLevelBedrooms => _mainLevelBedrooms ?? '';
  set mainLevelBedrooms(String? val) => _mainLevelBedrooms = val;

  bool hasMainLevelBedrooms() => _mainLevelBedrooms != null;

  // "numberOfUnitsVacant" field.
  String? _numberOfUnitsVacant;
  String get numberOfUnitsVacant => _numberOfUnitsVacant ?? '';
  set numberOfUnitsVacant(String? val) => _numberOfUnitsVacant = val;

  bool hasNumberOfUnitsVacant() => _numberOfUnitsVacant != null;

  // "hasWaterfrontView" field.
  String? _hasWaterfrontView;
  String get hasWaterfrontView => _hasWaterfrontView ?? '';
  set hasWaterfrontView(String? val) => _hasWaterfrontView = val;

  bool hasHasWaterfrontView() => _hasWaterfrontView != null;

  // "bathroomsOneQuarter" field.
  String? _bathroomsOneQuarter;
  String get bathroomsOneQuarter => _bathroomsOneQuarter ?? '';
  set bathroomsOneQuarter(String? val) => _bathroomsOneQuarter = val;

  bool hasBathroomsOneQuarter() => _bathroomsOneQuarter != null;

  // "lotSize" field.
  String? _lotSize;
  String get lotSize => _lotSize ?? '';
  set lotSize(String? val) => _lotSize = val;

  bool hasLotSize() => _lotSize != null;

  // "entryLevel" field.
  String? _entryLevel;
  String get entryLevel => _entryLevel ?? '';
  set entryLevel(String? val) => _entryLevel = val;

  bool hasEntryLevel() => _entryLevel != null;

  // "irrigationWaterRightsAcres" field.
  String? _irrigationWaterRightsAcres;
  String get irrigationWaterRightsAcres => _irrigationWaterRightsAcres ?? '';
  set irrigationWaterRightsAcres(String? val) =>
      _irrigationWaterRightsAcres = val;

  bool hasIrrigationWaterRightsAcres() => _irrigationWaterRightsAcres != null;

  // "greenWaterConservation" field.
  String? _greenWaterConservation;
  String get greenWaterConservation => _greenWaterConservation ?? '';
  set greenWaterConservation(String? val) => _greenWaterConservation = val;

  bool hasGreenWaterConservation() => _greenWaterConservation != null;

  // "stories" field.
  int? _stories;
  int get stories => _stories ?? 0;
  set stories(int? val) => _stories = val;

  void incrementStories(int amount) => stories = stories + amount;

  bool hasStories() => _stories != null;

  // "livingArea" field.
  String? _livingArea;
  String get livingArea => _livingArea ?? '';
  set livingArea(String? val) => _livingArea = val;

  bool hasLivingArea() => _livingArea != null;

  // "commonWalls" field.
  String? _commonWalls;
  String get commonWalls => _commonWalls ?? '';
  set commonWalls(String? val) => _commonWalls = val;

  bool hasCommonWalls() => _commonWalls != null;

  // "listingTerms" field.
  String? _listingTerms;
  String get listingTerms => _listingTerms ?? '';
  set listingTerms(String? val) => _listingTerms = val;

  bool hasListingTerms() => _listingTerms != null;

  // "otherParking" field.
  String? _otherParking;
  String get otherParking => _otherParking ?? '';
  set otherParking(String? val) => _otherParking = val;

  bool hasOtherParking() => _otherParking != null;

  // "associationFee" field.
  String? _associationFee;
  String get associationFee => _associationFee ?? '';
  set associationFee(String? val) => _associationFee = val;

  bool hasAssociationFee() => _associationFee != null;

  // "marketingType" field.
  String? _marketingType;
  String get marketingType => _marketingType ?? '';
  set marketingType(String? val) => _marketingType = val;

  bool hasMarketingType() => _marketingType != null;

  // "greenIndoorAirQuality" field.
  String? _greenIndoorAirQuality;
  String get greenIndoorAirQuality => _greenIndoorAirQuality ?? '';
  set greenIndoorAirQuality(String? val) => _greenIndoorAirQuality = val;

  bool hasGreenIndoorAirQuality() => _greenIndoorAirQuality != null;

  // "greenSustainability" field.
  String? _greenSustainability;
  String get greenSustainability => _greenSustainability ?? '';
  set greenSustainability(String? val) => _greenSustainability = val;

  bool hasGreenSustainability() => _greenSustainability != null;

  // "livingAreaRangeUnits" field.
  String? _livingAreaRangeUnits;
  String get livingAreaRangeUnits => _livingAreaRangeUnits ?? '';
  set livingAreaRangeUnits(String? val) => _livingAreaRangeUnits = val;

  bool hasLivingAreaRangeUnits() => _livingAreaRangeUnits != null;

  // "associationPhone" field.
  String? _associationPhone;
  String get associationPhone => _associationPhone ?? '';
  set associationPhone(String? val) => _associationPhone = val;

  bool hasAssociationPhone() => _associationPhone != null;

  // "greenBuildingVerificationType" field.
  String? _greenBuildingVerificationType;
  String get greenBuildingVerificationType =>
      _greenBuildingVerificationType ?? '';
  set greenBuildingVerificationType(String? val) =>
      _greenBuildingVerificationType = val;

  bool hasGreenBuildingVerificationType() =>
      _greenBuildingVerificationType != null;

  // "hasAttachedGarage" field.
  bool? _hasAttachedGarage;
  bool get hasAttachedGarage => _hasAttachedGarage ?? false;
  set hasAttachedGarage(bool? val) => _hasAttachedGarage = val;

  bool hasHasAttachedGarage() => _hasAttachedGarage != null;

  // "bedrooms" field.
  int? _bedrooms;
  int get bedrooms => _bedrooms ?? 0;
  set bedrooms(int? val) => _bedrooms = val;

  void incrementBedrooms(int amount) => bedrooms = bedrooms + amount;

  bool hasBedrooms() => _bedrooms != null;

  // "architecturalStyle" field.
  String? _architecturalStyle;
  String get architecturalStyle => _architecturalStyle ?? '';
  set architecturalStyle(String? val) => _architecturalStyle = val;

  bool hasArchitecturalStyle() => _architecturalStyle != null;

  // "listingId" field.
  String? _listingId;
  String get listingId => _listingId ?? '';
  set listingId(String? val) => _listingId = val;

  bool hasListingId() => _listingId != null;

  // "structureType" field.
  String? _structureType;
  String get structureType => _structureType ?? '';
  set structureType(String? val) => _structureType = val;

  bool hasStructureType() => _structureType != null;

  // "interiorFeatures" field.
  List<String>? _interiorFeatures;
  List<String> get interiorFeatures => _interiorFeatures ?? const [];
  set interiorFeatures(List<String>? val) => _interiorFeatures = val;

  void updateInteriorFeatures(Function(List<String>) updateFn) {
    updateFn(_interiorFeatures ??= []);
  }

  bool hasInteriorFeatures() => _interiorFeatures != null;

  // "horseAmenities" field.
  String? _horseAmenities;
  String get horseAmenities => _horseAmenities ?? '';
  set horseAmenities(String? val) => _horseAmenities = val;

  bool hasHorseAmenities() => _horseAmenities != null;

  // "garageParkingCapacity" field.
  int? _garageParkingCapacity;
  int get garageParkingCapacity => _garageParkingCapacity ?? 0;
  set garageParkingCapacity(int? val) => _garageParkingCapacity = val;

  void incrementGarageParkingCapacity(int amount) =>
      garageParkingCapacity = garageParkingCapacity + amount;

  bool hasGarageParkingCapacity() => _garageParkingCapacity != null;

  // "developmentStatus" field.
  String? _developmentStatus;
  String get developmentStatus => _developmentStatus ?? '';
  set developmentStatus(String? val) => _developmentStatus = val;

  bool hasDevelopmentStatus() => _developmentStatus != null;

  // "lotFeatures" field.
  String? _lotFeatures;
  String get lotFeatures => _lotFeatures ?? '';
  set lotFeatures(String? val) => _lotFeatures = val;

  bool hasLotFeatures() => _lotFeatures != null;

  // "roofType" field.
  String? _roofType;
  String get roofType => _roofType ?? '';
  set roofType(String? val) => _roofType = val;

  bool hasRoofType() => _roofType != null;

  // "compensationBasedOn" field.
  String? _compensationBasedOn;
  String get compensationBasedOn => _compensationBasedOn ?? '';
  set compensationBasedOn(String? val) => _compensationBasedOn = val;

  bool hasCompensationBasedOn() => _compensationBasedOn != null;

  // "greenEnergyGeneration" field.
  String? _greenEnergyGeneration;
  String get greenEnergyGeneration => _greenEnergyGeneration ?? '';
  set greenEnergyGeneration(String? val) => _greenEnergyGeneration = val;

  bool hasGreenEnergyGeneration() => _greenEnergyGeneration != null;

  // "daysOnZillow" field.
  int? _daysOnZillow;
  int get daysOnZillow => _daysOnZillow ?? 0;
  set daysOnZillow(int? val) => _daysOnZillow = val;

  void incrementDaysOnZillow(int amount) =>
      daysOnZillow = daysOnZillow + amount;

  bool hasDaysOnZillow() => _daysOnZillow != null;

  // "listAOR" field.
  String? _listAOR;
  String get listAOR => _listAOR ?? '';
  set listAOR(String? val) => _listAOR = val;

  bool hasListAOR() => _listAOR != null;

  // "buildingAreaSource" field.
  String? _buildingAreaSource;
  String get buildingAreaSource => _buildingAreaSource ?? '';
  set buildingAreaSource(String? val) => _buildingAreaSource = val;

  bool hasBuildingAreaSource() => _buildingAreaSource != null;

  // "elementarySchool" field.
  String? _elementarySchool;
  String get elementarySchool => _elementarySchool ?? '';
  set elementarySchool(String? val) => _elementarySchool = val;

  bool hasElementarySchool() => _elementarySchool != null;

  // "zoningDescription" field.
  String? _zoningDescription;
  String get zoningDescription => _zoningDescription ?? '';
  set zoningDescription(String? val) => _zoningDescription = val;

  bool hasZoningDescription() => _zoningDescription != null;

  // "constructionMaterials" field.
  List<String>? _constructionMaterials;
  List<String> get constructionMaterials => _constructionMaterials ?? const [];
  set constructionMaterials(List<String>? val) => _constructionMaterials = val;

  void updateConstructionMaterials(Function(List<String>) updateFn) {
    updateFn(_constructionMaterials ??= []);
  }

  bool hasConstructionMaterials() => _constructionMaterials != null;

  // "fireplaceFeatures" field.
  String? _fireplaceFeatures;
  String get fireplaceFeatures => _fireplaceFeatures ?? '';
  set fireplaceFeatures(String? val) => _fireplaceFeatures = val;

  bool hasFireplaceFeatures() => _fireplaceFeatures != null;

  // "hoaFeeTotal" field.
  String? _hoaFeeTotal;
  String get hoaFeeTotal => _hoaFeeTotal ?? '';
  set hoaFeeTotal(String? val) => _hoaFeeTotal = val;

  bool hasHoaFeeTotal() => _hoaFeeTotal != null;

  // "appliances" field.
  List<String>? _appliances;
  List<String> get appliances => _appliances ?? const [];
  set appliances(List<String>? val) => _appliances = val;

  void updateAppliances(Function(List<String>) updateFn) {
    updateFn(_appliances ??= []);
  }

  bool hasAppliances() => _appliances != null;

  // "builderModel" field.
  String? _builderModel;
  String get builderModel => _builderModel ?? '';
  set builderModel(String? val) => _builderModel = val;

  bool hasBuilderModel() => _builderModel != null;

  // "bathroomsPartial" field.
  String? _bathroomsPartial;
  String get bathroomsPartial => _bathroomsPartial ?? '';
  set bathroomsPartial(String? val) => _bathroomsPartial = val;

  bool hasBathroomsPartial() => _bathroomsPartial != null;

  // "fencing" field.
  String? _fencing;
  String get fencing => _fencing ?? '';
  set fencing(String? val) => _fencing = val;

  bool hasFencing() => _fencing != null;

  // "yearBuiltEffective" field.
  int? _yearBuiltEffective;
  int get yearBuiltEffective => _yearBuiltEffective ?? 0;
  set yearBuiltEffective(int? val) => _yearBuiltEffective = val;

  void incrementYearBuiltEffective(int amount) =>
      yearBuiltEffective = yearBuiltEffective + amount;

  bool hasYearBuiltEffective() => _yearBuiltEffective != null;

  // "waterfrontFeatures" field.
  String? _waterfrontFeatures;
  String get waterfrontFeatures => _waterfrontFeatures ?? '';
  set waterfrontFeatures(String? val) => _waterfrontFeatures = val;

  bool hasWaterfrontFeatures() => _waterfrontFeatures != null;

  // "buildingName" field.
  String? _buildingName;
  String get buildingName => _buildingName ?? '';
  set buildingName(String? val) => _buildingName = val;

  bool hasBuildingName() => _buildingName != null;

  // "attic" field.
  String? _attic;
  String get attic => _attic ?? '';
  set attic(String? val) => _attic = val;

  bool hasAttic() => _attic != null;

  // "petsMaxWeight" field.
  String? _petsMaxWeight;
  String get petsMaxWeight => _petsMaxWeight ?? '';
  set petsMaxWeight(String? val) => _petsMaxWeight = val;

  bool hasPetsMaxWeight() => _petsMaxWeight != null;

  // "specialListingConditions" field.
  String? _specialListingConditions;
  String get specialListingConditions => _specialListingConditions ?? '';
  set specialListingConditions(String? val) => _specialListingConditions = val;

  bool hasSpecialListingConditions() => _specialListingConditions != null;

  // "storiesTotal" field.
  String? _storiesTotal;
  String get storiesTotal => _storiesTotal ?? '';
  set storiesTotal(String? val) => _storiesTotal = val;

  bool hasStoriesTotal() => _storiesTotal != null;

  // "additionalParcelsDescription" field.
  String? _additionalParcelsDescription;
  String get additionalParcelsDescription =>
      _additionalParcelsDescription ?? '';
  set additionalParcelsDescription(String? val) =>
      _additionalParcelsDescription = val;

  bool hasAdditionalParcelsDescription() =>
      _additionalParcelsDescription != null;

  // "canRaiseHorses" field.
  bool? _canRaiseHorses;
  bool get canRaiseHorses => _canRaiseHorses ?? false;
  set canRaiseHorses(bool? val) => _canRaiseHorses = val;

  bool hasCanRaiseHorses() => _canRaiseHorses != null;

  // "hasLandLease" field.
  bool? _hasLandLease;
  bool get hasLandLease => _hasLandLease ?? false;
  set hasLandLease(bool? val) => _hasLandLease = val;

  bool hasHasLandLease() => _hasLandLease != null;

  // "isNewConstruction" field.
  bool? _isNewConstruction;
  bool get isNewConstruction => _isNewConstruction ?? false;
  set isNewConstruction(bool? val) => _isNewConstruction = val;

  bool hasIsNewConstruction() => _isNewConstruction != null;

  // "waterViewYN" field.
  bool? _waterViewYN;
  bool get waterViewYN => _waterViewYN ?? false;
  set waterViewYN(bool? val) => _waterViewYN = val;

  bool hasWaterViewYN() => _waterViewYN != null;

  // "middleOrJuniorSchool" field.
  String? _middleOrJuniorSchool;
  String get middleOrJuniorSchool => _middleOrJuniorSchool ?? '';
  set middleOrJuniorSchool(String? val) => _middleOrJuniorSchool = val;

  bool hasMiddleOrJuniorSchool() => _middleOrJuniorSchool != null;

  // "lotSizeDimensions" field.
  String? _lotSizeDimensions;
  String get lotSizeDimensions => _lotSizeDimensions ?? '';
  set lotSizeDimensions(String? val) => _lotSizeDimensions = val;

  bool hasLotSizeDimensions() => _lotSizeDimensions != null;

  // "associationName" field.
  String? _associationName;
  String get associationName => _associationName ?? '';
  set associationName(String? val) => _associationName = val;

  bool hasAssociationName() => _associationName != null;

  // "contingency" field.
  String? _contingency;
  String get contingency => _contingency ?? '';
  set contingency(String? val) => _contingency = val;

  bool hasContingency() => _contingency != null;

  // "yearBuilt" field.
  int? _yearBuilt;
  int get yearBuilt => _yearBuilt ?? 0;
  set yearBuilt(int? val) => _yearBuilt = val;

  void incrementYearBuilt(int amount) => yearBuilt = yearBuilt + amount;

  bool hasYearBuilt() => _yearBuilt != null;

  // "waterBodyName" field.
  String? _waterBodyName;
  String get waterBodyName => _waterBodyName ?? '';
  set waterBodyName(String? val) => _waterBodyName = val;

  bool hasWaterBodyName() => _waterBodyName != null;

  // "virtualTour" field.
  String? _virtualTour;
  String get virtualTour => _virtualTour ?? '';
  set virtualTour(String? val) => _virtualTour = val;

  bool hasVirtualTour() => _virtualTour != null;

  // "bathroomsFull" field.
  int? _bathroomsFull;
  int get bathroomsFull => _bathroomsFull ?? 0;
  set bathroomsFull(int? val) => _bathroomsFull = val;

  void incrementBathroomsFull(int amount) =>
      bathroomsFull = bathroomsFull + amount;

  bool hasBathroomsFull() => _bathroomsFull != null;

  // "greenEnergyEfficient" field.
  String? _greenEnergyEfficient;
  String get greenEnergyEfficient => _greenEnergyEfficient ?? '';
  set greenEnergyEfficient(String? val) => _greenEnergyEfficient = val;

  bool hasGreenEnergyEfficient() => _greenEnergyEfficient != null;

  // "incomeIncludes" field.
  String? _incomeIncludes;
  String get incomeIncludes => _incomeIncludes ?? '';
  set incomeIncludes(String? val) => _incomeIncludes = val;

  bool hasIncomeIncludes() => _incomeIncludes != null;

  // "highSchool" field.
  String? _highSchool;
  String get highSchool => _highSchool ?? '';
  set highSchool(String? val) => _highSchool = val;

  bool hasHighSchool() => _highSchool != null;

  // "utilities" field.
  String? _utilities;
  String get utilities => _utilities ?? '';
  set utilities(String? val) => _utilities = val;

  bool hasUtilities() => _utilities != null;

  // "totalActualRent" field.
  String? _totalActualRent;
  String get totalActualRent => _totalActualRent ?? '';
  set totalActualRent(String? val) => _totalActualRent = val;

  bool hasTotalActualRent() => _totalActualRent != null;

  // "parkingCapacity" field.
  int? _parkingCapacity;
  int get parkingCapacity => _parkingCapacity ?? 0;
  set parkingCapacity(int? val) => _parkingCapacity = val;

  void incrementParkingCapacity(int amount) =>
      parkingCapacity = parkingCapacity + amount;

  bool hasParkingCapacity() => _parkingCapacity != null;

  // "taxAnnualAmount" field.
  int? _taxAnnualAmount;
  int get taxAnnualAmount => _taxAnnualAmount ?? 0;
  set taxAnnualAmount(int? val) => _taxAnnualAmount = val;

  void incrementTaxAnnualAmount(int amount) =>
      taxAnnualAmount = taxAnnualAmount + amount;

  bool hasTaxAnnualAmount() => _taxAnnualAmount != null;

  // "subdivisionName" field.
  String? _subdivisionName;
  String get subdivisionName => _subdivisionName ?? '';
  set subdivisionName(String? val) => _subdivisionName = val;

  bool hasSubdivisionName() => _subdivisionName != null;

  // "windowFeatures" field.
  List<String>? _windowFeatures;
  List<String> get windowFeatures => _windowFeatures ?? const [];
  set windowFeatures(List<String>? val) => _windowFeatures = val;

  void updateWindowFeatures(Function(List<String>) updateFn) {
    updateFn(_windowFeatures ??= []);
  }

  bool hasWindowFeatures() => _windowFeatures != null;

  // "ownership" field.
  String? _ownership;
  String get ownership => _ownership ?? '';
  set ownership(String? val) => _ownership = val;

  bool hasOwnership() => _ownership != null;

  // "woodedArea" field.
  String? _woodedArea;
  String get woodedArea => _woodedArea ?? '';
  set woodedArea(String? val) => _woodedArea = val;

  bool hasWoodedArea() => _woodedArea != null;

  // "middleOrJuniorSchoolDistrict" field.
  String? _middleOrJuniorSchoolDistrict;
  String get middleOrJuniorSchoolDistrict =>
      _middleOrJuniorSchoolDistrict ?? '';
  set middleOrJuniorSchoolDistrict(String? val) =>
      _middleOrJuniorSchoolDistrict = val;

  bool hasMiddleOrJuniorSchoolDistrict() =>
      _middleOrJuniorSchoolDistrict != null;

  // "associationPhone2" field.
  String? _associationPhone2;
  String get associationPhone2 => _associationPhone2 ?? '';
  set associationPhone2(String? val) => _associationPhone2 = val;

  bool hasAssociationPhone2() => _associationPhone2 != null;

  // "spaFeatures" field.
  String? _spaFeatures;
  String get spaFeatures => _spaFeatures ?? '';
  set spaFeatures(String? val) => _spaFeatures = val;

  bool hasSpaFeatures() => _spaFeatures != null;

  // "sewer" field.
  List<String>? _sewer;
  List<String> get sewer => _sewer ?? const [];
  set sewer(List<String>? val) => _sewer = val;

  void updateSewer(Function(List<String>) updateFn) {
    updateFn(_sewer ??= []);
  }

  bool hasSewer() => _sewer != null;

  // "frontageLength" field.
  String? _frontageLength;
  String get frontageLength => _frontageLength ?? '';
  set frontageLength(String? val) => _frontageLength = val;

  bool hasFrontageLength() => _frontageLength != null;

  // "openParkingCapacity" field.
  String? _openParkingCapacity;
  String get openParkingCapacity => _openParkingCapacity ?? '';
  set openParkingCapacity(String? val) => _openParkingCapacity = val;

  bool hasOpenParkingCapacity() => _openParkingCapacity != null;

  // "associationAmenities" field.
  String? _associationAmenities;
  String get associationAmenities => _associationAmenities ?? '';
  set associationAmenities(String? val) => _associationAmenities = val;

  bool hasAssociationAmenities() => _associationAmenities != null;

  // "roadSurfaceType" field.
  List<String>? _roadSurfaceType;
  List<String> get roadSurfaceType => _roadSurfaceType ?? const [];
  set roadSurfaceType(List<String>? val) => _roadSurfaceType = val;

  void updateRoadSurfaceType(Function(List<String>) updateFn) {
    updateFn(_roadSurfaceType ??= []);
  }

  bool hasRoadSurfaceType() => _roadSurfaceType != null;

  // "propertySubType" field.
  List<String>? _propertySubType;
  List<String> get propertySubType => _propertySubType ?? const [];
  set propertySubType(List<String>? val) => _propertySubType = val;

  void updatePropertySubType(Function(List<String>) updateFn) {
    updateFn(_propertySubType ??= []);
  }

  bool hasPropertySubType() => _propertySubType != null;

  // "coveredParkingCapacity" field.
  int? _coveredParkingCapacity;
  int get coveredParkingCapacity => _coveredParkingCapacity ?? 0;
  set coveredParkingCapacity(int? val) => _coveredParkingCapacity = val;

  void incrementCoveredParkingCapacity(int amount) =>
      coveredParkingCapacity = coveredParkingCapacity + amount;

  bool hasCoveredParkingCapacity() => _coveredParkingCapacity != null;

  // "foundationArea" field.
  String? _foundationArea;
  String get foundationArea => _foundationArea ?? '';
  set foundationArea(String? val) => _foundationArea = val;

  bool hasFoundationArea() => _foundationArea != null;

  // "zoning" field.
  String? _zoning;
  String get zoning => _zoning ?? '';
  set zoning(String? val) => _zoning = val;

  bool hasZoning() => _zoning != null;

  // "hoaFee" field.
  String? _hoaFee;
  String get hoaFee => _hoaFee ?? '';
  set hoaFee(String? val) => _hoaFee = val;

  bool hasHoaFee() => _hoaFee != null;

  // "livingAreaRange" field.
  String? _livingAreaRange;
  String get livingAreaRange => _livingAreaRange ?? '';
  set livingAreaRange(String? val) => _livingAreaRange = val;

  bool hasLivingAreaRange() => _livingAreaRange != null;

  // "hasCarport" field.
  bool? _hasCarport;
  bool get hasCarport => _hasCarport ?? false;
  set hasCarport(bool? val) => _hasCarport = val;

  bool hasHasCarport() => _hasCarport != null;

  // "parkingFeatures" field.
  List<String>? _parkingFeatures;
  List<String> get parkingFeatures => _parkingFeatures ?? const [];
  set parkingFeatures(List<String>? val) => _parkingFeatures = val;

  void updateParkingFeatures(Function(List<String>) updateFn) {
    updateFn(_parkingFeatures ??= []);
  }

  bool hasParkingFeatures() => _parkingFeatures != null;

  // "cropsIncludedYN" field.
  String? _cropsIncludedYN;
  String get cropsIncludedYN => _cropsIncludedYN ?? '';
  set cropsIncludedYN(String? val) => _cropsIncludedYN = val;

  bool hasCropsIncludedYN() => _cropsIncludedYN != null;

  // "tenantPays" field.
  String? _tenantPays;
  String get tenantPays => _tenantPays ?? '';
  set tenantPays(String? val) => _tenantPays = val;

  bool hasTenantPays() => _tenantPays != null;

  // "parcelNumber" field.
  String? _parcelNumber;
  String get parcelNumber => _parcelNumber ?? '';
  set parcelNumber(String? val) => _parcelNumber = val;

  bool hasParcelNumber() => _parcelNumber != null;

  // "bathroomsHalf" field.
  int? _bathroomsHalf;
  int get bathroomsHalf => _bathroomsHalf ?? 0;
  set bathroomsHalf(int? val) => _bathroomsHalf = val;

  void incrementBathroomsHalf(int amount) =>
      bathroomsHalf = bathroomsHalf + amount;

  bool hasBathroomsHalf() => _bathroomsHalf != null;

  // "otherStructures" field.
  String? _otherStructures;
  String get otherStructures => _otherStructures ?? '';
  set otherStructures(String? val) => _otherStructures = val;

  bool hasOtherStructures() => _otherStructures != null;

  // "otherFacts" field.
  OtherFactsStruct? _otherFacts;
  OtherFactsStruct get otherFacts => _otherFacts ?? OtherFactsStruct();
  set otherFacts(OtherFactsStruct? val) => _otherFacts = val;

  void updateOtherFacts(Function(OtherFactsStruct) updateFn) {
    updateFn(_otherFacts ??= OtherFactsStruct());
  }

  bool hasOtherFacts() => _otherFacts != null;

  // "hasView" field.
  bool? _hasView;
  bool get hasView => _hasView ?? false;
  set hasView(bool? val) => _hasView = val;

  bool hasHasView() => _hasView != null;

  // "additionalFeeInfo" field.
  String? _additionalFeeInfo;
  String get additionalFeeInfo => _additionalFeeInfo ?? '';
  set additionalFeeInfo(String? val) => _additionalFeeInfo = val;

  bool hasAdditionalFeeInfo() => _additionalFeeInfo != null;

  // "securityFeatures" field.
  String? _securityFeatures;
  String get securityFeatures => _securityFeatures ?? '';
  set securityFeatures(String? val) => _securityFeatures = val;

  bool hasSecurityFeatures() => _securityFeatures != null;

  // "onMarketDate" field.
  int? _onMarketDate;
  int get onMarketDate => _onMarketDate ?? 0;
  set onMarketDate(int? val) => _onMarketDate = val;

  void incrementOnMarketDate(int amount) =>
      onMarketDate = onMarketDate + amount;

  bool hasOnMarketDate() => _onMarketDate != null;

  // "numberOfUnitsInCommunity" field.
  String? _numberOfUnitsInCommunity;
  String get numberOfUnitsInCommunity => _numberOfUnitsInCommunity ?? '';
  set numberOfUnitsInCommunity(String? val) => _numberOfUnitsInCommunity = val;

  bool hasNumberOfUnitsInCommunity() => _numberOfUnitsInCommunity != null;

  // "hasHomeWarranty" field.
  bool? _hasHomeWarranty;
  bool get hasHomeWarranty => _hasHomeWarranty ?? false;
  set hasHomeWarranty(bool? val) => _hasHomeWarranty = val;

  bool hasHasHomeWarranty() => _hasHomeWarranty != null;

  // "basementYN" field.
  bool? _basementYN;
  bool get basementYN => _basementYN ?? false;
  set basementYN(bool? val) => _basementYN = val;

  bool hasBasementYN() => _basementYN != null;

  // "ownershipType" field.
  String? _ownershipType;
  String get ownershipType => _ownershipType ?? '';
  set ownershipType(String? val) => _ownershipType = val;

  bool hasOwnershipType() => _ownershipType != null;

  // "doorFeatures" field.
  String? _doorFeatures;
  String get doorFeatures => _doorFeatures ?? '';
  set doorFeatures(String? val) => _doorFeatures = val;

  bool hasDoorFeatures() => _doorFeatures != null;

  // "associations" field.
  AssociationsStruct? _associations;
  AssociationsStruct get associations => _associations ?? AssociationsStruct();
  set associations(AssociationsStruct? val) => _associations = val;

  void updateAssociations(Function(AssociationsStruct) updateFn) {
    updateFn(_associations ??= AssociationsStruct());
  }

  bool hasAssociations() => _associations != null;

  // "waterView" field.
  String? _waterView;
  String get waterView => _waterView ?? '';
  set waterView(String? val) => _waterView = val;

  bool hasWaterView() => _waterView != null;

  // "aboveGradeFinishedArea" field.
  String? _aboveGradeFinishedArea;
  String get aboveGradeFinishedArea => _aboveGradeFinishedArea ?? '';
  set aboveGradeFinishedArea(String? val) => _aboveGradeFinishedArea = val;

  bool hasAboveGradeFinishedArea() => _aboveGradeFinishedArea != null;

  // "electric" field.
  String? _electric;
  String get electric => _electric ?? '';
  set electric(String? val) => _electric = val;

  bool hasElectric() => _electric != null;

  // "cumulativeDaysOnMarket" field.
  String? _cumulativeDaysOnMarket;
  String get cumulativeDaysOnMarket => _cumulativeDaysOnMarket ?? '';
  set cumulativeDaysOnMarket(String? val) => _cumulativeDaysOnMarket = val;

  bool hasCumulativeDaysOnMarket() => _cumulativeDaysOnMarket != null;

  // "hasOpenParking" field.
  bool? _hasOpenParking;
  bool get hasOpenParking => _hasOpenParking ?? false;
  set hasOpenParking(bool? val) => _hasOpenParking = val;

  bool hasHasOpenParking() => _hasOpenParking != null;

  // "hasElectricOnProperty" field.
  String? _hasElectricOnProperty;
  String get hasElectricOnProperty => _hasElectricOnProperty ?? '';
  set hasElectricOnProperty(String? val) => _hasElectricOnProperty = val;

  bool hasHasElectricOnProperty() => _hasElectricOnProperty != null;

  // "homeType" field.
  String? _homeType;
  String get homeType => _homeType ?? '';
  set homeType(String? val) => _homeType = val;

  bool hasHomeType() => _homeType != null;

  // "municipality" field.
  String? _municipality;
  String get municipality => _municipality ?? '';
  set municipality(String? val) => _municipality = val;

  bool hasMunicipality() => _municipality != null;

  // "bathroomsThreeQuarter" field.
  int? _bathroomsThreeQuarter;
  int get bathroomsThreeQuarter => _bathroomsThreeQuarter ?? 0;
  set bathroomsThreeQuarter(int? val) => _bathroomsThreeQuarter = val;

  void incrementBathroomsThreeQuarter(int amount) =>
      bathroomsThreeQuarter = bathroomsThreeQuarter + amount;

  bool hasBathroomsThreeQuarter() => _bathroomsThreeQuarter != null;

  // "hasSpa" field.
  bool? _hasSpa;
  bool get hasSpa => _hasSpa ?? false;
  set hasSpa(bool? val) => _hasSpa = val;

  bool hasHasSpa() => _hasSpa != null;

  // "basement" field.
  String? _basement;
  String get basement => _basement ?? '';
  set basement(String? val) => _basement = val;

  bool hasBasement() => _basement != null;

  // "associationFee2" field.
  String? _associationFee2;
  String get associationFee2 => _associationFee2 ?? '';
  set associationFee2(String? val) => _associationFee2 = val;

  bool hasAssociationFee2() => _associationFee2 != null;

  // "hasHeating" field.
  bool? _hasHeating;
  bool get hasHeating => _hasHeating ?? false;
  set hasHeating(bool? val) => _hasHeating = val;

  bool hasHasHeating() => _hasHeating != null;

  // "associationName2" field.
  String? _associationName2;
  String get associationName2 => _associationName2 ?? '';
  set associationName2(String? val) => _associationName2 = val;

  bool hasAssociationName2() => _associationName2 != null;

  // "elementarySchoolDistrict" field.
  String? _elementarySchoolDistrict;
  String get elementarySchoolDistrict => _elementarySchoolDistrict ?? '';
  set elementarySchoolDistrict(String? val) => _elementarySchoolDistrict = val;

  bool hasElementarySchoolDistrict() => _elementarySchoolDistrict != null;

  // "otherEquipment" field.
  String? _otherEquipment;
  String get otherEquipment => _otherEquipment ?? '';
  set otherEquipment(String? val) => _otherEquipment = val;

  bool hasOtherEquipment() => _otherEquipment != null;

  // "bathrooms" field.
  int? _bathrooms;
  int get bathrooms => _bathrooms ?? 0;
  set bathrooms(int? val) => _bathrooms = val;

  void incrementBathrooms(int amount) => bathrooms = bathrooms + amount;

  bool hasBathrooms() => _bathrooms != null;

  // "buildingArea" field.
  String? _buildingArea;
  String get buildingArea => _buildingArea ?? '';
  set buildingArea(String? val) => _buildingArea = val;

  bool hasBuildingArea() => _buildingArea != null;

  // "furnished" field.
  bool? _furnished;
  bool get furnished => _furnished ?? false;
  set furnished(bool? val) => _furnished = val;

  bool hasFurnished() => _furnished != null;

  // "vegetation" field.
  String? _vegetation;
  String get vegetation => _vegetation ?? '';
  set vegetation(String? val) => _vegetation = val;

  bool hasVegetation() => _vegetation != null;

  // "patioAndPorchFeatures" field.
  List<String>? _patioAndPorchFeatures;
  List<String> get patioAndPorchFeatures => _patioAndPorchFeatures ?? const [];
  set patioAndPorchFeatures(List<String>? val) => _patioAndPorchFeatures = val;

  void updatePatioAndPorchFeatures(Function(List<String>) updateFn) {
    updateFn(_patioAndPorchFeatures ??= []);
  }

  bool hasPatioAndPorchFeatures() => _patioAndPorchFeatures != null;

  // "builderName" field.
  String? _builderName;
  String get builderName => _builderName ?? '';
  set builderName(String? val) => _builderName = val;

  bool hasBuilderName() => _builderName != null;

  // "highSchoolDistrict" field.
  String? _highSchoolDistrict;
  String get highSchoolDistrict => _highSchoolDistrict ?? '';
  set highSchoolDistrict(String? val) => _highSchoolDistrict = val;

  bool hasHighSchoolDistrict() => _highSchoolDistrict != null;

  // "entryLocation" field.
  String? _entryLocation;
  String get entryLocation => _entryLocation ?? '';
  set entryLocation(String? val) => _entryLocation = val;

  bool hasEntryLocation() => _entryLocation != null;

  // "laundryFeatures" field.
  String? _laundryFeatures;
  String get laundryFeatures => _laundryFeatures ?? '';
  set laundryFeatures(String? val) => _laundryFeatures = val;

  bool hasLaundryFeatures() => _laundryFeatures != null;

  // "buildingFeatures" field.
  String? _buildingFeatures;
  String get buildingFeatures => _buildingFeatures ?? '';
  set buildingFeatures(String? val) => _buildingFeatures = val;

  bool hasBuildingFeatures() => _buildingFeatures != null;

  // "heating" field.
  List<String>? _heating;
  List<String> get heating => _heating ?? const [];
  set heating(List<String>? val) => _heating = val;

  void updateHeating(Function(List<String>) updateFn) {
    updateFn(_heating ??= []);
  }

  bool hasHeatingField() => _heating != null;

  // "availabilityDate" field.
  String? _availabilityDate;
  String get availabilityDate => _availabilityDate ?? '';
  set availabilityDate(String? val) => _availabilityDate = val;

  bool hasAvailabilityDate() => _availabilityDate != null;

  // "carportParkingCapacity" field.
  int? _carportParkingCapacity;
  int get carportParkingCapacity => _carportParkingCapacity ?? 0;
  set carportParkingCapacity(int? val) => _carportParkingCapacity = val;

  void incrementCarportParkingCapacity(int amount) =>
      carportParkingCapacity = carportParkingCapacity + amount;

  bool hasCarportParkingCapacity() => _carportParkingCapacity != null;

  // "hasAssociation" field.
  String? _hasAssociation;
  String get hasAssociation => _hasAssociation ?? '';
  set hasAssociation(String? val) => _hasAssociation = val;

  bool hasHasAssociation() => _hasAssociation != null;

  // "irrigationWaterRightsYN" field.
  String? _irrigationWaterRightsYN;
  String get irrigationWaterRightsYN => _irrigationWaterRightsYN ?? '';
  set irrigationWaterRightsYN(String? val) => _irrigationWaterRightsYN = val;

  bool hasIrrigationWaterRightsYN() => _irrigationWaterRightsYN != null;

  // "associationFeeIncludes" field.
  String? _associationFeeIncludes;
  String get associationFeeIncludes => _associationFeeIncludes ?? '';
  set associationFeeIncludes(String? val) => _associationFeeIncludes = val;

  bool hasAssociationFeeIncludes() => _associationFeeIncludes != null;

  // "leaseTerm" field.
  String? _leaseTerm;
  String get leaseTerm => _leaseTerm ?? '';
  set leaseTerm(String? val) => _leaseTerm = val;

  bool hasLeaseTerm() => _leaseTerm != null;

  // "levels" field.
  String? _levels;
  String get levels => _levels ?? '';
  set levels(String? val) => _levels = val;

  bool hasLevels() => _levels != null;

  // "elevation" field.
  String? _elevation;
  String get elevation => _elevation ?? '';
  set elevation(String? val) => _elevation = val;

  bool hasElevation() => _elevation != null;

  // "hasRentControl" field.
  bool? _hasRentControl;
  bool get hasRentControl => _hasRentControl ?? false;
  set hasRentControl(bool? val) => _hasRentControl = val;

  bool hasHasRentControl() => _hasRentControl != null;

  // "hasFireplace" field.
  bool? _hasFireplace;
  bool get hasFireplace => _hasFireplace ?? false;
  set hasFireplace(bool? val) => _hasFireplace = val;

  bool hasHasFireplace() => _hasFireplace != null;

  // "hasCooling" field.
  bool? _hasCooling;
  bool get hasCooling => _hasCooling ?? false;
  set hasCooling(bool? val) => _hasCooling = val;

  bool hasHasCooling() => _hasCooling != null;

  // "isSeniorCommunity" field.
  bool? _isSeniorCommunity;
  bool get isSeniorCommunity => _isSeniorCommunity ?? false;
  set isSeniorCommunity(bool? val) => _isSeniorCommunity = val;

  bool hasIsSeniorCommunity() => _isSeniorCommunity != null;

  // "cooling" field.
  List<String>? _cooling;
  List<String> get cooling => _cooling ?? const [];
  set cooling(List<String>? val) => _cooling = val;

  void updateCooling(Function(List<String>) updateFn) {
    updateFn(_cooling ??= []);
  }

  bool hasCoolingField() => _cooling != null;

  // "fireplaces" field.
  List<String>? _fireplaces;
  List<String> get fireplaces => _fireplaces ?? const [];
  set fireplaces(List<String>? val) => _fireplaces = val;

  void updateFireplaces(Function(List<String>) updateFn) {
    updateFn(_fireplaces ??= []);
  }

  bool hasFireplaces() => _fireplaces != null;

  // "bathroomsFloat" field.
  double? _bathroomsFloat;
  double get bathroomsFloat => _bathroomsFloat ?? 0.0;
  set bathroomsFloat(double? val) => _bathroomsFloat = val;

  void incrementBathroomsFloat(double amount) =>
      bathroomsFloat = bathroomsFloat + amount;

  bool hasBathroomsFloat() => _bathroomsFloat != null;

  // "pricePerSquareFoot" field.
  int? _pricePerSquareFoot;
  int get pricePerSquareFoot => _pricePerSquareFoot ?? 0;
  set pricePerSquareFoot(int? val) => _pricePerSquareFoot = val;

  void incrementPricePerSquareFoot(int amount) =>
      pricePerSquareFoot = pricePerSquareFoot + amount;

  bool hasPricePerSquareFoot() => _pricePerSquareFoot != null;

  // "communityFeatures" field.
  List<String>? _communityFeatures;
  List<String> get communityFeatures => _communityFeatures ?? const [];
  set communityFeatures(List<String>? val) => _communityFeatures = val;

  void updateCommunityFeatures(Function(List<String>) updateFn) {
    updateFn(_communityFeatures ??= []);
  }

  bool hasCommunityFeatures() => _communityFeatures != null;

  static ResoFactsStruct fromMap(Map<String, dynamic> data) => ResoFactsStruct(
        hasAttachedProperty: data['hasAttachedProperty'] as bool?,
        frontageType: data['frontageType'] as String?,
        poolFeatures: data['poolFeatures'] as String?,
        flooring: getDataList(data['flooring']),
        foundationDetails: getDataList(data['foundationDetails']),
        accessibilityFeatures: data['accessibilityFeatures'] as String?,
        hasGarage: data['hasGarage'] as bool?,
        hasPetsAllowed: data['hasPetsAllowed'] as String?,
        bodyType: data['bodyType'] as String?,
        topography: data['topography'] as String?,
        landLeaseExpirationDate: data['landLeaseExpirationDate'] as String?,
        hasAdditionalParcels: data['hasAdditionalParcels'] as bool?,
        parkName: data['parkName'] as String?,
        livingQuarters: data['livingQuarters'] is LivingQuartersStruct
            ? data['livingQuarters']
            : LivingQuartersStruct.maybeFromMap(data['livingQuarters']),
        taxAssessedValue: castToType<int>(data['taxAssessedValue']),
        atAGlanceFacts: getStructList(
          data['atAGlanceFacts'],
          AtAGlanceFactsStruct.fromMap,
        ),
        offerReviewDate: data['offerReviewDate'] as String?,
        horseYN: data['horseYN'] as String?,
        view: getDataList(data['view']),
        rooms: data['rooms'] is RoomsStruct
            ? data['rooms']
            : RoomsStruct.maybeFromMap(data['rooms']),
        belowGradeFinishedArea: data['belowGradeFinishedArea'] as String?,
        feesAndDues: data['feesAndDues'] is FeesAndDuesStruct
            ? data['feesAndDues']
            : FeesAndDuesStruct.maybeFromMap(data['feesAndDues']),
        cityRegion: data['cityRegion'] as String?,
        mainLevelBathrooms: data['mainLevelBathrooms'] as String?,
        hasPrivatePool: data['hasPrivatePool'] as String?,
        landLeaseAmount: data['landLeaseAmount'] as String?,
        waterSource: getDataList(data['waterSource']),
        exteriorFeatures: getDataList(data['exteriorFeatures']),
        inclusions: data['inclusions'] as String?,
        gas: data['gas'] as String?,
        propertyCondition: data['propertyCondition'] as String?,
        elevationUnits: data['elevationUnits'] as String?,
        exclusions: data['exclusions'] as String?,
        mainLevelBedrooms: data['mainLevelBedrooms'] as String?,
        numberOfUnitsVacant: data['numberOfUnitsVacant'] as String?,
        hasWaterfrontView: data['hasWaterfrontView'] as String?,
        bathroomsOneQuarter: data['bathroomsOneQuarter'] as String?,
        lotSize: data['lotSize'] as String?,
        entryLevel: data['entryLevel'] as String?,
        irrigationWaterRightsAcres:
            data['irrigationWaterRightsAcres'] as String?,
        greenWaterConservation: data['greenWaterConservation'] as String?,
        stories: castToType<int>(data['stories']),
        livingArea: data['livingArea'] as String?,
        commonWalls: data['commonWalls'] as String?,
        listingTerms: data['listingTerms'] as String?,
        otherParking: data['otherParking'] as String?,
        associationFee: data['associationFee'] as String?,
        marketingType: data['marketingType'] as String?,
        greenIndoorAirQuality: data['greenIndoorAirQuality'] as String?,
        greenSustainability: data['greenSustainability'] as String?,
        livingAreaRangeUnits: data['livingAreaRangeUnits'] as String?,
        associationPhone: data['associationPhone'] as String?,
        greenBuildingVerificationType:
            data['greenBuildingVerificationType'] as String?,
        hasAttachedGarage: data['hasAttachedGarage'] as bool?,
        bedrooms: castToType<int>(data['bedrooms']),
        architecturalStyle: data['architecturalStyle'] as String?,
        listingId: data['listingId'] as String?,
        structureType: data['structureType'] as String?,
        interiorFeatures: getDataList(data['interiorFeatures']),
        horseAmenities: data['horseAmenities'] as String?,
        garageParkingCapacity: castToType<int>(data['garageParkingCapacity']),
        developmentStatus: data['developmentStatus'] as String?,
        lotFeatures: data['lotFeatures'] as String?,
        roofType: data['roofType'] as String?,
        compensationBasedOn: data['compensationBasedOn'] as String?,
        greenEnergyGeneration: data['greenEnergyGeneration'] as String?,
        daysOnZillow: castToType<int>(data['daysOnZillow']),
        listAOR: data['listAOR'] as String?,
        buildingAreaSource: data['buildingAreaSource'] as String?,
        elementarySchool: data['elementarySchool'] as String?,
        zoningDescription: data['zoningDescription'] as String?,
        constructionMaterials: getDataList(data['constructionMaterials']),
        fireplaceFeatures: data['fireplaceFeatures'] as String?,
        hoaFeeTotal: data['hoaFeeTotal'] as String?,
        appliances: getDataList(data['appliances']),
        builderModel: data['builderModel'] as String?,
        bathroomsPartial: data['bathroomsPartial'] as String?,
        fencing: data['fencing'] as String?,
        yearBuiltEffective: castToType<int>(data['yearBuiltEffective']),
        waterfrontFeatures: data['waterfrontFeatures'] as String?,
        buildingName: data['buildingName'] as String?,
        attic: data['attic'] as String?,
        petsMaxWeight: data['petsMaxWeight'] as String?,
        specialListingConditions: data['specialListingConditions'] as String?,
        storiesTotal: data['storiesTotal'] as String?,
        additionalParcelsDescription:
            data['additionalParcelsDescription'] as String?,
        canRaiseHorses: data['canRaiseHorses'] as bool?,
        hasLandLease: data['hasLandLease'] as bool?,
        isNewConstruction: data['isNewConstruction'] as bool?,
        waterViewYN: data['waterViewYN'] as bool?,
        middleOrJuniorSchool: data['middleOrJuniorSchool'] as String?,
        lotSizeDimensions: data['lotSizeDimensions'] as String?,
        associationName: data['associationName'] as String?,
        contingency: data['contingency'] as String?,
        yearBuilt: castToType<int>(data['yearBuilt']),
        waterBodyName: data['waterBodyName'] as String?,
        virtualTour: data['virtualTour'] as String?,
        bathroomsFull: castToType<int>(data['bathroomsFull']),
        greenEnergyEfficient: data['greenEnergyEfficient'] as String?,
        incomeIncludes: data['incomeIncludes'] as String?,
        highSchool: data['highSchool'] as String?,
        utilities: data['utilities'] as String?,
        totalActualRent: data['totalActualRent'] as String?,
        parkingCapacity: castToType<int>(data['parkingCapacity']),
        taxAnnualAmount: castToType<int>(data['taxAnnualAmount']),
        subdivisionName: data['subdivisionName'] as String?,
        windowFeatures: getDataList(data['windowFeatures']),
        ownership: data['ownership'] as String?,
        woodedArea: data['woodedArea'] as String?,
        middleOrJuniorSchoolDistrict:
            data['middleOrJuniorSchoolDistrict'] as String?,
        associationPhone2: data['associationPhone2'] as String?,
        spaFeatures: data['spaFeatures'] as String?,
        sewer: getDataList(data['sewer']),
        frontageLength: data['frontageLength'] as String?,
        openParkingCapacity: data['openParkingCapacity'] as String?,
        associationAmenities: data['associationAmenities'] as String?,
        roadSurfaceType: getDataList(data['roadSurfaceType']),
        propertySubType: getDataList(data['propertySubType']),
        coveredParkingCapacity: castToType<int>(data['coveredParkingCapacity']),
        foundationArea: data['foundationArea'] as String?,
        zoning: data['zoning'] as String?,
        hoaFee: data['hoaFee'] as String?,
        livingAreaRange: data['livingAreaRange'] as String?,
        hasCarport: data['hasCarport'] as bool?,
        parkingFeatures: getDataList(data['parkingFeatures']),
        cropsIncludedYN: data['cropsIncludedYN'] as String?,
        tenantPays: data['tenantPays'] as String?,
        parcelNumber: data['parcelNumber'] as String?,
        bathroomsHalf: castToType<int>(data['bathroomsHalf']),
        otherStructures: data['otherStructures'] as String?,
        otherFacts: data['otherFacts'] is OtherFactsStruct
            ? data['otherFacts']
            : OtherFactsStruct.maybeFromMap(data['otherFacts']),
        hasView: data['hasView'] as bool?,
        additionalFeeInfo: data['additionalFeeInfo'] as String?,
        securityFeatures: data['securityFeatures'] as String?,
        onMarketDate: castToType<int>(data['onMarketDate']),
        numberOfUnitsInCommunity: data['numberOfUnitsInCommunity'] as String?,
        hasHomeWarranty: data['hasHomeWarranty'] as bool?,
        basementYN: data['basementYN'] as bool?,
        ownershipType: data['ownershipType'] as String?,
        doorFeatures: data['doorFeatures'] as String?,
        associations: data['associations'] is AssociationsStruct
            ? data['associations']
            : AssociationsStruct.maybeFromMap(data['associations']),
        waterView: data['waterView'] as String?,
        aboveGradeFinishedArea: data['aboveGradeFinishedArea'] as String?,
        electric: data['electric'] as String?,
        cumulativeDaysOnMarket: data['cumulativeDaysOnMarket'] as String?,
        hasOpenParking: data['hasOpenParking'] as bool?,
        hasElectricOnProperty: data['hasElectricOnProperty'] as String?,
        homeType: data['homeType'] as String?,
        municipality: data['municipality'] as String?,
        bathroomsThreeQuarter: castToType<int>(data['bathroomsThreeQuarter']),
        hasSpa: data['hasSpa'] as bool?,
        basement: data['basement'] as String?,
        associationFee2: data['associationFee2'] as String?,
        hasHeating: data['hasHeating'] as bool?,
        associationName2: data['associationName2'] as String?,
        elementarySchoolDistrict: data['elementarySchoolDistrict'] as String?,
        otherEquipment: data['otherEquipment'] as String?,
        bathrooms: castToType<int>(data['bathrooms']),
        buildingArea: data['buildingArea'] as String?,
        furnished: data['furnished'] as bool?,
        vegetation: data['vegetation'] as String?,
        patioAndPorchFeatures: getDataList(data['patioAndPorchFeatures']),
        builderName: data['builderName'] as String?,
        highSchoolDistrict: data['highSchoolDistrict'] as String?,
        entryLocation: data['entryLocation'] as String?,
        laundryFeatures: data['laundryFeatures'] as String?,
        buildingFeatures: data['buildingFeatures'] as String?,
        heating: getDataList(data['heating']),
        availabilityDate: data['availabilityDate'] as String?,
        carportParkingCapacity: castToType<int>(data['carportParkingCapacity']),
        hasAssociation: data['hasAssociation'] as String?,
        irrigationWaterRightsYN: data['irrigationWaterRightsYN'] as String?,
        associationFeeIncludes: data['associationFeeIncludes'] as String?,
        leaseTerm: data['leaseTerm'] as String?,
        levels: data['levels'] as String?,
        elevation: data['elevation'] as String?,
        hasRentControl: data['hasRentControl'] as bool?,
        hasFireplace: data['hasFireplace'] as bool?,
        hasCooling: data['hasCooling'] as bool?,
        isSeniorCommunity: data['isSeniorCommunity'] as bool?,
        cooling: getDataList(data['cooling']),
        fireplaces: getDataList(data['fireplaces']),
        bathroomsFloat: castToType<double>(data['bathroomsFloat']),
        pricePerSquareFoot: castToType<int>(data['pricePerSquareFoot']),
        communityFeatures: getDataList(data['communityFeatures']),
      );

  static ResoFactsStruct? maybeFromMap(dynamic data) => data is Map
      ? ResoFactsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'hasAttachedProperty': _hasAttachedProperty,
        'frontageType': _frontageType,
        'poolFeatures': _poolFeatures,
        'flooring': _flooring,
        'foundationDetails': _foundationDetails,
        'accessibilityFeatures': _accessibilityFeatures,
        'hasGarage': _hasGarage,
        'hasPetsAllowed': _hasPetsAllowed,
        'bodyType': _bodyType,
        'topography': _topography,
        'landLeaseExpirationDate': _landLeaseExpirationDate,
        'hasAdditionalParcels': _hasAdditionalParcels,
        'parkName': _parkName,
        'livingQuarters': _livingQuarters?.toMap(),
        'taxAssessedValue': _taxAssessedValue,
        'atAGlanceFacts': _atAGlanceFacts?.map((e) => e.toMap()).toList(),
        'offerReviewDate': _offerReviewDate,
        'horseYN': _horseYN,
        'view': _view,
        'rooms': _rooms?.toMap(),
        'belowGradeFinishedArea': _belowGradeFinishedArea,
        'feesAndDues': _feesAndDues?.toMap(),
        'cityRegion': _cityRegion,
        'mainLevelBathrooms': _mainLevelBathrooms,
        'hasPrivatePool': _hasPrivatePool,
        'landLeaseAmount': _landLeaseAmount,
        'waterSource': _waterSource,
        'exteriorFeatures': _exteriorFeatures,
        'inclusions': _inclusions,
        'gas': _gas,
        'propertyCondition': _propertyCondition,
        'elevationUnits': _elevationUnits,
        'exclusions': _exclusions,
        'mainLevelBedrooms': _mainLevelBedrooms,
        'numberOfUnitsVacant': _numberOfUnitsVacant,
        'hasWaterfrontView': _hasWaterfrontView,
        'bathroomsOneQuarter': _bathroomsOneQuarter,
        'lotSize': _lotSize,
        'entryLevel': _entryLevel,
        'irrigationWaterRightsAcres': _irrigationWaterRightsAcres,
        'greenWaterConservation': _greenWaterConservation,
        'stories': _stories,
        'livingArea': _livingArea,
        'commonWalls': _commonWalls,
        'listingTerms': _listingTerms,
        'otherParking': _otherParking,
        'associationFee': _associationFee,
        'marketingType': _marketingType,
        'greenIndoorAirQuality': _greenIndoorAirQuality,
        'greenSustainability': _greenSustainability,
        'livingAreaRangeUnits': _livingAreaRangeUnits,
        'associationPhone': _associationPhone,
        'greenBuildingVerificationType': _greenBuildingVerificationType,
        'hasAttachedGarage': _hasAttachedGarage,
        'bedrooms': _bedrooms,
        'architecturalStyle': _architecturalStyle,
        'listingId': _listingId,
        'structureType': _structureType,
        'interiorFeatures': _interiorFeatures,
        'horseAmenities': _horseAmenities,
        'garageParkingCapacity': _garageParkingCapacity,
        'developmentStatus': _developmentStatus,
        'lotFeatures': _lotFeatures,
        'roofType': _roofType,
        'compensationBasedOn': _compensationBasedOn,
        'greenEnergyGeneration': _greenEnergyGeneration,
        'daysOnZillow': _daysOnZillow,
        'listAOR': _listAOR,
        'buildingAreaSource': _buildingAreaSource,
        'elementarySchool': _elementarySchool,
        'zoningDescription': _zoningDescription,
        'constructionMaterials': _constructionMaterials,
        'fireplaceFeatures': _fireplaceFeatures,
        'hoaFeeTotal': _hoaFeeTotal,
        'appliances': _appliances,
        'builderModel': _builderModel,
        'bathroomsPartial': _bathroomsPartial,
        'fencing': _fencing,
        'yearBuiltEffective': _yearBuiltEffective,
        'waterfrontFeatures': _waterfrontFeatures,
        'buildingName': _buildingName,
        'attic': _attic,
        'petsMaxWeight': _petsMaxWeight,
        'specialListingConditions': _specialListingConditions,
        'storiesTotal': _storiesTotal,
        'additionalParcelsDescription': _additionalParcelsDescription,
        'canRaiseHorses': _canRaiseHorses,
        'hasLandLease': _hasLandLease,
        'isNewConstruction': _isNewConstruction,
        'waterViewYN': _waterViewYN,
        'middleOrJuniorSchool': _middleOrJuniorSchool,
        'lotSizeDimensions': _lotSizeDimensions,
        'associationName': _associationName,
        'contingency': _contingency,
        'yearBuilt': _yearBuilt,
        'waterBodyName': _waterBodyName,
        'virtualTour': _virtualTour,
        'bathroomsFull': _bathroomsFull,
        'greenEnergyEfficient': _greenEnergyEfficient,
        'incomeIncludes': _incomeIncludes,
        'highSchool': _highSchool,
        'utilities': _utilities,
        'totalActualRent': _totalActualRent,
        'parkingCapacity': _parkingCapacity,
        'taxAnnualAmount': _taxAnnualAmount,
        'subdivisionName': _subdivisionName,
        'windowFeatures': _windowFeatures,
        'ownership': _ownership,
        'woodedArea': _woodedArea,
        'middleOrJuniorSchoolDistrict': _middleOrJuniorSchoolDistrict,
        'associationPhone2': _associationPhone2,
        'spaFeatures': _spaFeatures,
        'sewer': _sewer,
        'frontageLength': _frontageLength,
        'openParkingCapacity': _openParkingCapacity,
        'associationAmenities': _associationAmenities,
        'roadSurfaceType': _roadSurfaceType,
        'propertySubType': _propertySubType,
        'coveredParkingCapacity': _coveredParkingCapacity,
        'foundationArea': _foundationArea,
        'zoning': _zoning,
        'hoaFee': _hoaFee,
        'livingAreaRange': _livingAreaRange,
        'hasCarport': _hasCarport,
        'parkingFeatures': _parkingFeatures,
        'cropsIncludedYN': _cropsIncludedYN,
        'tenantPays': _tenantPays,
        'parcelNumber': _parcelNumber,
        'bathroomsHalf': _bathroomsHalf,
        'otherStructures': _otherStructures,
        'otherFacts': _otherFacts?.toMap(),
        'hasView': _hasView,
        'additionalFeeInfo': _additionalFeeInfo,
        'securityFeatures': _securityFeatures,
        'onMarketDate': _onMarketDate,
        'numberOfUnitsInCommunity': _numberOfUnitsInCommunity,
        'hasHomeWarranty': _hasHomeWarranty,
        'basementYN': _basementYN,
        'ownershipType': _ownershipType,
        'doorFeatures': _doorFeatures,
        'associations': _associations?.toMap(),
        'waterView': _waterView,
        'aboveGradeFinishedArea': _aboveGradeFinishedArea,
        'electric': _electric,
        'cumulativeDaysOnMarket': _cumulativeDaysOnMarket,
        'hasOpenParking': _hasOpenParking,
        'hasElectricOnProperty': _hasElectricOnProperty,
        'homeType': _homeType,
        'municipality': _municipality,
        'bathroomsThreeQuarter': _bathroomsThreeQuarter,
        'hasSpa': _hasSpa,
        'basement': _basement,
        'associationFee2': _associationFee2,
        'hasHeating': _hasHeating,
        'associationName2': _associationName2,
        'elementarySchoolDistrict': _elementarySchoolDistrict,
        'otherEquipment': _otherEquipment,
        'bathrooms': _bathrooms,
        'buildingArea': _buildingArea,
        'furnished': _furnished,
        'vegetation': _vegetation,
        'patioAndPorchFeatures': _patioAndPorchFeatures,
        'builderName': _builderName,
        'highSchoolDistrict': _highSchoolDistrict,
        'entryLocation': _entryLocation,
        'laundryFeatures': _laundryFeatures,
        'buildingFeatures': _buildingFeatures,
        'heating': _heating,
        'availabilityDate': _availabilityDate,
        'carportParkingCapacity': _carportParkingCapacity,
        'hasAssociation': _hasAssociation,
        'irrigationWaterRightsYN': _irrigationWaterRightsYN,
        'associationFeeIncludes': _associationFeeIncludes,
        'leaseTerm': _leaseTerm,
        'levels': _levels,
        'elevation': _elevation,
        'hasRentControl': _hasRentControl,
        'hasFireplace': _hasFireplace,
        'hasCooling': _hasCooling,
        'isSeniorCommunity': _isSeniorCommunity,
        'cooling': _cooling,
        'fireplaces': _fireplaces,
        'bathroomsFloat': _bathroomsFloat,
        'pricePerSquareFoot': _pricePerSquareFoot,
        'communityFeatures': _communityFeatures,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'hasAttachedProperty': serializeParam(
          _hasAttachedProperty,
          ParamType.bool,
        ),
        'frontageType': serializeParam(
          _frontageType,
          ParamType.String,
        ),
        'poolFeatures': serializeParam(
          _poolFeatures,
          ParamType.String,
        ),
        'flooring': serializeParam(
          _flooring,
          ParamType.String,
          isList: true,
        ),
        'foundationDetails': serializeParam(
          _foundationDetails,
          ParamType.String,
          isList: true,
        ),
        'accessibilityFeatures': serializeParam(
          _accessibilityFeatures,
          ParamType.String,
        ),
        'hasGarage': serializeParam(
          _hasGarage,
          ParamType.bool,
        ),
        'hasPetsAllowed': serializeParam(
          _hasPetsAllowed,
          ParamType.String,
        ),
        'bodyType': serializeParam(
          _bodyType,
          ParamType.String,
        ),
        'topography': serializeParam(
          _topography,
          ParamType.String,
        ),
        'landLeaseExpirationDate': serializeParam(
          _landLeaseExpirationDate,
          ParamType.String,
        ),
        'hasAdditionalParcels': serializeParam(
          _hasAdditionalParcels,
          ParamType.bool,
        ),
        'parkName': serializeParam(
          _parkName,
          ParamType.String,
        ),
        'livingQuarters': serializeParam(
          _livingQuarters,
          ParamType.DataStruct,
        ),
        'taxAssessedValue': serializeParam(
          _taxAssessedValue,
          ParamType.int,
        ),
        'atAGlanceFacts': serializeParam(
          _atAGlanceFacts,
          ParamType.DataStruct,
          isList: true,
        ),
        'offerReviewDate': serializeParam(
          _offerReviewDate,
          ParamType.String,
        ),
        'horseYN': serializeParam(
          _horseYN,
          ParamType.String,
        ),
        'view': serializeParam(
          _view,
          ParamType.String,
          isList: true,
        ),
        'rooms': serializeParam(
          _rooms,
          ParamType.DataStruct,
        ),
        'belowGradeFinishedArea': serializeParam(
          _belowGradeFinishedArea,
          ParamType.String,
        ),
        'feesAndDues': serializeParam(
          _feesAndDues,
          ParamType.DataStruct,
        ),
        'cityRegion': serializeParam(
          _cityRegion,
          ParamType.String,
        ),
        'mainLevelBathrooms': serializeParam(
          _mainLevelBathrooms,
          ParamType.String,
        ),
        'hasPrivatePool': serializeParam(
          _hasPrivatePool,
          ParamType.String,
        ),
        'landLeaseAmount': serializeParam(
          _landLeaseAmount,
          ParamType.String,
        ),
        'waterSource': serializeParam(
          _waterSource,
          ParamType.String,
          isList: true,
        ),
        'exteriorFeatures': serializeParam(
          _exteriorFeatures,
          ParamType.String,
          isList: true,
        ),
        'inclusions': serializeParam(
          _inclusions,
          ParamType.String,
        ),
        'gas': serializeParam(
          _gas,
          ParamType.String,
        ),
        'propertyCondition': serializeParam(
          _propertyCondition,
          ParamType.String,
        ),
        'elevationUnits': serializeParam(
          _elevationUnits,
          ParamType.String,
        ),
        'exclusions': serializeParam(
          _exclusions,
          ParamType.String,
        ),
        'mainLevelBedrooms': serializeParam(
          _mainLevelBedrooms,
          ParamType.String,
        ),
        'numberOfUnitsVacant': serializeParam(
          _numberOfUnitsVacant,
          ParamType.String,
        ),
        'hasWaterfrontView': serializeParam(
          _hasWaterfrontView,
          ParamType.String,
        ),
        'bathroomsOneQuarter': serializeParam(
          _bathroomsOneQuarter,
          ParamType.String,
        ),
        'lotSize': serializeParam(
          _lotSize,
          ParamType.String,
        ),
        'entryLevel': serializeParam(
          _entryLevel,
          ParamType.String,
        ),
        'irrigationWaterRightsAcres': serializeParam(
          _irrigationWaterRightsAcres,
          ParamType.String,
        ),
        'greenWaterConservation': serializeParam(
          _greenWaterConservation,
          ParamType.String,
        ),
        'stories': serializeParam(
          _stories,
          ParamType.int,
        ),
        'livingArea': serializeParam(
          _livingArea,
          ParamType.String,
        ),
        'commonWalls': serializeParam(
          _commonWalls,
          ParamType.String,
        ),
        'listingTerms': serializeParam(
          _listingTerms,
          ParamType.String,
        ),
        'otherParking': serializeParam(
          _otherParking,
          ParamType.String,
        ),
        'associationFee': serializeParam(
          _associationFee,
          ParamType.String,
        ),
        'marketingType': serializeParam(
          _marketingType,
          ParamType.String,
        ),
        'greenIndoorAirQuality': serializeParam(
          _greenIndoorAirQuality,
          ParamType.String,
        ),
        'greenSustainability': serializeParam(
          _greenSustainability,
          ParamType.String,
        ),
        'livingAreaRangeUnits': serializeParam(
          _livingAreaRangeUnits,
          ParamType.String,
        ),
        'associationPhone': serializeParam(
          _associationPhone,
          ParamType.String,
        ),
        'greenBuildingVerificationType': serializeParam(
          _greenBuildingVerificationType,
          ParamType.String,
        ),
        'hasAttachedGarage': serializeParam(
          _hasAttachedGarage,
          ParamType.bool,
        ),
        'bedrooms': serializeParam(
          _bedrooms,
          ParamType.int,
        ),
        'architecturalStyle': serializeParam(
          _architecturalStyle,
          ParamType.String,
        ),
        'listingId': serializeParam(
          _listingId,
          ParamType.String,
        ),
        'structureType': serializeParam(
          _structureType,
          ParamType.String,
        ),
        'interiorFeatures': serializeParam(
          _interiorFeatures,
          ParamType.String,
          isList: true,
        ),
        'horseAmenities': serializeParam(
          _horseAmenities,
          ParamType.String,
        ),
        'garageParkingCapacity': serializeParam(
          _garageParkingCapacity,
          ParamType.int,
        ),
        'developmentStatus': serializeParam(
          _developmentStatus,
          ParamType.String,
        ),
        'lotFeatures': serializeParam(
          _lotFeatures,
          ParamType.String,
        ),
        'roofType': serializeParam(
          _roofType,
          ParamType.String,
        ),
        'compensationBasedOn': serializeParam(
          _compensationBasedOn,
          ParamType.String,
        ),
        'greenEnergyGeneration': serializeParam(
          _greenEnergyGeneration,
          ParamType.String,
        ),
        'daysOnZillow': serializeParam(
          _daysOnZillow,
          ParamType.int,
        ),
        'listAOR': serializeParam(
          _listAOR,
          ParamType.String,
        ),
        'buildingAreaSource': serializeParam(
          _buildingAreaSource,
          ParamType.String,
        ),
        'elementarySchool': serializeParam(
          _elementarySchool,
          ParamType.String,
        ),
        'zoningDescription': serializeParam(
          _zoningDescription,
          ParamType.String,
        ),
        'constructionMaterials': serializeParam(
          _constructionMaterials,
          ParamType.String,
          isList: true,
        ),
        'fireplaceFeatures': serializeParam(
          _fireplaceFeatures,
          ParamType.String,
        ),
        'hoaFeeTotal': serializeParam(
          _hoaFeeTotal,
          ParamType.String,
        ),
        'appliances': serializeParam(
          _appliances,
          ParamType.String,
          isList: true,
        ),
        'builderModel': serializeParam(
          _builderModel,
          ParamType.String,
        ),
        'bathroomsPartial': serializeParam(
          _bathroomsPartial,
          ParamType.String,
        ),
        'fencing': serializeParam(
          _fencing,
          ParamType.String,
        ),
        'yearBuiltEffective': serializeParam(
          _yearBuiltEffective,
          ParamType.int,
        ),
        'waterfrontFeatures': serializeParam(
          _waterfrontFeatures,
          ParamType.String,
        ),
        'buildingName': serializeParam(
          _buildingName,
          ParamType.String,
        ),
        'attic': serializeParam(
          _attic,
          ParamType.String,
        ),
        'petsMaxWeight': serializeParam(
          _petsMaxWeight,
          ParamType.String,
        ),
        'specialListingConditions': serializeParam(
          _specialListingConditions,
          ParamType.String,
        ),
        'storiesTotal': serializeParam(
          _storiesTotal,
          ParamType.String,
        ),
        'additionalParcelsDescription': serializeParam(
          _additionalParcelsDescription,
          ParamType.String,
        ),
        'canRaiseHorses': serializeParam(
          _canRaiseHorses,
          ParamType.bool,
        ),
        'hasLandLease': serializeParam(
          _hasLandLease,
          ParamType.bool,
        ),
        'isNewConstruction': serializeParam(
          _isNewConstruction,
          ParamType.bool,
        ),
        'waterViewYN': serializeParam(
          _waterViewYN,
          ParamType.bool,
        ),
        'middleOrJuniorSchool': serializeParam(
          _middleOrJuniorSchool,
          ParamType.String,
        ),
        'lotSizeDimensions': serializeParam(
          _lotSizeDimensions,
          ParamType.String,
        ),
        'associationName': serializeParam(
          _associationName,
          ParamType.String,
        ),
        'contingency': serializeParam(
          _contingency,
          ParamType.String,
        ),
        'yearBuilt': serializeParam(
          _yearBuilt,
          ParamType.int,
        ),
        'waterBodyName': serializeParam(
          _waterBodyName,
          ParamType.String,
        ),
        'virtualTour': serializeParam(
          _virtualTour,
          ParamType.String,
        ),
        'bathroomsFull': serializeParam(
          _bathroomsFull,
          ParamType.int,
        ),
        'greenEnergyEfficient': serializeParam(
          _greenEnergyEfficient,
          ParamType.String,
        ),
        'incomeIncludes': serializeParam(
          _incomeIncludes,
          ParamType.String,
        ),
        'highSchool': serializeParam(
          _highSchool,
          ParamType.String,
        ),
        'utilities': serializeParam(
          _utilities,
          ParamType.String,
        ),
        'totalActualRent': serializeParam(
          _totalActualRent,
          ParamType.String,
        ),
        'parkingCapacity': serializeParam(
          _parkingCapacity,
          ParamType.int,
        ),
        'taxAnnualAmount': serializeParam(
          _taxAnnualAmount,
          ParamType.int,
        ),
        'subdivisionName': serializeParam(
          _subdivisionName,
          ParamType.String,
        ),
        'windowFeatures': serializeParam(
          _windowFeatures,
          ParamType.String,
          isList: true,
        ),
        'ownership': serializeParam(
          _ownership,
          ParamType.String,
        ),
        'woodedArea': serializeParam(
          _woodedArea,
          ParamType.String,
        ),
        'middleOrJuniorSchoolDistrict': serializeParam(
          _middleOrJuniorSchoolDistrict,
          ParamType.String,
        ),
        'associationPhone2': serializeParam(
          _associationPhone2,
          ParamType.String,
        ),
        'spaFeatures': serializeParam(
          _spaFeatures,
          ParamType.String,
        ),
        'sewer': serializeParam(
          _sewer,
          ParamType.String,
          isList: true,
        ),
        'frontageLength': serializeParam(
          _frontageLength,
          ParamType.String,
        ),
        'openParkingCapacity': serializeParam(
          _openParkingCapacity,
          ParamType.String,
        ),
        'associationAmenities': serializeParam(
          _associationAmenities,
          ParamType.String,
        ),
        'roadSurfaceType': serializeParam(
          _roadSurfaceType,
          ParamType.String,
          isList: true,
        ),
        'propertySubType': serializeParam(
          _propertySubType,
          ParamType.String,
          isList: true,
        ),
        'coveredParkingCapacity': serializeParam(
          _coveredParkingCapacity,
          ParamType.int,
        ),
        'foundationArea': serializeParam(
          _foundationArea,
          ParamType.String,
        ),
        'zoning': serializeParam(
          _zoning,
          ParamType.String,
        ),
        'hoaFee': serializeParam(
          _hoaFee,
          ParamType.String,
        ),
        'livingAreaRange': serializeParam(
          _livingAreaRange,
          ParamType.String,
        ),
        'hasCarport': serializeParam(
          _hasCarport,
          ParamType.bool,
        ),
        'parkingFeatures': serializeParam(
          _parkingFeatures,
          ParamType.String,
          isList: true,
        ),
        'cropsIncludedYN': serializeParam(
          _cropsIncludedYN,
          ParamType.String,
        ),
        'tenantPays': serializeParam(
          _tenantPays,
          ParamType.String,
        ),
        'parcelNumber': serializeParam(
          _parcelNumber,
          ParamType.String,
        ),
        'bathroomsHalf': serializeParam(
          _bathroomsHalf,
          ParamType.int,
        ),
        'otherStructures': serializeParam(
          _otherStructures,
          ParamType.String,
        ),
        'otherFacts': serializeParam(
          _otherFacts,
          ParamType.DataStruct,
        ),
        'hasView': serializeParam(
          _hasView,
          ParamType.bool,
        ),
        'additionalFeeInfo': serializeParam(
          _additionalFeeInfo,
          ParamType.String,
        ),
        'securityFeatures': serializeParam(
          _securityFeatures,
          ParamType.String,
        ),
        'onMarketDate': serializeParam(
          _onMarketDate,
          ParamType.int,
        ),
        'numberOfUnitsInCommunity': serializeParam(
          _numberOfUnitsInCommunity,
          ParamType.String,
        ),
        'hasHomeWarranty': serializeParam(
          _hasHomeWarranty,
          ParamType.bool,
        ),
        'basementYN': serializeParam(
          _basementYN,
          ParamType.bool,
        ),
        'ownershipType': serializeParam(
          _ownershipType,
          ParamType.String,
        ),
        'doorFeatures': serializeParam(
          _doorFeatures,
          ParamType.String,
        ),
        'associations': serializeParam(
          _associations,
          ParamType.DataStruct,
        ),
        'waterView': serializeParam(
          _waterView,
          ParamType.String,
        ),
        'aboveGradeFinishedArea': serializeParam(
          _aboveGradeFinishedArea,
          ParamType.String,
        ),
        'electric': serializeParam(
          _electric,
          ParamType.String,
        ),
        'cumulativeDaysOnMarket': serializeParam(
          _cumulativeDaysOnMarket,
          ParamType.String,
        ),
        'hasOpenParking': serializeParam(
          _hasOpenParking,
          ParamType.bool,
        ),
        'hasElectricOnProperty': serializeParam(
          _hasElectricOnProperty,
          ParamType.String,
        ),
        'homeType': serializeParam(
          _homeType,
          ParamType.String,
        ),
        'municipality': serializeParam(
          _municipality,
          ParamType.String,
        ),
        'bathroomsThreeQuarter': serializeParam(
          _bathroomsThreeQuarter,
          ParamType.int,
        ),
        'hasSpa': serializeParam(
          _hasSpa,
          ParamType.bool,
        ),
        'basement': serializeParam(
          _basement,
          ParamType.String,
        ),
        'associationFee2': serializeParam(
          _associationFee2,
          ParamType.String,
        ),
        'hasHeating': serializeParam(
          _hasHeating,
          ParamType.bool,
        ),
        'associationName2': serializeParam(
          _associationName2,
          ParamType.String,
        ),
        'elementarySchoolDistrict': serializeParam(
          _elementarySchoolDistrict,
          ParamType.String,
        ),
        'otherEquipment': serializeParam(
          _otherEquipment,
          ParamType.String,
        ),
        'bathrooms': serializeParam(
          _bathrooms,
          ParamType.int,
        ),
        'buildingArea': serializeParam(
          _buildingArea,
          ParamType.String,
        ),
        'furnished': serializeParam(
          _furnished,
          ParamType.bool,
        ),
        'vegetation': serializeParam(
          _vegetation,
          ParamType.String,
        ),
        'patioAndPorchFeatures': serializeParam(
          _patioAndPorchFeatures,
          ParamType.String,
          isList: true,
        ),
        'builderName': serializeParam(
          _builderName,
          ParamType.String,
        ),
        'highSchoolDistrict': serializeParam(
          _highSchoolDistrict,
          ParamType.String,
        ),
        'entryLocation': serializeParam(
          _entryLocation,
          ParamType.String,
        ),
        'laundryFeatures': serializeParam(
          _laundryFeatures,
          ParamType.String,
        ),
        'buildingFeatures': serializeParam(
          _buildingFeatures,
          ParamType.String,
        ),
        'heating': serializeParam(
          _heating,
          ParamType.String,
          isList: true,
        ),
        'availabilityDate': serializeParam(
          _availabilityDate,
          ParamType.String,
        ),
        'carportParkingCapacity': serializeParam(
          _carportParkingCapacity,
          ParamType.int,
        ),
        'hasAssociation': serializeParam(
          _hasAssociation,
          ParamType.String,
        ),
        'irrigationWaterRightsYN': serializeParam(
          _irrigationWaterRightsYN,
          ParamType.String,
        ),
        'associationFeeIncludes': serializeParam(
          _associationFeeIncludes,
          ParamType.String,
        ),
        'leaseTerm': serializeParam(
          _leaseTerm,
          ParamType.String,
        ),
        'levels': serializeParam(
          _levels,
          ParamType.String,
        ),
        'elevation': serializeParam(
          _elevation,
          ParamType.String,
        ),
        'hasRentControl': serializeParam(
          _hasRentControl,
          ParamType.bool,
        ),
        'hasFireplace': serializeParam(
          _hasFireplace,
          ParamType.bool,
        ),
        'hasCooling': serializeParam(
          _hasCooling,
          ParamType.bool,
        ),
        'isSeniorCommunity': serializeParam(
          _isSeniorCommunity,
          ParamType.bool,
        ),
        'cooling': serializeParam(
          _cooling,
          ParamType.String,
          isList: true,
        ),
        'fireplaces': serializeParam(
          _fireplaces,
          ParamType.String,
          isList: true,
        ),
        'bathroomsFloat': serializeParam(
          _bathroomsFloat,
          ParamType.double,
        ),
        'pricePerSquareFoot': serializeParam(
          _pricePerSquareFoot,
          ParamType.int,
        ),
        'communityFeatures': serializeParam(
          _communityFeatures,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static ResoFactsStruct fromSerializableMap(Map<String, dynamic> data) =>
      ResoFactsStruct(
        hasAttachedProperty: deserializeParam(
          data['hasAttachedProperty'],
          ParamType.bool,
          false,
        ),
        frontageType: deserializeParam(
          data['frontageType'],
          ParamType.String,
          false,
        ),
        poolFeatures: deserializeParam(
          data['poolFeatures'],
          ParamType.String,
          false,
        ),
        flooring: deserializeParam<String>(
          data['flooring'],
          ParamType.String,
          true,
        ),
        foundationDetails: deserializeParam<String>(
          data['foundationDetails'],
          ParamType.String,
          true,
        ),
        accessibilityFeatures: deserializeParam(
          data['accessibilityFeatures'],
          ParamType.String,
          false,
        ),
        hasGarage: deserializeParam(
          data['hasGarage'],
          ParamType.bool,
          false,
        ),
        hasPetsAllowed: deserializeParam(
          data['hasPetsAllowed'],
          ParamType.String,
          false,
        ),
        bodyType: deserializeParam(
          data['bodyType'],
          ParamType.String,
          false,
        ),
        topography: deserializeParam(
          data['topography'],
          ParamType.String,
          false,
        ),
        landLeaseExpirationDate: deserializeParam(
          data['landLeaseExpirationDate'],
          ParamType.String,
          false,
        ),
        hasAdditionalParcels: deserializeParam(
          data['hasAdditionalParcels'],
          ParamType.bool,
          false,
        ),
        parkName: deserializeParam(
          data['parkName'],
          ParamType.String,
          false,
        ),
        livingQuarters: deserializeStructParam(
          data['livingQuarters'],
          ParamType.DataStruct,
          false,
          structBuilder: LivingQuartersStruct.fromSerializableMap,
        ),
        taxAssessedValue: deserializeParam(
          data['taxAssessedValue'],
          ParamType.int,
          false,
        ),
        atAGlanceFacts: deserializeStructParam<AtAGlanceFactsStruct>(
          data['atAGlanceFacts'],
          ParamType.DataStruct,
          true,
          structBuilder: AtAGlanceFactsStruct.fromSerializableMap,
        ),
        offerReviewDate: deserializeParam(
          data['offerReviewDate'],
          ParamType.String,
          false,
        ),
        horseYN: deserializeParam(
          data['horseYN'],
          ParamType.String,
          false,
        ),
        view: deserializeParam<String>(
          data['view'],
          ParamType.String,
          true,
        ),
        rooms: deserializeStructParam(
          data['rooms'],
          ParamType.DataStruct,
          false,
          structBuilder: RoomsStruct.fromSerializableMap,
        ),
        belowGradeFinishedArea: deserializeParam(
          data['belowGradeFinishedArea'],
          ParamType.String,
          false,
        ),
        feesAndDues: deserializeStructParam(
          data['feesAndDues'],
          ParamType.DataStruct,
          false,
          structBuilder: FeesAndDuesStruct.fromSerializableMap,
        ),
        cityRegion: deserializeParam(
          data['cityRegion'],
          ParamType.String,
          false,
        ),
        mainLevelBathrooms: deserializeParam(
          data['mainLevelBathrooms'],
          ParamType.String,
          false,
        ),
        hasPrivatePool: deserializeParam(
          data['hasPrivatePool'],
          ParamType.String,
          false,
        ),
        landLeaseAmount: deserializeParam(
          data['landLeaseAmount'],
          ParamType.String,
          false,
        ),
        waterSource: deserializeParam<String>(
          data['waterSource'],
          ParamType.String,
          true,
        ),
        exteriorFeatures: deserializeParam<String>(
          data['exteriorFeatures'],
          ParamType.String,
          true,
        ),
        inclusions: deserializeParam(
          data['inclusions'],
          ParamType.String,
          false,
        ),
        gas: deserializeParam(
          data['gas'],
          ParamType.String,
          false,
        ),
        propertyCondition: deserializeParam(
          data['propertyCondition'],
          ParamType.String,
          false,
        ),
        elevationUnits: deserializeParam(
          data['elevationUnits'],
          ParamType.String,
          false,
        ),
        exclusions: deserializeParam(
          data['exclusions'],
          ParamType.String,
          false,
        ),
        mainLevelBedrooms: deserializeParam(
          data['mainLevelBedrooms'],
          ParamType.String,
          false,
        ),
        numberOfUnitsVacant: deserializeParam(
          data['numberOfUnitsVacant'],
          ParamType.String,
          false,
        ),
        hasWaterfrontView: deserializeParam(
          data['hasWaterfrontView'],
          ParamType.String,
          false,
        ),
        bathroomsOneQuarter: deserializeParam(
          data['bathroomsOneQuarter'],
          ParamType.String,
          false,
        ),
        lotSize: deserializeParam(
          data['lotSize'],
          ParamType.String,
          false,
        ),
        entryLevel: deserializeParam(
          data['entryLevel'],
          ParamType.String,
          false,
        ),
        irrigationWaterRightsAcres: deserializeParam(
          data['irrigationWaterRightsAcres'],
          ParamType.String,
          false,
        ),
        greenWaterConservation: deserializeParam(
          data['greenWaterConservation'],
          ParamType.String,
          false,
        ),
        stories: deserializeParam(
          data['stories'],
          ParamType.int,
          false,
        ),
        livingArea: deserializeParam(
          data['livingArea'],
          ParamType.String,
          false,
        ),
        commonWalls: deserializeParam(
          data['commonWalls'],
          ParamType.String,
          false,
        ),
        listingTerms: deserializeParam(
          data['listingTerms'],
          ParamType.String,
          false,
        ),
        otherParking: deserializeParam(
          data['otherParking'],
          ParamType.String,
          false,
        ),
        associationFee: deserializeParam(
          data['associationFee'],
          ParamType.String,
          false,
        ),
        marketingType: deserializeParam(
          data['marketingType'],
          ParamType.String,
          false,
        ),
        greenIndoorAirQuality: deserializeParam(
          data['greenIndoorAirQuality'],
          ParamType.String,
          false,
        ),
        greenSustainability: deserializeParam(
          data['greenSustainability'],
          ParamType.String,
          false,
        ),
        livingAreaRangeUnits: deserializeParam(
          data['livingAreaRangeUnits'],
          ParamType.String,
          false,
        ),
        associationPhone: deserializeParam(
          data['associationPhone'],
          ParamType.String,
          false,
        ),
        greenBuildingVerificationType: deserializeParam(
          data['greenBuildingVerificationType'],
          ParamType.String,
          false,
        ),
        hasAttachedGarage: deserializeParam(
          data['hasAttachedGarage'],
          ParamType.bool,
          false,
        ),
        bedrooms: deserializeParam(
          data['bedrooms'],
          ParamType.int,
          false,
        ),
        architecturalStyle: deserializeParam(
          data['architecturalStyle'],
          ParamType.String,
          false,
        ),
        listingId: deserializeParam(
          data['listingId'],
          ParamType.String,
          false,
        ),
        structureType: deserializeParam(
          data['structureType'],
          ParamType.String,
          false,
        ),
        interiorFeatures: deserializeParam<String>(
          data['interiorFeatures'],
          ParamType.String,
          true,
        ),
        horseAmenities: deserializeParam(
          data['horseAmenities'],
          ParamType.String,
          false,
        ),
        garageParkingCapacity: deserializeParam(
          data['garageParkingCapacity'],
          ParamType.int,
          false,
        ),
        developmentStatus: deserializeParam(
          data['developmentStatus'],
          ParamType.String,
          false,
        ),
        lotFeatures: deserializeParam(
          data['lotFeatures'],
          ParamType.String,
          false,
        ),
        roofType: deserializeParam(
          data['roofType'],
          ParamType.String,
          false,
        ),
        compensationBasedOn: deserializeParam(
          data['compensationBasedOn'],
          ParamType.String,
          false,
        ),
        greenEnergyGeneration: deserializeParam(
          data['greenEnergyGeneration'],
          ParamType.String,
          false,
        ),
        daysOnZillow: deserializeParam(
          data['daysOnZillow'],
          ParamType.int,
          false,
        ),
        listAOR: deserializeParam(
          data['listAOR'],
          ParamType.String,
          false,
        ),
        buildingAreaSource: deserializeParam(
          data['buildingAreaSource'],
          ParamType.String,
          false,
        ),
        elementarySchool: deserializeParam(
          data['elementarySchool'],
          ParamType.String,
          false,
        ),
        zoningDescription: deserializeParam(
          data['zoningDescription'],
          ParamType.String,
          false,
        ),
        constructionMaterials: deserializeParam<String>(
          data['constructionMaterials'],
          ParamType.String,
          true,
        ),
        fireplaceFeatures: deserializeParam(
          data['fireplaceFeatures'],
          ParamType.String,
          false,
        ),
        hoaFeeTotal: deserializeParam(
          data['hoaFeeTotal'],
          ParamType.String,
          false,
        ),
        appliances: deserializeParam<String>(
          data['appliances'],
          ParamType.String,
          true,
        ),
        builderModel: deserializeParam(
          data['builderModel'],
          ParamType.String,
          false,
        ),
        bathroomsPartial: deserializeParam(
          data['bathroomsPartial'],
          ParamType.String,
          false,
        ),
        fencing: deserializeParam(
          data['fencing'],
          ParamType.String,
          false,
        ),
        yearBuiltEffective: deserializeParam(
          data['yearBuiltEffective'],
          ParamType.int,
          false,
        ),
        waterfrontFeatures: deserializeParam(
          data['waterfrontFeatures'],
          ParamType.String,
          false,
        ),
        buildingName: deserializeParam(
          data['buildingName'],
          ParamType.String,
          false,
        ),
        attic: deserializeParam(
          data['attic'],
          ParamType.String,
          false,
        ),
        petsMaxWeight: deserializeParam(
          data['petsMaxWeight'],
          ParamType.String,
          false,
        ),
        specialListingConditions: deserializeParam(
          data['specialListingConditions'],
          ParamType.String,
          false,
        ),
        storiesTotal: deserializeParam(
          data['storiesTotal'],
          ParamType.String,
          false,
        ),
        additionalParcelsDescription: deserializeParam(
          data['additionalParcelsDescription'],
          ParamType.String,
          false,
        ),
        canRaiseHorses: deserializeParam(
          data['canRaiseHorses'],
          ParamType.bool,
          false,
        ),
        hasLandLease: deserializeParam(
          data['hasLandLease'],
          ParamType.bool,
          false,
        ),
        isNewConstruction: deserializeParam(
          data['isNewConstruction'],
          ParamType.bool,
          false,
        ),
        waterViewYN: deserializeParam(
          data['waterViewYN'],
          ParamType.bool,
          false,
        ),
        middleOrJuniorSchool: deserializeParam(
          data['middleOrJuniorSchool'],
          ParamType.String,
          false,
        ),
        lotSizeDimensions: deserializeParam(
          data['lotSizeDimensions'],
          ParamType.String,
          false,
        ),
        associationName: deserializeParam(
          data['associationName'],
          ParamType.String,
          false,
        ),
        contingency: deserializeParam(
          data['contingency'],
          ParamType.String,
          false,
        ),
        yearBuilt: deserializeParam(
          data['yearBuilt'],
          ParamType.int,
          false,
        ),
        waterBodyName: deserializeParam(
          data['waterBodyName'],
          ParamType.String,
          false,
        ),
        virtualTour: deserializeParam(
          data['virtualTour'],
          ParamType.String,
          false,
        ),
        bathroomsFull: deserializeParam(
          data['bathroomsFull'],
          ParamType.int,
          false,
        ),
        greenEnergyEfficient: deserializeParam(
          data['greenEnergyEfficient'],
          ParamType.String,
          false,
        ),
        incomeIncludes: deserializeParam(
          data['incomeIncludes'],
          ParamType.String,
          false,
        ),
        highSchool: deserializeParam(
          data['highSchool'],
          ParamType.String,
          false,
        ),
        utilities: deserializeParam(
          data['utilities'],
          ParamType.String,
          false,
        ),
        totalActualRent: deserializeParam(
          data['totalActualRent'],
          ParamType.String,
          false,
        ),
        parkingCapacity: deserializeParam(
          data['parkingCapacity'],
          ParamType.int,
          false,
        ),
        taxAnnualAmount: deserializeParam(
          data['taxAnnualAmount'],
          ParamType.int,
          false,
        ),
        subdivisionName: deserializeParam(
          data['subdivisionName'],
          ParamType.String,
          false,
        ),
        windowFeatures: deserializeParam<String>(
          data['windowFeatures'],
          ParamType.String,
          true,
        ),
        ownership: deserializeParam(
          data['ownership'],
          ParamType.String,
          false,
        ),
        woodedArea: deserializeParam(
          data['woodedArea'],
          ParamType.String,
          false,
        ),
        middleOrJuniorSchoolDistrict: deserializeParam(
          data['middleOrJuniorSchoolDistrict'],
          ParamType.String,
          false,
        ),
        associationPhone2: deserializeParam(
          data['associationPhone2'],
          ParamType.String,
          false,
        ),
        spaFeatures: deserializeParam(
          data['spaFeatures'],
          ParamType.String,
          false,
        ),
        sewer: deserializeParam<String>(
          data['sewer'],
          ParamType.String,
          true,
        ),
        frontageLength: deserializeParam(
          data['frontageLength'],
          ParamType.String,
          false,
        ),
        openParkingCapacity: deserializeParam(
          data['openParkingCapacity'],
          ParamType.String,
          false,
        ),
        associationAmenities: deserializeParam(
          data['associationAmenities'],
          ParamType.String,
          false,
        ),
        roadSurfaceType: deserializeParam<String>(
          data['roadSurfaceType'],
          ParamType.String,
          true,
        ),
        propertySubType: deserializeParam<String>(
          data['propertySubType'],
          ParamType.String,
          true,
        ),
        coveredParkingCapacity: deserializeParam(
          data['coveredParkingCapacity'],
          ParamType.int,
          false,
        ),
        foundationArea: deserializeParam(
          data['foundationArea'],
          ParamType.String,
          false,
        ),
        zoning: deserializeParam(
          data['zoning'],
          ParamType.String,
          false,
        ),
        hoaFee: deserializeParam(
          data['hoaFee'],
          ParamType.String,
          false,
        ),
        livingAreaRange: deserializeParam(
          data['livingAreaRange'],
          ParamType.String,
          false,
        ),
        hasCarport: deserializeParam(
          data['hasCarport'],
          ParamType.bool,
          false,
        ),
        parkingFeatures: deserializeParam<String>(
          data['parkingFeatures'],
          ParamType.String,
          true,
        ),
        cropsIncludedYN: deserializeParam(
          data['cropsIncludedYN'],
          ParamType.String,
          false,
        ),
        tenantPays: deserializeParam(
          data['tenantPays'],
          ParamType.String,
          false,
        ),
        parcelNumber: deserializeParam(
          data['parcelNumber'],
          ParamType.String,
          false,
        ),
        bathroomsHalf: deserializeParam(
          data['bathroomsHalf'],
          ParamType.int,
          false,
        ),
        otherStructures: deserializeParam(
          data['otherStructures'],
          ParamType.String,
          false,
        ),
        otherFacts: deserializeStructParam(
          data['otherFacts'],
          ParamType.DataStruct,
          false,
          structBuilder: OtherFactsStruct.fromSerializableMap,
        ),
        hasView: deserializeParam(
          data['hasView'],
          ParamType.bool,
          false,
        ),
        additionalFeeInfo: deserializeParam(
          data['additionalFeeInfo'],
          ParamType.String,
          false,
        ),
        securityFeatures: deserializeParam(
          data['securityFeatures'],
          ParamType.String,
          false,
        ),
        onMarketDate: deserializeParam(
          data['onMarketDate'],
          ParamType.int,
          false,
        ),
        numberOfUnitsInCommunity: deserializeParam(
          data['numberOfUnitsInCommunity'],
          ParamType.String,
          false,
        ),
        hasHomeWarranty: deserializeParam(
          data['hasHomeWarranty'],
          ParamType.bool,
          false,
        ),
        basementYN: deserializeParam(
          data['basementYN'],
          ParamType.bool,
          false,
        ),
        ownershipType: deserializeParam(
          data['ownershipType'],
          ParamType.String,
          false,
        ),
        doorFeatures: deserializeParam(
          data['doorFeatures'],
          ParamType.String,
          false,
        ),
        associations: deserializeStructParam(
          data['associations'],
          ParamType.DataStruct,
          false,
          structBuilder: AssociationsStruct.fromSerializableMap,
        ),
        waterView: deserializeParam(
          data['waterView'],
          ParamType.String,
          false,
        ),
        aboveGradeFinishedArea: deserializeParam(
          data['aboveGradeFinishedArea'],
          ParamType.String,
          false,
        ),
        electric: deserializeParam(
          data['electric'],
          ParamType.String,
          false,
        ),
        cumulativeDaysOnMarket: deserializeParam(
          data['cumulativeDaysOnMarket'],
          ParamType.String,
          false,
        ),
        hasOpenParking: deserializeParam(
          data['hasOpenParking'],
          ParamType.bool,
          false,
        ),
        hasElectricOnProperty: deserializeParam(
          data['hasElectricOnProperty'],
          ParamType.String,
          false,
        ),
        homeType: deserializeParam(
          data['homeType'],
          ParamType.String,
          false,
        ),
        municipality: deserializeParam(
          data['municipality'],
          ParamType.String,
          false,
        ),
        bathroomsThreeQuarter: deserializeParam(
          data['bathroomsThreeQuarter'],
          ParamType.int,
          false,
        ),
        hasSpa: deserializeParam(
          data['hasSpa'],
          ParamType.bool,
          false,
        ),
        basement: deserializeParam(
          data['basement'],
          ParamType.String,
          false,
        ),
        associationFee2: deserializeParam(
          data['associationFee2'],
          ParamType.String,
          false,
        ),
        hasHeating: deserializeParam(
          data['hasHeating'],
          ParamType.bool,
          false,
        ),
        associationName2: deserializeParam(
          data['associationName2'],
          ParamType.String,
          false,
        ),
        elementarySchoolDistrict: deserializeParam(
          data['elementarySchoolDistrict'],
          ParamType.String,
          false,
        ),
        otherEquipment: deserializeParam(
          data['otherEquipment'],
          ParamType.String,
          false,
        ),
        bathrooms: deserializeParam(
          data['bathrooms'],
          ParamType.int,
          false,
        ),
        buildingArea: deserializeParam(
          data['buildingArea'],
          ParamType.String,
          false,
        ),
        furnished: deserializeParam(
          data['furnished'],
          ParamType.bool,
          false,
        ),
        vegetation: deserializeParam(
          data['vegetation'],
          ParamType.String,
          false,
        ),
        patioAndPorchFeatures: deserializeParam<String>(
          data['patioAndPorchFeatures'],
          ParamType.String,
          true,
        ),
        builderName: deserializeParam(
          data['builderName'],
          ParamType.String,
          false,
        ),
        highSchoolDistrict: deserializeParam(
          data['highSchoolDistrict'],
          ParamType.String,
          false,
        ),
        entryLocation: deserializeParam(
          data['entryLocation'],
          ParamType.String,
          false,
        ),
        laundryFeatures: deserializeParam(
          data['laundryFeatures'],
          ParamType.String,
          false,
        ),
        buildingFeatures: deserializeParam(
          data['buildingFeatures'],
          ParamType.String,
          false,
        ),
        heating: deserializeParam<String>(
          data['heating'],
          ParamType.String,
          true,
        ),
        availabilityDate: deserializeParam(
          data['availabilityDate'],
          ParamType.String,
          false,
        ),
        carportParkingCapacity: deserializeParam(
          data['carportParkingCapacity'],
          ParamType.int,
          false,
        ),
        hasAssociation: deserializeParam(
          data['hasAssociation'],
          ParamType.String,
          false,
        ),
        irrigationWaterRightsYN: deserializeParam(
          data['irrigationWaterRightsYN'],
          ParamType.String,
          false,
        ),
        associationFeeIncludes: deserializeParam(
          data['associationFeeIncludes'],
          ParamType.String,
          false,
        ),
        leaseTerm: deserializeParam(
          data['leaseTerm'],
          ParamType.String,
          false,
        ),
        levels: deserializeParam(
          data['levels'],
          ParamType.String,
          false,
        ),
        elevation: deserializeParam(
          data['elevation'],
          ParamType.String,
          false,
        ),
        hasRentControl: deserializeParam(
          data['hasRentControl'],
          ParamType.bool,
          false,
        ),
        hasFireplace: deserializeParam(
          data['hasFireplace'],
          ParamType.bool,
          false,
        ),
        hasCooling: deserializeParam(
          data['hasCooling'],
          ParamType.bool,
          false,
        ),
        isSeniorCommunity: deserializeParam(
          data['isSeniorCommunity'],
          ParamType.bool,
          false,
        ),
        cooling: deserializeParam<String>(
          data['cooling'],
          ParamType.String,
          true,
        ),
        fireplaces: deserializeParam<String>(
          data['fireplaces'],
          ParamType.String,
          true,
        ),
        bathroomsFloat: deserializeParam(
          data['bathroomsFloat'],
          ParamType.double,
          false,
        ),
        pricePerSquareFoot: deserializeParam(
          data['pricePerSquareFoot'],
          ParamType.int,
          false,
        ),
        communityFeatures: deserializeParam<String>(
          data['communityFeatures'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'ResoFactsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ResoFactsStruct &&
        hasAttachedProperty == other.hasAttachedProperty &&
        frontageType == other.frontageType &&
        poolFeatures == other.poolFeatures &&
        listEquality.equals(flooring, other.flooring) &&
        listEquality.equals(foundationDetails, other.foundationDetails) &&
        accessibilityFeatures == other.accessibilityFeatures &&
        hasGarage == other.hasGarage &&
        hasPetsAllowed == other.hasPetsAllowed &&
        bodyType == other.bodyType &&
        topography == other.topography &&
        landLeaseExpirationDate == other.landLeaseExpirationDate &&
        hasAdditionalParcels == other.hasAdditionalParcels &&
        parkName == other.parkName &&
        livingQuarters == other.livingQuarters &&
        taxAssessedValue == other.taxAssessedValue &&
        listEquality.equals(atAGlanceFacts, other.atAGlanceFacts) &&
        offerReviewDate == other.offerReviewDate &&
        horseYN == other.horseYN &&
        listEquality.equals(view, other.view) &&
        rooms == other.rooms &&
        belowGradeFinishedArea == other.belowGradeFinishedArea &&
        feesAndDues == other.feesAndDues &&
        cityRegion == other.cityRegion &&
        mainLevelBathrooms == other.mainLevelBathrooms &&
        hasPrivatePool == other.hasPrivatePool &&
        landLeaseAmount == other.landLeaseAmount &&
        listEquality.equals(waterSource, other.waterSource) &&
        listEquality.equals(exteriorFeatures, other.exteriorFeatures) &&
        inclusions == other.inclusions &&
        gas == other.gas &&
        propertyCondition == other.propertyCondition &&
        elevationUnits == other.elevationUnits &&
        exclusions == other.exclusions &&
        mainLevelBedrooms == other.mainLevelBedrooms &&
        numberOfUnitsVacant == other.numberOfUnitsVacant &&
        hasWaterfrontView == other.hasWaterfrontView &&
        bathroomsOneQuarter == other.bathroomsOneQuarter &&
        lotSize == other.lotSize &&
        entryLevel == other.entryLevel &&
        irrigationWaterRightsAcres == other.irrigationWaterRightsAcres &&
        greenWaterConservation == other.greenWaterConservation &&
        stories == other.stories &&
        livingArea == other.livingArea &&
        commonWalls == other.commonWalls &&
        listingTerms == other.listingTerms &&
        otherParking == other.otherParking &&
        associationFee == other.associationFee &&
        marketingType == other.marketingType &&
        greenIndoorAirQuality == other.greenIndoorAirQuality &&
        greenSustainability == other.greenSustainability &&
        livingAreaRangeUnits == other.livingAreaRangeUnits &&
        associationPhone == other.associationPhone &&
        greenBuildingVerificationType == other.greenBuildingVerificationType &&
        hasAttachedGarage == other.hasAttachedGarage &&
        bedrooms == other.bedrooms &&
        architecturalStyle == other.architecturalStyle &&
        listingId == other.listingId &&
        structureType == other.structureType &&
        listEquality.equals(interiorFeatures, other.interiorFeatures) &&
        horseAmenities == other.horseAmenities &&
        garageParkingCapacity == other.garageParkingCapacity &&
        developmentStatus == other.developmentStatus &&
        lotFeatures == other.lotFeatures &&
        roofType == other.roofType &&
        compensationBasedOn == other.compensationBasedOn &&
        greenEnergyGeneration == other.greenEnergyGeneration &&
        daysOnZillow == other.daysOnZillow &&
        listAOR == other.listAOR &&
        buildingAreaSource == other.buildingAreaSource &&
        elementarySchool == other.elementarySchool &&
        zoningDescription == other.zoningDescription &&
        listEquality.equals(
            constructionMaterials, other.constructionMaterials) &&
        fireplaceFeatures == other.fireplaceFeatures &&
        hoaFeeTotal == other.hoaFeeTotal &&
        listEquality.equals(appliances, other.appliances) &&
        builderModel == other.builderModel &&
        bathroomsPartial == other.bathroomsPartial &&
        fencing == other.fencing &&
        yearBuiltEffective == other.yearBuiltEffective &&
        waterfrontFeatures == other.waterfrontFeatures &&
        buildingName == other.buildingName &&
        attic == other.attic &&
        petsMaxWeight == other.petsMaxWeight &&
        specialListingConditions == other.specialListingConditions &&
        storiesTotal == other.storiesTotal &&
        additionalParcelsDescription == other.additionalParcelsDescription &&
        canRaiseHorses == other.canRaiseHorses &&
        hasLandLease == other.hasLandLease &&
        isNewConstruction == other.isNewConstruction &&
        waterViewYN == other.waterViewYN &&
        middleOrJuniorSchool == other.middleOrJuniorSchool &&
        lotSizeDimensions == other.lotSizeDimensions &&
        associationName == other.associationName &&
        contingency == other.contingency &&
        yearBuilt == other.yearBuilt &&
        waterBodyName == other.waterBodyName &&
        virtualTour == other.virtualTour &&
        bathroomsFull == other.bathroomsFull &&
        greenEnergyEfficient == other.greenEnergyEfficient &&
        incomeIncludes == other.incomeIncludes &&
        highSchool == other.highSchool &&
        utilities == other.utilities &&
        totalActualRent == other.totalActualRent &&
        parkingCapacity == other.parkingCapacity &&
        taxAnnualAmount == other.taxAnnualAmount &&
        subdivisionName == other.subdivisionName &&
        listEquality.equals(windowFeatures, other.windowFeatures) &&
        ownership == other.ownership &&
        woodedArea == other.woodedArea &&
        middleOrJuniorSchoolDistrict == other.middleOrJuniorSchoolDistrict &&
        associationPhone2 == other.associationPhone2 &&
        spaFeatures == other.spaFeatures &&
        listEquality.equals(sewer, other.sewer) &&
        frontageLength == other.frontageLength &&
        openParkingCapacity == other.openParkingCapacity &&
        associationAmenities == other.associationAmenities &&
        listEquality.equals(roadSurfaceType, other.roadSurfaceType) &&
        listEquality.equals(propertySubType, other.propertySubType) &&
        coveredParkingCapacity == other.coveredParkingCapacity &&
        foundationArea == other.foundationArea &&
        zoning == other.zoning &&
        hoaFee == other.hoaFee &&
        livingAreaRange == other.livingAreaRange &&
        hasCarport == other.hasCarport &&
        listEquality.equals(parkingFeatures, other.parkingFeatures) &&
        cropsIncludedYN == other.cropsIncludedYN &&
        tenantPays == other.tenantPays &&
        parcelNumber == other.parcelNumber &&
        bathroomsHalf == other.bathroomsHalf &&
        otherStructures == other.otherStructures &&
        otherFacts == other.otherFacts &&
        hasView == other.hasView &&
        additionalFeeInfo == other.additionalFeeInfo &&
        securityFeatures == other.securityFeatures &&
        onMarketDate == other.onMarketDate &&
        numberOfUnitsInCommunity == other.numberOfUnitsInCommunity &&
        hasHomeWarranty == other.hasHomeWarranty &&
        basementYN == other.basementYN &&
        ownershipType == other.ownershipType &&
        doorFeatures == other.doorFeatures &&
        associations == other.associations &&
        waterView == other.waterView &&
        aboveGradeFinishedArea == other.aboveGradeFinishedArea &&
        electric == other.electric &&
        cumulativeDaysOnMarket == other.cumulativeDaysOnMarket &&
        hasOpenParking == other.hasOpenParking &&
        hasElectricOnProperty == other.hasElectricOnProperty &&
        homeType == other.homeType &&
        municipality == other.municipality &&
        bathroomsThreeQuarter == other.bathroomsThreeQuarter &&
        hasSpa == other.hasSpa &&
        basement == other.basement &&
        associationFee2 == other.associationFee2 &&
        hasHeating == other.hasHeating &&
        associationName2 == other.associationName2 &&
        elementarySchoolDistrict == other.elementarySchoolDistrict &&
        otherEquipment == other.otherEquipment &&
        bathrooms == other.bathrooms &&
        buildingArea == other.buildingArea &&
        furnished == other.furnished &&
        vegetation == other.vegetation &&
        listEquality.equals(
            patioAndPorchFeatures, other.patioAndPorchFeatures) &&
        builderName == other.builderName &&
        highSchoolDistrict == other.highSchoolDistrict &&
        entryLocation == other.entryLocation &&
        laundryFeatures == other.laundryFeatures &&
        buildingFeatures == other.buildingFeatures &&
        listEquality.equals(heating, other.heating) &&
        availabilityDate == other.availabilityDate &&
        carportParkingCapacity == other.carportParkingCapacity &&
        hasAssociation == other.hasAssociation &&
        irrigationWaterRightsYN == other.irrigationWaterRightsYN &&
        associationFeeIncludes == other.associationFeeIncludes &&
        leaseTerm == other.leaseTerm &&
        levels == other.levels &&
        elevation == other.elevation &&
        hasRentControl == other.hasRentControl &&
        hasFireplace == other.hasFireplace &&
        hasCooling == other.hasCooling &&
        isSeniorCommunity == other.isSeniorCommunity &&
        listEquality.equals(cooling, other.cooling) &&
        listEquality.equals(fireplaces, other.fireplaces) &&
        bathroomsFloat == other.bathroomsFloat &&
        pricePerSquareFoot == other.pricePerSquareFoot &&
        listEquality.equals(communityFeatures, other.communityFeatures);
  }

  @override
  int get hashCode => const ListEquality().hash([
        hasAttachedProperty,
        frontageType,
        poolFeatures,
        flooring,
        foundationDetails,
        accessibilityFeatures,
        hasGarage,
        hasPetsAllowed,
        bodyType,
        topography,
        landLeaseExpirationDate,
        hasAdditionalParcels,
        parkName,
        livingQuarters,
        taxAssessedValue,
        atAGlanceFacts,
        offerReviewDate,
        horseYN,
        view,
        rooms,
        belowGradeFinishedArea,
        feesAndDues,
        cityRegion,
        mainLevelBathrooms,
        hasPrivatePool,
        landLeaseAmount,
        waterSource,
        exteriorFeatures,
        inclusions,
        gas,
        propertyCondition,
        elevationUnits,
        exclusions,
        mainLevelBedrooms,
        numberOfUnitsVacant,
        hasWaterfrontView,
        bathroomsOneQuarter,
        lotSize,
        entryLevel,
        irrigationWaterRightsAcres,
        greenWaterConservation,
        stories,
        livingArea,
        commonWalls,
        listingTerms,
        otherParking,
        associationFee,
        marketingType,
        greenIndoorAirQuality,
        greenSustainability,
        livingAreaRangeUnits,
        associationPhone,
        greenBuildingVerificationType,
        hasAttachedGarage,
        bedrooms,
        architecturalStyle,
        listingId,
        structureType,
        interiorFeatures,
        horseAmenities,
        garageParkingCapacity,
        developmentStatus,
        lotFeatures,
        roofType,
        compensationBasedOn,
        greenEnergyGeneration,
        daysOnZillow,
        listAOR,
        buildingAreaSource,
        elementarySchool,
        zoningDescription,
        constructionMaterials,
        fireplaceFeatures,
        hoaFeeTotal,
        appliances,
        builderModel,
        bathroomsPartial,
        fencing,
        yearBuiltEffective,
        waterfrontFeatures,
        buildingName,
        attic,
        petsMaxWeight,
        specialListingConditions,
        storiesTotal,
        additionalParcelsDescription,
        canRaiseHorses,
        hasLandLease,
        isNewConstruction,
        waterViewYN,
        middleOrJuniorSchool,
        lotSizeDimensions,
        associationName,
        contingency,
        yearBuilt,
        waterBodyName,
        virtualTour,
        bathroomsFull,
        greenEnergyEfficient,
        incomeIncludes,
        highSchool,
        utilities,
        totalActualRent,
        parkingCapacity,
        taxAnnualAmount,
        subdivisionName,
        windowFeatures,
        ownership,
        woodedArea,
        middleOrJuniorSchoolDistrict,
        associationPhone2,
        spaFeatures,
        sewer,
        frontageLength,
        openParkingCapacity,
        associationAmenities,
        roadSurfaceType,
        propertySubType,
        coveredParkingCapacity,
        foundationArea,
        zoning,
        hoaFee,
        livingAreaRange,
        hasCarport,
        parkingFeatures,
        cropsIncludedYN,
        tenantPays,
        parcelNumber,
        bathroomsHalf,
        otherStructures,
        otherFacts,
        hasView,
        additionalFeeInfo,
        securityFeatures,
        onMarketDate,
        numberOfUnitsInCommunity,
        hasHomeWarranty,
        basementYN,
        ownershipType,
        doorFeatures,
        associations,
        waterView,
        aboveGradeFinishedArea,
        electric,
        cumulativeDaysOnMarket,
        hasOpenParking,
        hasElectricOnProperty,
        homeType,
        municipality,
        bathroomsThreeQuarter,
        hasSpa,
        basement,
        associationFee2,
        hasHeating,
        associationName2,
        elementarySchoolDistrict,
        otherEquipment,
        bathrooms,
        buildingArea,
        furnished,
        vegetation,
        patioAndPorchFeatures,
        builderName,
        highSchoolDistrict,
        entryLocation,
        laundryFeatures,
        buildingFeatures,
        heating,
        availabilityDate,
        carportParkingCapacity,
        hasAssociation,
        irrigationWaterRightsYN,
        associationFeeIncludes,
        leaseTerm,
        levels,
        elevation,
        hasRentControl,
        hasFireplace,
        hasCooling,
        isSeniorCommunity,
        cooling,
        fireplaces,
        bathroomsFloat,
        pricePerSquareFoot,
        communityFeatures
      ]);
}

ResoFactsStruct createResoFactsStruct({
  bool? hasAttachedProperty,
  String? frontageType,
  String? poolFeatures,
  String? accessibilityFeatures,
  bool? hasGarage,
  String? hasPetsAllowed,
  String? bodyType,
  String? topography,
  String? landLeaseExpirationDate,
  bool? hasAdditionalParcels,
  String? parkName,
  LivingQuartersStruct? livingQuarters,
  int? taxAssessedValue,
  String? offerReviewDate,
  String? horseYN,
  RoomsStruct? rooms,
  String? belowGradeFinishedArea,
  FeesAndDuesStruct? feesAndDues,
  String? cityRegion,
  String? mainLevelBathrooms,
  String? hasPrivatePool,
  String? landLeaseAmount,
  String? inclusions,
  String? gas,
  String? propertyCondition,
  String? elevationUnits,
  String? exclusions,
  String? mainLevelBedrooms,
  String? numberOfUnitsVacant,
  String? hasWaterfrontView,
  String? bathroomsOneQuarter,
  String? lotSize,
  String? entryLevel,
  String? irrigationWaterRightsAcres,
  String? greenWaterConservation,
  int? stories,
  String? livingArea,
  String? commonWalls,
  String? listingTerms,
  String? otherParking,
  String? associationFee,
  String? marketingType,
  String? greenIndoorAirQuality,
  String? greenSustainability,
  String? livingAreaRangeUnits,
  String? associationPhone,
  String? greenBuildingVerificationType,
  bool? hasAttachedGarage,
  int? bedrooms,
  String? architecturalStyle,
  String? listingId,
  String? structureType,
  String? horseAmenities,
  int? garageParkingCapacity,
  String? developmentStatus,
  String? lotFeatures,
  String? roofType,
  String? compensationBasedOn,
  String? greenEnergyGeneration,
  int? daysOnZillow,
  String? listAOR,
  String? buildingAreaSource,
  String? elementarySchool,
  String? zoningDescription,
  String? fireplaceFeatures,
  String? hoaFeeTotal,
  String? builderModel,
  String? bathroomsPartial,
  String? fencing,
  int? yearBuiltEffective,
  String? waterfrontFeatures,
  String? buildingName,
  String? attic,
  String? petsMaxWeight,
  String? specialListingConditions,
  String? storiesTotal,
  String? additionalParcelsDescription,
  bool? canRaiseHorses,
  bool? hasLandLease,
  bool? isNewConstruction,
  bool? waterViewYN,
  String? middleOrJuniorSchool,
  String? lotSizeDimensions,
  String? associationName,
  String? contingency,
  int? yearBuilt,
  String? waterBodyName,
  String? virtualTour,
  int? bathroomsFull,
  String? greenEnergyEfficient,
  String? incomeIncludes,
  String? highSchool,
  String? utilities,
  String? totalActualRent,
  int? parkingCapacity,
  int? taxAnnualAmount,
  String? subdivisionName,
  String? ownership,
  String? woodedArea,
  String? middleOrJuniorSchoolDistrict,
  String? associationPhone2,
  String? spaFeatures,
  String? frontageLength,
  String? openParkingCapacity,
  String? associationAmenities,
  int? coveredParkingCapacity,
  String? foundationArea,
  String? zoning,
  String? hoaFee,
  String? livingAreaRange,
  bool? hasCarport,
  String? cropsIncludedYN,
  String? tenantPays,
  String? parcelNumber,
  int? bathroomsHalf,
  String? otherStructures,
  OtherFactsStruct? otherFacts,
  bool? hasView,
  String? additionalFeeInfo,
  String? securityFeatures,
  int? onMarketDate,
  String? numberOfUnitsInCommunity,
  bool? hasHomeWarranty,
  bool? basementYN,
  String? ownershipType,
  String? doorFeatures,
  AssociationsStruct? associations,
  String? waterView,
  String? aboveGradeFinishedArea,
  String? electric,
  String? cumulativeDaysOnMarket,
  bool? hasOpenParking,
  String? hasElectricOnProperty,
  String? homeType,
  String? municipality,
  int? bathroomsThreeQuarter,
  bool? hasSpa,
  String? basement,
  String? associationFee2,
  bool? hasHeating,
  String? associationName2,
  String? elementarySchoolDistrict,
  String? otherEquipment,
  int? bathrooms,
  String? buildingArea,
  bool? furnished,
  String? vegetation,
  String? builderName,
  String? highSchoolDistrict,
  String? entryLocation,
  String? laundryFeatures,
  String? buildingFeatures,
  String? availabilityDate,
  int? carportParkingCapacity,
  String? hasAssociation,
  String? irrigationWaterRightsYN,
  String? associationFeeIncludes,
  String? leaseTerm,
  String? levels,
  String? elevation,
  bool? hasRentControl,
  bool? hasFireplace,
  bool? hasCooling,
  bool? isSeniorCommunity,
  double? bathroomsFloat,
  int? pricePerSquareFoot,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ResoFactsStruct(
      hasAttachedProperty: hasAttachedProperty,
      frontageType: frontageType,
      poolFeatures: poolFeatures,
      accessibilityFeatures: accessibilityFeatures,
      hasGarage: hasGarage,
      hasPetsAllowed: hasPetsAllowed,
      bodyType: bodyType,
      topography: topography,
      landLeaseExpirationDate: landLeaseExpirationDate,
      hasAdditionalParcels: hasAdditionalParcels,
      parkName: parkName,
      livingQuarters:
          livingQuarters ?? (clearUnsetFields ? LivingQuartersStruct() : null),
      taxAssessedValue: taxAssessedValue,
      offerReviewDate: offerReviewDate,
      horseYN: horseYN,
      rooms: rooms ?? (clearUnsetFields ? RoomsStruct() : null),
      belowGradeFinishedArea: belowGradeFinishedArea,
      feesAndDues:
          feesAndDues ?? (clearUnsetFields ? FeesAndDuesStruct() : null),
      cityRegion: cityRegion,
      mainLevelBathrooms: mainLevelBathrooms,
      hasPrivatePool: hasPrivatePool,
      landLeaseAmount: landLeaseAmount,
      inclusions: inclusions,
      gas: gas,
      propertyCondition: propertyCondition,
      elevationUnits: elevationUnits,
      exclusions: exclusions,
      mainLevelBedrooms: mainLevelBedrooms,
      numberOfUnitsVacant: numberOfUnitsVacant,
      hasWaterfrontView: hasWaterfrontView,
      bathroomsOneQuarter: bathroomsOneQuarter,
      lotSize: lotSize,
      entryLevel: entryLevel,
      irrigationWaterRightsAcres: irrigationWaterRightsAcres,
      greenWaterConservation: greenWaterConservation,
      stories: stories,
      livingArea: livingArea,
      commonWalls: commonWalls,
      listingTerms: listingTerms,
      otherParking: otherParking,
      associationFee: associationFee,
      marketingType: marketingType,
      greenIndoorAirQuality: greenIndoorAirQuality,
      greenSustainability: greenSustainability,
      livingAreaRangeUnits: livingAreaRangeUnits,
      associationPhone: associationPhone,
      greenBuildingVerificationType: greenBuildingVerificationType,
      hasAttachedGarage: hasAttachedGarage,
      bedrooms: bedrooms,
      architecturalStyle: architecturalStyle,
      listingId: listingId,
      structureType: structureType,
      horseAmenities: horseAmenities,
      garageParkingCapacity: garageParkingCapacity,
      developmentStatus: developmentStatus,
      lotFeatures: lotFeatures,
      roofType: roofType,
      compensationBasedOn: compensationBasedOn,
      greenEnergyGeneration: greenEnergyGeneration,
      daysOnZillow: daysOnZillow,
      listAOR: listAOR,
      buildingAreaSource: buildingAreaSource,
      elementarySchool: elementarySchool,
      zoningDescription: zoningDescription,
      fireplaceFeatures: fireplaceFeatures,
      hoaFeeTotal: hoaFeeTotal,
      builderModel: builderModel,
      bathroomsPartial: bathroomsPartial,
      fencing: fencing,
      yearBuiltEffective: yearBuiltEffective,
      waterfrontFeatures: waterfrontFeatures,
      buildingName: buildingName,
      attic: attic,
      petsMaxWeight: petsMaxWeight,
      specialListingConditions: specialListingConditions,
      storiesTotal: storiesTotal,
      additionalParcelsDescription: additionalParcelsDescription,
      canRaiseHorses: canRaiseHorses,
      hasLandLease: hasLandLease,
      isNewConstruction: isNewConstruction,
      waterViewYN: waterViewYN,
      middleOrJuniorSchool: middleOrJuniorSchool,
      lotSizeDimensions: lotSizeDimensions,
      associationName: associationName,
      contingency: contingency,
      yearBuilt: yearBuilt,
      waterBodyName: waterBodyName,
      virtualTour: virtualTour,
      bathroomsFull: bathroomsFull,
      greenEnergyEfficient: greenEnergyEfficient,
      incomeIncludes: incomeIncludes,
      highSchool: highSchool,
      utilities: utilities,
      totalActualRent: totalActualRent,
      parkingCapacity: parkingCapacity,
      taxAnnualAmount: taxAnnualAmount,
      subdivisionName: subdivisionName,
      ownership: ownership,
      woodedArea: woodedArea,
      middleOrJuniorSchoolDistrict: middleOrJuniorSchoolDistrict,
      associationPhone2: associationPhone2,
      spaFeatures: spaFeatures,
      frontageLength: frontageLength,
      openParkingCapacity: openParkingCapacity,
      associationAmenities: associationAmenities,
      coveredParkingCapacity: coveredParkingCapacity,
      foundationArea: foundationArea,
      zoning: zoning,
      hoaFee: hoaFee,
      livingAreaRange: livingAreaRange,
      hasCarport: hasCarport,
      cropsIncludedYN: cropsIncludedYN,
      tenantPays: tenantPays,
      parcelNumber: parcelNumber,
      bathroomsHalf: bathroomsHalf,
      otherStructures: otherStructures,
      otherFacts: otherFacts ?? (clearUnsetFields ? OtherFactsStruct() : null),
      hasView: hasView,
      additionalFeeInfo: additionalFeeInfo,
      securityFeatures: securityFeatures,
      onMarketDate: onMarketDate,
      numberOfUnitsInCommunity: numberOfUnitsInCommunity,
      hasHomeWarranty: hasHomeWarranty,
      basementYN: basementYN,
      ownershipType: ownershipType,
      doorFeatures: doorFeatures,
      associations:
          associations ?? (clearUnsetFields ? AssociationsStruct() : null),
      waterView: waterView,
      aboveGradeFinishedArea: aboveGradeFinishedArea,
      electric: electric,
      cumulativeDaysOnMarket: cumulativeDaysOnMarket,
      hasOpenParking: hasOpenParking,
      hasElectricOnProperty: hasElectricOnProperty,
      homeType: homeType,
      municipality: municipality,
      bathroomsThreeQuarter: bathroomsThreeQuarter,
      hasSpa: hasSpa,
      basement: basement,
      associationFee2: associationFee2,
      hasHeating: hasHeating,
      associationName2: associationName2,
      elementarySchoolDistrict: elementarySchoolDistrict,
      otherEquipment: otherEquipment,
      bathrooms: bathrooms,
      buildingArea: buildingArea,
      furnished: furnished,
      vegetation: vegetation,
      builderName: builderName,
      highSchoolDistrict: highSchoolDistrict,
      entryLocation: entryLocation,
      laundryFeatures: laundryFeatures,
      buildingFeatures: buildingFeatures,
      availabilityDate: availabilityDate,
      carportParkingCapacity: carportParkingCapacity,
      hasAssociation: hasAssociation,
      irrigationWaterRightsYN: irrigationWaterRightsYN,
      associationFeeIncludes: associationFeeIncludes,
      leaseTerm: leaseTerm,
      levels: levels,
      elevation: elevation,
      hasRentControl: hasRentControl,
      hasFireplace: hasFireplace,
      hasCooling: hasCooling,
      isSeniorCommunity: isSeniorCommunity,
      bathroomsFloat: bathroomsFloat,
      pricePerSquareFoot: pricePerSquareFoot,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ResoFactsStruct? updateResoFactsStruct(
  ResoFactsStruct? resoFacts, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    resoFacts
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addResoFactsStructData(
  Map<String, dynamic> firestoreData,
  ResoFactsStruct? resoFacts,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (resoFacts == null) {
    return;
  }
  if (resoFacts.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && resoFacts.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final resoFactsData = getResoFactsFirestoreData(resoFacts, forFieldValue);
  final nestedData = resoFactsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = resoFacts.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getResoFactsFirestoreData(
  ResoFactsStruct? resoFacts, [
  bool forFieldValue = false,
]) {
  if (resoFacts == null) {
    return {};
  }
  final firestoreData = mapToFirestore(resoFacts.toMap());

  // Handle nested data for "livingQuarters" field.
  addLivingQuartersStructData(
    firestoreData,
    resoFacts.hasLivingQuarters() ? resoFacts.livingQuarters : null,
    'livingQuarters',
    forFieldValue,
  );

  // Handle nested data for "rooms" field.
  addRoomsStructData(
    firestoreData,
    resoFacts.hasRooms() ? resoFacts.rooms : null,
    'rooms',
    forFieldValue,
  );

  // Handle nested data for "feesAndDues" field.
  addFeesAndDuesStructData(
    firestoreData,
    resoFacts.hasFeesAndDues() ? resoFacts.feesAndDues : null,
    'feesAndDues',
    forFieldValue,
  );

  // Handle nested data for "otherFacts" field.
  addOtherFactsStructData(
    firestoreData,
    resoFacts.hasOtherFacts() ? resoFacts.otherFacts : null,
    'otherFacts',
    forFieldValue,
  );

  // Handle nested data for "associations" field.
  addAssociationsStructData(
    firestoreData,
    resoFacts.hasAssociations() ? resoFacts.associations : null,
    'associations',
    forFieldValue,
  );

  // Add any Firestore field values
  resoFacts.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getResoFactsListFirestoreData(
  List<ResoFactsStruct>? resoFactss,
) =>
    resoFactss?.map((e) => getResoFactsFirestoreData(e, true)).toList() ?? [];
