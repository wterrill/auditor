// List<String> audit1Sections = [
//   'Confirm Details',
//   'Intro',
//   'Signage',
//   'Distribution & Intake',
//   'Dry Storage',
//   'Cold Storage',
//   'Other',
//   'Complaints & Problems',
//   'Review',
//   'Verification'
// ];

List<Map<String, dynamic>> confirmDetails = [
  <String, dynamic>{'text': 'Date of Visit:', 'type': 'display'},
  <String, dynamic>{'text': 'Start Time:', 'type': 'display'},
  <String, dynamic>{'text': 'Type of Visit:', 'type': 'display'},
  <String, dynamic>{'text': 'Agency Name:', 'type': 'display'},
  <String, dynamic>{'text': 'Agency/Program Number:', 'type': 'display'},
  <String, dynamic>{'text': 'Site Address:', 'type': 'display'},
  <String, dynamic>{'text': 'GCFD Monitor:', 'type': 'display'},
  <String, dynamic>{'text': 'Program Contact:', 'type': 'display'},
  // The following three fields MUST be in this order
  // 1. fillInEmailInterview
  // 2. FillInEmail
  // 3. FillInInterview
  // This is due to the FillInEmailInterview field on the Confirm Details screen
  <String, dynamic>{
    // 'text': 'Email Contact and Person Interview:',
    // 'textEmail': 'Email Contact:',
    // 'textInterview': "Person Interviewed",
    'type': 'fillInEmailInterview',
    // 'databaseVarInterview': 'PersonInterviewed',
    // 'databaseVarEmail': 'ContactEmail',
    // 'databaseVarType': 'List<String>'
  },
  <String, dynamic>{
    'text': 'Email Contact:',
    'type': 'fillInEmail',
    'databaseVar': 'ContactEmail',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Person Interviewed:',
    'type': 'fillInInterview',
    'databaseVar': 'PersonInterviewed',
    'databaseVarType': 'string'
  },
  <String, dynamic>{'text': 'Program Operating Hours:', 'type': 'display'},
  <String, dynamic>{'text': 'Service Area:', 'type': 'display'},
];

List<Map<String, dynamic>> audit1Section1Questions = [
  <String, dynamic>{
    'text': 'Did the Food Depository establish the service area?',
    'type': 'yesNo',
    'databaseVar': 'GCFDEstablishedServiceArea',
    'databaseVarType': 'bool',
    'databaseOptCom': 'GCFDEstablishedServiceAreaComments',
  },
  <String, dynamic>{
    'text': 'Does pantry serve outside this service area?',
    'type': 'yesNo',
    'databaseVar': 'PantryServesOutsideServiceArea',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PantryServesOutsideServiceAreaComments'
  },
  <String, dynamic>{
    'text': 'If yes, how many and from where do guests travel?',
    'type': 'fillIn',
    'databaseVar': 'HowManyGuestsTravel',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'How often can a guest receive food from the pantry?',
    'type': 'dropDown',
    'menuItems': ['Select', '1x per Week', '2x per Month', '1x per Month', 'Other', 'N/A'],
    'happyPathResponse': ['1x per Week', '2x per Month', '1x per Month', 'Other', 'N/A'],
    'databaseVar': 'HowOftenGuestsReceiveFood',
    'databaseVarType': 'string',
    'databaseOptCom': 'HowOftenGuestsReceiveFoodComments'
  },
  <String, dynamic>{
    'text': 'Does the pantry allow guests to receive food at least once every 30 days?',
    'type': 'yesNo',
    'scoring': 1,
    'happyPathResponse': ['Yes'],
    'databaseVar': 'PantryAllowsFoodAtLeast30Days',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PantryAllowsFoodAtLeast30DaysComments',
    'actionItem': 'Guests must be served at least once every 30 days'
  },
  <String, dynamic>{
    'text': 'Are referrals from an outside agency required to receive food?',
    'type': 'yesNo',
    'scoring': 1,
    'happyPathResponse': ['No'],
    'databaseVar': 'ReferralsRequired',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ReferralsRequiredComments',
    'actionItem': 'Agency must not require referrals to serve guests'
  },
  <String, dynamic>{
    'text': 'Are appointments required to receive food?',
    'type': 'yesNo',
    'happyPathResponse': ['No'],
    'scoring': 1,
    'databaseVar': 'AppointmentsRequired',
    'databaseVarType': 'bool',
    'databaseOptCom': 'AppointmentsRequiredComments',
    'actionItem': 'No appointments should be required of guests to receive food'
  },
  <String, dynamic>{
    'text': 'Does the pantry require any documentation?',
    'type': 'yesNo',
    'databaseVar': 'DocumentationRequired',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DocumentationRequiredComments',
  },
  <String, dynamic>{
    'text':
        'Describe the types of documentation requested and the purpose (only allowed to verify residency and identity):',
    'type': 'fillIn',
    'databaseVar': 'DocumentationDescription',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Does this pantry operate under the rural exemption?',
    'type': 'yesNo',
    'databaseVar': 'UnderRuralExemption',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnderRuralExemptionComments',
  },
  <String, dynamic>{
    'text': 'Does this food pantry also operate a soup kitchen?',
    'type': 'yesNo',
    'databaseVar': 'HasSoupKitchen',
    'databaseVarType': 'bool',
    'databaseOptCom': 'HasSoupKitchenComments'
  },
  <String, dynamic>{
    'text': 'If yes, is the food properly separated and tracked for two programs?',
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'N/A'],
    'scoring': 1,
    'databaseVar': 'FoodProperlySeperatedAndTracked',
    'databaseVarType': 'bool',
    'databaseOptCom': 'FoodProperlySeperatedAndTrackedComments',
    'actionItem': 'Ensure food is properly separated and tracked by each program'
  },
  <String, dynamic>{
    'text': 'Is Program on Food Rescue/Agency Enabled?',
    'type': 'yesNo',
    'databaseVar': 'OnFoodRescueAgencyEnabled',
    'databaseVarType': 'bool',
    'databaseOptCom': 'OnFoodRescueAgencyEnabledComments',
  },
  <String, dynamic>{
    'text': 'Does site have Food Service Sanitation Managers?',
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'N/A'],
    'scoring': 1,
    'databaseVar': 'SiteHaveManager',
    'databaseVarType': 'bool',
    'databaseOptCom': 'SiteHaveManagerComments',
    'actionItem':
        'Submit copy of Food Service Sanitation Manager Certificates (City of Chicago)/ServSafe Certificates (State of Illinois)'
  },
  <String, dynamic>{
    'text': 'Names and expiration dates of Food Service Sanitation Manager certificates:',
    'type': 'fillIn',
    'databaseVar': 'FoodServiceSanitationManagerCerts',
    'databaseVarType': 'string',
  },
  // <String, dynamic>{
  //   'text': 'Names and expiration dates of FSSM certificates:',
  //   'type': 'fillIn',
  //   'databaseVar': 'RemoveField',
  //   'databaseVarType': 'string',
  // },
  <String, dynamic>{
    'text': 'Last Order Date:',
    'type': 'date',
    'hideNa': 'true',
    'databaseVar': 'LastOrderDate',
    'databaseVarType': 'date',
    'databaseOptCom': 'LastOrderDateComments'
  },
  <String, dynamic>{
    'text': 'What is the number of deliveries per month?',
    'type': 'dropDown',
    'hideNa': 'true',
    'menuItems': ['Select', '1', '2', '3', '4', '5', 'Other'],
    'databaseVar': 'NumberOfDeliveriesPerMonth',
    'databaseOptCom': 'NumberOfDeliveriesPerMonthComments',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Has an order been placed from the menu in the past month?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 5,
    'databaseVar': 'OrderHasBeenPlacedInLastMonth',
    'databaseVarType': 'bool',
    'databaseOptCom': 'OrderHasBeenPlacedInLastMonthComments',
    'actionItem':
        'Ensure an order is placed at least once a month. Please provide an explanation why an order has not been placed within the past month'
  },
  <String, dynamic>{
    'text': 'Has an online intake system been used in the past month?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'IntakeSystemUsedInLastMonth',
    'databaseVarType': 'bool',
    'databaseOptCom': 'IntakeSystemUsedInLastMonthComments',
    'actionItem': 'Ensure appropriate intake and meal count system is utilized'
  },
  <String, dynamic>{
    'text': 'Is information on our Agency Locator accurate?',
    'type': 'dropDown',
    'hideNa': 'true',
    'menuItems': ['Select', 'Yes', 'No', 'Closed Program'],
    // 'happyPathResponse': ['Yes', 'No', 'Closed Program'],
    'databaseVar': 'AgencyLocatorAccurate',
    'databaseVarType': 'string',
    'databaseOptCom': 'AgencyLocatorAccurateComments',
  },
];

List<Map<String, dynamic>> audit1Section2Questions = [
  <String, dynamic>{
    'text': "Is entrance clearly marked?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'EntranceClearlyMarked',
    'databaseVarType': 'bool',
    'databaseOptCom': 'EntranceClearlyMarkedComments',
    'actionItem': 'Ensure entrance to program is clearly marked and visible to guests'
  },
  <String, dynamic>{
    'text': "Is there a sign posted outside with days and hours of operation?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'OperationHoursDaysPosted',
    'databaseVarType': 'bool',
    'databaseOptCom': 'OperationHoursDaysPostedComments',
    'actionItem': 'Post established days / hours / service areas of operation to be viewed from outside of the building'
  },
  <String, dynamic>{
    'text': "Is there a sign posted with service requirements/guidelines visible to guests?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'ServiceRequirementsPosted',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ServiceRequirementsPostedComments',
    'actionItem': 'Post guidelines for receiving service in an area visible to guests.'
  },
  <String, dynamic>{
    'text': "Is the Food Depository contact information posted?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'GCFDContactInfoPosted',
    'databaseVarType': 'bool',
    'databaseOptCom': 'GCFDContactInfoPostedComments',
    'actionItem': 'Post Food Depository’s contact information. '
  },
  <String, dynamic>{
    'text':
        "What types of public outreach and networking does the pantry use to make the general public aware of their services?",
    'type': 'fillIn',
    'databaseVar': 'TypeOfOutreachUsed',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text':
        "Are TEFAP posters accessible to guests?(Ex: Income Eligibility, Prohibited Activities, 'And Justice for All')",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'N/A'],
    'scoring': 1,
    'databaseVar': 'TEFAPPostersAccessible',
    'databaseVarType': 'bool',
    'databaseOptCom': 'TEFAPPostersAccessibleComments',
    'actionItem': 'Post appropriate USDA signage (if applicable).'
  },
];

List<Map<String, dynamic>> audit1Section3Questions = [
  <String, dynamic>{
    'text': "Are activities conducted that might be interpreted as requiring fees/donations/memberships?",
    'type': 'yesNo',
    'happyPathResponse': ['No'],
    'scoring': 5,
    'databaseVar': 'ActivitiesIndicatingFeesRequired',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ActivitiesIndicatingFeesRequiredComments',
    'actionItem':
        'Comply with the Illinois Department of Human Services’ rules concerning client self-attestation for eligibility for service'
  },
  <String, dynamic>{
    'text': "Is an online intake system being utilized?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 5,
    'databaseVar': 'OnlineIntakeUtilized',
    'databaseVarType': 'bool',
    'databaseOptCom': 'OnlineIntakeUtilizedComments',
    'actionItem': 'Appropriate intake and meal count system should be utilized. '
  },
  <String, dynamic>{
    'text': "If it is not being utilized, are DHS signature documents used?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'N/A'],
    'scoring': 1,
    'databaseVar': 'DHSSignatureDocsUsed',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DHSSignatureDocsUsedComments',
    'actionItem': 'Ensure DHS document is utilized during intake'
  },
  <String, dynamic>{
    'text': "Does the guest sign his/her name upon receipt?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'N/A'],
    'scoring': 1,
    'databaseVar': 'GuestSignsName',
    'databaseVarType': 'bool',
    'databaseOptCom': 'GuestSignsNameComments',
    'actionItem': 'Ensure guests signature is obtained during intake'
  },
  <String, dynamic>{
    'text': "Is the address recorded upon receipt?",
    'type': 'yesNo',
    'scoring': 1,
    'happyPathResponse': ['Yes'],
    'databaseVar': 'AddressRecordedUponReceipt',
    'databaseVarType': 'bool',
    'databaseOptCom': 'AddressRecordedUponReceiptComments',
    'actionItem': 'Ensure address is recorded when applicable'
  },
  <String, dynamic>{
    'text': "Is the household size recorded upon receipt?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'HouseholdSizeRecordedUponReceipt',
    'databaseVarType': 'bool',
    'databaseOptCom': 'HouseholdSizeRecordedUponReceiptComments',
    'actionItem': 'Ensure household size is recorded during intake'
  },
  <String, dynamic>{
    'text': "Does the pantry have the guest sign even if only privately donated food is received?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'GuestSignsEvenForPrivateDonation',
    'databaseVarType': 'bool',
    'databaseOptCom': 'GuestSignsEvenForPrivateDonationComments',
    'actionItem': 'Site must ensure signatures are collected for all food items distributed'
  },
  <String, dynamic>{
    'text': "Are original DHS signature documents and surveys submitted to the Food Depository monthly?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'OriginalDHSSigDocsSubmitted',
    'databaseVarType': 'bool',
    'databaseOptCom': 'OriginalDHSSigDocsSubmittedComments',
    'actionItem': 'Ensure original DHS signature documents and surveys are submitted to the Food Depository '
  },
  <String, dynamic>{
    'text': "Is the TEFAP manual accessible to pantry staff and/or volunteers?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'N/A'],
    'scoring': 1,
    'databaseVar': 'TEFAPManualAccessible',
    'databaseVarType': 'bool',
    'databaseOptCom': 'TEFAPManualAccessibleComments',
    'actionItem':
        'When the TEFAP manual is not accessible to staff and volunteers, please explain what action takes place to remedy this. (Ex: a copy will be emailed to program contact)',
  },
  <String, dynamic>{
    'text': "Are proxy forms used?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'N/A'],
    'scoring': 1,
    'databaseVar': 'ProxyFormsUsed',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ProxyFormsUsedComments',
    'actionItem': 'Please utilize proxy forms when appropriate'
  },
  <String, dynamic>{
    'text': "If yes, do they contain the original signature of the recipient getting food?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'N/A'],
    'scoring': 1,
    'databaseVar': 'ProxyFormsOriginalSignature',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ProxyFormsOriginalSignatureComments',
    'actionItem': 'Ensure original signatures are collected on Proxy forms'
  },

  <String, dynamic>{
    'text': "Does the proxy sign the proxy form in the presence of pantry personnel?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'N/A'],
    'scoring': 1,
    'databaseVar': 'ProxySignedInPresenceOfPantryPersonnel',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ProxySignedInPresenceOfPantryPersonnelComments',
    'actionItem': 'Proxy forms must be signed in the presence of a pantry personnel'
  },
  <String, dynamic>{
    'text': "Do pantry personnel sign the proxy form at the time of distribution?",
    'type': 'yesNoNa',
    'scoring': 1,
    'happyPathResponse': ['Yes', 'N/A'],
    'databaseVar': 'ProxyFormSignedAtTimeOfDistribution',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ProxyFormSignedAtTimeOfDistributionComments',
    'actionItem': 'Proxy forms must have Pantry Personnel’s signature'
  },
  <String, dynamic>{
    'text': "Are TANF commodities being distributed?",
    'type': 'yesNo',
    'databaseVar': 'TANFCommoditiesDistributed',
    'databaseVarType': 'bool',
    'databaseOptCom': 'TANFCommoditiesDistributedComments'
  },

  <String, dynamic>{
    'text': "If yes, do guests complete the required TANF information?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'N/A'],
    'scoring': 1,
    'databaseVar': 'GuestsCompleteRequiredTANFInfo',
    'databaseVarType': 'bool',
    'databaseOptCom': 'GuestsCompleteRequiredTANFInfoComments',
    'actionItem': 'Ensure that TANF information is completed'
  },
  <String, dynamic>{
    'text': "Are guests without children in the household completing TANF information?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'N/A'],
    'scoring': 1,
    'databaseVar': 'GuestsWithoutChildrenCompletingTANFInfo',
    'databaseVarType': 'bool',
    'databaseOptCom': 'GuestsWithoutChildrenCompletingTANFInfoComments',
    'actionItem': 'Ensure guests without children are completing the TANF information'
  },
  <String, dynamic>{
    'text': "Technology being used:	#of Tablets:",
    'type': 'fillInNum',
    'databaseVar': 'NumberOfTabletsBeingUsed',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': "#of Computers:",
    'type': 'fillInNum',
    'databaseVar': 'NumberOfComputersBeingUsed',
    'databaseVarType': 'int',
  },

  <String, dynamic>{
    'text': "Guest disposition:",
    'type': 'fillIn',
    'databaseVar': 'GuestDisposition',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': "Guests served during site visit:",
    'type': 'fillInNum',
    'databaseVar': 'GuestsServedDuringVisit',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': "Guests served each month:",
    'type': 'fillInNum',
    'databaseVar': 'GuestServedEachMonth',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': "Volunteer disposition:",
    'type': 'fillIn',
    'databaseVar': 'VolunteerDisposition',
    'databaseVarType': 'string',
  },

  <String, dynamic>{
    'text': "# of Intake Volunteers:",
    'type': 'fillInNum',
    'hideNa': 'true',
    'databaseVar': 'NumberOfIntakeVolunteers',
    'databaseVarType': 'int',
  },

  <String, dynamic>{
    'text': "# of Distribution Volunteers:",
    'type': 'fillInNum',
    'hideNa': 'true',
    'databaseVar': 'NumberOfDistributionVolunteers',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': "How does the pantry recruit volunteers?",
    'type': 'fillIn',
    'databaseVar': 'HowDoesPantryRecruitVolunteers',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': "Are other activities unrelated to TEFAP disrupting distribution?",
    'type': 'yesNo',
    'happyPathResponse': ['No'],
    'scoring': 1,
    'databaseVar': 'ActivitiesOtherThanTEFAPDisrupting',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ActivitiesOtherThanTEFAPDisruptingComments',
    'actionItem': 'Ensure no other activities unrelated to TEFAP are conducted during distribution'
  },
  <String, dynamic>{
    'text': "Do all distribution activities appear to be appropriate?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 5,
    'databaseVar': 'DistributionActivitiesAreAppropriate',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DistributionActivitiesAreAppropriateComments',
    'actionItem': 'Ensure activities pertaining to distribution are conducted only'
  },
  <String, dynamic>{
    'text': "Distribution style: (if not client choice, indicate why in the comments:",
    'type': 'dropDown',
    'hideNa': 'true',
    'menuItems': ['Select', 'Client Choice', 'Prepacked', 'Partial Client Choice'],
    'databaseVar': 'DistributionStyle',
    'databaseVarType': 'string',
    'databaseOptCom': 'DistributionStyleComments'
  },

  // <String, dynamic>{
  //   'text': "If not client choice, why?",
  //   'type': 'fillIn',
  //   'databaseVar': 'DistributionNotClientChoiceReason',
  //   'databaseVarType': 'string'
  // },
];

List<Map<String, dynamic>> audit1Section4Questions = [
  <String, dynamic>{
    'text': 'Are floors, pallets, and shelving clean?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 5,
    'databaseVar': 'FloorsPalletsShelvesClean',
    'databaseVarType': 'bool',
    'databaseOptCom': 'FloorsPalletsShelvesCleanComments',
    'actionItem': 'Clean and organize floors, pallets, and shelving'
  },
  <String, dynamic>{
    'text': 'Is storage area organized?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'StorageOrganized',
    'databaseVarType': 'bool',
    'databaseOptCom': 'StorageOrganizedComments',
    'actionItem': 'Clean and organize storage area'
  },
  <String, dynamic>{
    'text': 'Are pest proof containers utilized?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'PestProofContainersUsed',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PestProofContainersUsedComments',
    'actionItem':
        'Acquire / Utilize pest-proof containers for packaged items such as pasta, cereal, rice, flour, beans, cornmeal, etc. Please submit receipt for pest-proof containers '
  },
  <String, dynamic>{
    'text': 'Are non-food items and toxic items stored separately?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'NonFoodItemsStoredSeparately',
    'databaseVarType': 'bool',
    'databaseOptCom': 'NonFoodItemsStoredSeparatelyComments',
    'actionItem': 'Separate cleaning agents and other chemicals from stored food / contact surfaces'
  },
  <String, dynamic>{
    'text': 'Is dry food being rotated via FIFO?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'DryFoodRotatedFIFO',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DryFoodRotatedFIFOComments',
    'actionItem': 'Ensure the “First in First Out” method is followed with dry food'
  },
  <String, dynamic>{
    'text': 'Is food 6 inches off floor?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'DryFoodSixInchesFromFloor',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DryFoodSixInchesFromFloorComments',
    'actionItem': 'Remove all boxes of food (cardboard /paper) from the floor or at least 6” above the floor'
  },
  <String, dynamic>{
    'text':
        'Is food kept far enough away from walls and floor to permit good air circulation and to allow for pest control?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'DryFoodKeptFromWalls',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DryFoodKeptFromWallsComments',
    'actionItem':
        'Ensure adequate space is between food from walls and floor to permit good air circulation and pest control'
  },
  <String, dynamic>{
    'text': 'Are proper temperatures for dry food storage maintained?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'ProperTempForDryFood',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ProperTempForDryFoodComments',
    'actionItem':
        'Acquire or Utilize Heater or AC to maintain proper temperature in dry storage area to maintain temperature between 50F and 70F. Please submit receipt for Heater or AC '
  },
  <String, dynamic>{
    'text': 'Is the food stored in a secure location with adequate space? If no, explain:',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'DryFoodStoredSecurely',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DryFoodStoredSecurelyComments',
    'actionItem':
        'Acquire or Utilize locks to secure cold storage units and/or dry storage area. Please submit receipt for locks '
  },
  <String, dynamic>{
    'text': 'Is food clearly marked for use by food program only?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'DryFoodClearlyMarked',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DryFoodClearlyMarkedComments',
    'actionItem': 'Clearly label Program Food from food used for other purposes (i.e. personal use).'
  },
  <String, dynamic>{
    'text': 'Is storage area only for approved food program?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'StorageAreaOnlyForApprovedFood',
    'databaseVarType': 'bool',
    'databaseOptCom': 'StorageAreaOnlyForApprovedFoodComments',
    'actionItem': 'Ensure storage area is only used for approved program food'
  },
  <String, dynamic>{
    'text': 'Is equipment well maintained?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'DryEquipmentWellMaintained',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DryEquipmentWellMaintainedComments',
    'actionItem': 'Ensure dry food equipment is maintained and working properly'
  },
  <String, dynamic>{
    'text': 'Appropriate amount of food in inventory?',
    'type': 'yesNo',
    'databaseVar': 'AppropriateAmountOfFood',
    'databaseVarType': 'bool',
    'databaseOptCom': 'AppropriateAmountOfFoodComments'
  },
  // <String, dynamic>{
  //   'text': '# of cases of dry food currently in inventory:',
  //   'type': 'fillInNum',
  //   'databaseVar': 'NumCasesOfDryFood',
  //   'databaseVarType': 'int',
  // },

  <String, dynamic>{
    'text': "# of cases of dry food in inventory:",
    'type': 'dropDown',
    'hideNa': 'true',
    'menuItems': ['Select', '1-25', '26-50', '51-150', '150+'],
    'databaseVar': 'NumCasesOfDryFood',
    'databaseVarType': 'string',
    'databaseOptCom': 'NumCasesOfDryFoodComments'
  },

  // <String, dynamic>{
  //   'text': '# of cases of meat currently in inventory: ',
  //   'type': 'fillInNum',
  //   'databaseVar': 'NumCasesOfMeat',
  //   'databaseVarType': 'int',
  // },

  <String, dynamic>{
    'text': "# of cases of meat in inventory:",
    'type': 'dropDown',
    'hideNa': 'true',
    'menuItems': ['Select', '1-25', '26-50', '51-150', '150+'],
    'databaseVar': 'NumCasesOfMeat',
    'databaseVarType': 'string',
    'databaseOptCom': 'NumCasesOfMeatComments'
  },
  // <String, dynamic>{
  //   'text': '# of cases of perishable items in inventory: ',
  //   'type': 'fillInNum',
  //   'databaseVar': 'NumCasesOfPerishableItems',
  //   'databaseVarType': 'int',
  // },

  <String, dynamic>{
    'text': "# of cases of perishable items in inventory:",
    'type': 'dropDown',
    'hideNa': 'true',
    'menuItems': ['Select', '1-25', '26-50', '51-150', '150+'],
    'databaseVar': 'NumCasesOfPerishableItems',
    'databaseVarType': 'string',
    'databaseOptCom': 'NumCasesOfPerishableItemsComments'
  },
  <String, dynamic>{
    'text':
        'Does the pantry have other foods to distribute with government commodities? (Please indicate other foods in the comments)',
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'N/A'],
    'scoring': 1,
    'databaseVar': 'PantryHasOtherFoodToDistribute',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PantryHasOtherFoodToDistributeComments',
    'actionItem': 'Site should be distributing other types of foods along with government commodities'
  },
  <String, dynamic>{
    'text': 'Area 1: ',
    'type': 'fillIn',
    'databaseVar': 'AreaOneComments',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Area 2: ',
    'type': 'fillIn',
    'databaseVar': 'AreaTwoComments',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Area 3: ',
    'type': 'fillIn',
    'databaseVar': 'AreaThreeComments',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Area 4: ',
    'type': 'fillIn',
    'databaseVar': 'AreaFourComments',
    'databaseVarType': 'string',
  },
];

List<Map<String, dynamic>> audit1Section5Questions = [
  <String, dynamic>{
    'text': 'Are units clean?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 5,
    'databaseVar': 'UnitsClean',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnitsCleanComments',
    'actionItem': 'Clean units. Please specify unit number'
  },
  <String, dynamic>{
    'text': 'Are units defrosted?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'UnitsDefrosted',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnitsDefrostedComments',
    'actionItem': 'Defrost units. Please specify unit number'
  },
  <String, dynamic>{
    'text': 'Are units organized?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'UnitsOrganized',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnitsOrganizedComments',
    'actionItem': 'Organize units.  Please specify unit number'
  },
  <String, dynamic>{
    'text': 'Is cold food being rotated via FIFO?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'ColdFoodRotatedFIFO',
    'scoring': 1,
    'databaseVarType': 'bool',
    'databaseOptCom': 'ColdFoodRotatedFIFOComments',
    'actionItem': 'Ensure the “First in First Out” method is followed with cold food'
  },
  <String, dynamic>{
    'text': 'Do units have thermometers?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'UnitsHaveThermometers',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnitsHaveThermometersComments',
    'actionItem': "Acquire or Utilize thermometers for cold storage units. Please submit receipt for thermometers."
  },
  <String, dynamic>{
    'text': 'Are units only for approved food program?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'UnitsOnlyForApprovedPrograms',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnitsOnlyForApprovedProgramsComments',
    'actionItem': 'Utilize program unit for approved program food only'
  },
  <String, dynamic>{
    'text': 'Is food appropriately labeled?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'ColdFoodAppropriatelyLabeled',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ColdFoodAppropriatelyLabeledComments',
    'actionItem': 'Clearly label Program Food from food used for other purposes (i.e. personal use)'
  },
  <String, dynamic>{
    'text': 'Is food appropriately stocked and not overstuffed in units? (Please indicate which units in the comments)',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'ColdFoodAppropriatelyStocked',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ColdFoodAppropriatelyStockedComments',
    'actionItem': 'Organize units and ensure they are not overstuffed. Indicate units: '
  },
  <String, dynamic>{
    'text': 'Are units numbered?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'UnitsNumbered',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnitsNumberedComments',
    'actionItem': 'Number units.  (please specify units that need to be numbered in the comments)'
  },
  <String, dynamic>{
    'text': 'Is equipment well maintained?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'ColdEquipmentWellMaintained',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ColdEquipmentWellMaintainedComments',
    'actionItem': 'Ensure cold food equipment is maintained and working properly'
  },
  <String, dynamic>{
    'text': 'Are cold storage units secured?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'ColdStorageUnitsSecured',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ColdStorageUnitsSecuredComments',
    'actionItem':
        "Acquire or Utilize locks to secure cold storage units and/or dry storage area. Please submit receipt for locks "
  },
  <String, dynamic>{
    'text': 'Are refrigerated items kept at temperatures between 35-40 degrees Fahrenheit?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 5,
    'databaseVar': 'RefrigeratedItemsCorrectTemp',
    'databaseVarType': 'bool',
    'databaseOptCom': 'RefrigeratedItemsCorrectTempComments',
    'actionItem': 'Ensure refrigerator temperature is maintained between 35°F and 40°F'
  },
  <String, dynamic>{
    'text': 'Are frozen items kept at a temperature below zero degrees Fahrenheit?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 5,
    'databaseVar': 'FrozenItemsCorrectTemp',
    'databaseVarType': 'bool',
    'databaseOptCom': 'FrozenItemsCorrectTempComments',
    'actionItem': 'Ensure freezer temperature is maintained below zero'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 1 ºF:',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitOneAndComments',
  //   'databaseVarType': 'string'
  // },

  <String, dynamic>{
    'text': "Cold Storage Unit 1 ºF:",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      'N/A'
    ],
    'happyPathResponse': ['Under 0 (acceptable for freezer)', '0 – 41 (acceptable for cooler)', 'N/A'],
    'databaseVar': 'ColdStorageUnitOne',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitOneComments',
    'actionItem': 'For Cold Storage Unit 1: Maintain temperature in the correct range'
  },

  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 2 ºF:',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitTwoAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 2 ºF:",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      'N/A'
    ],
    'happyPathResponse': ['Under 0 (acceptable for freezer)', '0 – 41 (acceptable for cooler)', 'N/A'],
    'databaseVar': 'ColdStorageUnitTwo',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitTwoComments',
    'actionItem': 'For Cold Storage Unit 2: Maintain temperature in the correct range'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 3 ºF:',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitThreeAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 3 ºF:",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      'N/A'
    ],
    'happyPathResponse': ['Under 0 (acceptable for freezer)', '0 – 41 (acceptable for cooler)', 'N/A'],
    'databaseVar': 'ColdStorageUnitThree',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitThreeComments',
    'actionItem': 'For Cold Storage Unit 3: Maintain temperature in the correct range'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 4 ºF:',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitFourAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 4 ºF:",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      'N/A'
    ],
    'happyPathResponse': ['Under 0 (acceptable for freezer)', '0 – 41 (acceptable for cooler)', 'N/A'],
    'databaseVar': 'ColdStorageUnitFour',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitFourComments',
    'actionItem': 'For Cold Storage Unit 4: Maintain temperature in the correct range'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 5 ºF:',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitFiveAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 5 ºF:",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      'N/A'
    ],
    'happyPathResponse': ['Under 0 (acceptable for freezer)', '0 – 41 (acceptable for cooler)', 'N/A'],
    'databaseVar': 'ColdStorageUnitFive',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitFiveComments',
    'actionItem': 'For Cold Storage Unit 5: Maintain temperature in the correct range'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 6 ºF:',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitSixAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 6 ºF:",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      'N/A'
    ],
    'happyPathResponse': ['Under 0 (acceptable for freezer)', '0 – 41 (acceptable for cooler)', 'N/A'],
    'databaseVar': 'ColdStorageUnitSix',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitSixComments',
    'actionItem': 'For Cold Storage Unit 6: Maintain temperature in the correct range'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 7 ºF:',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitSevenAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 7 ºF:",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      'N/A'
    ],
    'happyPathResponse': ['Under 0 (acceptable for freezer)', '0 – 41 (acceptable for cooler)', 'N/A'],
    'databaseVar': 'ColdStorageUnitSeven',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitSevenComments',
    'actionItem': 'For Cold Storage Unit 7: Maintain temperature in the correct range'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 8 ºF:',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitEightAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 8 ºF:",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      'N/A'
    ],
    'happyPathResponse': ['Under 0 (acceptable for freezer)', '0 – 41 (acceptable for cooler)', 'N/A'],
    'databaseVar': 'ColdStorageUnitEight',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitEightComments',
    'actionItem': 'For Cold Storage Unit 8: Maintain temperature in the correct range'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 9 ºF:',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitNineAndComments',
  //   'databaseVarType': 'string'
  // },

  <String, dynamic>{
    'text': "Cold Storage Unit 9 ºF:",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      'N/A'
    ],
    'happyPathResponse': ['Under 0 (acceptable for freezer)', '0 – 41 (acceptable for cooler)', 'N/A'],
    'databaseVar': 'ColdStorageUnitNine',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitNineComments',
    'actionItem': 'For Cold Storage Unit 9: Maintain temperature in the correct range'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 10 ºF:',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitTenAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 10 ºF:",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      'N/A'
    ],
    'happyPathResponse': ['Under 0 (acceptable for freezer)', '0 – 41 (acceptable for cooler)', 'N/A'],
    'databaseVar': 'ColdStorageUnitTen',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitTenComments',
    'actionItem': 'For Cold Storage Unit 10: Maintain temperature in the correct range'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 11 ºF:',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitElevenAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 11 ºF:",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      'N/A'
    ],
    'happyPathResponse': ['Under 0 (acceptable for freezer)', '0 – 41 (acceptable for cooler)', 'N/A'],
    'databaseVar': 'ColdStorageUnitEleven',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitElevenComments',
    'actionItem': 'For Cold Storage Unit 11: Maintain temperature in the correct range'
  },

  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 12 ºF:',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitTwelveAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 12 ºF:",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      'N/A'
    ],
    'happyPathResponse': ['Under 0 (acceptable for freezer)', '0 – 41 (acceptable for cooler)', 'N/A'],
    'databaseVar': 'ColdStorageUnitTwelve',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitTwelveComments',
    'actionItem': 'For Cold Storage Unit 12: Maintain temperature in the correct range'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 13 ºF:',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitThirteenAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 13 ºF:",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      'N/A'
    ],
    'happyPathResponse': ['Under 0 (acceptable for freezer)', '0 – 41 (acceptable for cooler)', 'N/A'],
    'databaseVar': 'ColdStorageUnitThirteen',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitThirteenComments',
    'actionItem': 'For Cold Storage Unit 13: Maintain temperature in the correct range'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 14 ºF:',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitFourteenAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 14 ºF:",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      'N/A'
    ],
    'happyPathResponse': ['Under 0 (acceptable for freezer)', '0 – 41 (acceptable for cooler)', 'N/A'],
    'databaseVar': 'ColdStorageUnitFourteen',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitFourteenComments',
    'actionItem': 'For Cold Storage Unit 14: Maintain temperature in the correct range'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 15 ºF:',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitFifteenAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 15 ºF:",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      'N/A'
    ],
    'happyPathResponse': ['Under 0 (acceptable for freezer)', '0 – 41 (acceptable for cooler)', 'N/A'],
    'databaseVar': 'ColdStorageUnitFifteen',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitFifteenComments',
    'actionItem': 'For Cold Storage Unit 15: Maintain temperature in the correct range'
  },

  <String, dynamic>{
    'text': 'Walk in #1:',
    'type': 'dropDown',
    'menuItems': ['Select', 'Freezer', 'Cooler', 'N/A'],
    'databaseVar': 'WalkInFreezerCoolerOne',
    'databaseVarType': 'string',
    'databaseOptCom': 'WalkInFreezerCoolerOneComments'
  },
  <String, dynamic>{
    'text': "Walk in #1 Cooler/Freezer ",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      'N/A'
    ],
    'happyPathResponse': ['Under 0 (acceptable for freezer)', '0 – 41 (acceptable for cooler)', 'N/A'],
    'databaseVar': 'TempOne',
    'databaseVarType': 'string',
    'databaseOptCom': 'TempOneComments',
    'actionItem': 'Maintain #1 Cooler/Freezer within acceptable temperature limits'
  },
  <String, dynamic>{
    'text': 'Walk in #2:',
    'type': 'dropDown',
    'menuItems': ['Select', 'Freezer', 'Cooler', 'N/A'],
    'databaseVar': 'WalkInFreezerCoolerTwo',
    'databaseVarType': 'string',
    'databaseOptCom': 'WalkInFreezerCoolerTwoComments'
  },
  <String, dynamic>{
    'text': "Walk in #2 Cooler/Freezer ",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      'N/A'
    ],
    'happyPathResponse': ['Under 0 (acceptable for freezer)', '0 – 41 (acceptable for cooler)', 'N/A'],
    'databaseVar': 'TempTwo',
    'databaseVarType': 'string',
    'databaseOptCom': 'TempTwoComments',
    'actionItem': 'Maintain #2 Cooler/Freezer within acceptable temperature limits'
  },
  <String, dynamic>{
    'text': 'Walk in #3:',
    'type': 'dropDown',
    'menuItems': ['Select', 'Freezer', 'Cooler', 'N/A'],
    'databaseVar': 'WalkInFreezerCoolerThree',
    'databaseVarType': 'string',
    'databaseOptCom': 'WalkInFreezerCoolerThreeComments'
  },
  <String, dynamic>{
    'text': "Walk in #3 Cooler/Freezer ",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      'N/A'
    ],
    'happyPathResponse': ['Under 0 (acceptable for freezer)', '0 – 41 (acceptable for cooler)', 'N/A'],
    'databaseVar': 'TempThree',
    'databaseVarType': 'string',
    'databaseOptCom': 'TempThreeComments',
    'actionItem': 'Maintain #3 Cooler/Freezer within acceptable temperature limits'
  },
  <String, dynamic>{
    'text': 'Walk in #4:',
    'type': 'dropDown',
    'menuItems': ['Select', 'Freezer', 'Cooler', 'N/A'],
    'databaseVar': 'WalkInFreezerCoolerFour',
    'databaseVarType': 'string',
    'databaseOptCom': 'WalkInFreezerCoolerFourComments'
  },
  <String, dynamic>{
    'text': "Walk in #4 Cooler/Freezer ",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      'N/A'
    ],
    'happyPathResponse': ['Under 0 (acceptable for freezer)', '0 – 41 (acceptable for cooler)', 'N/A'],
    'databaseVar': 'TempFour',
    'databaseVarType': 'string',
    'databaseOptCom': 'TempFourComments',
    'actionItem': 'Maintain #4 Cooler/Freezer within acceptable temperature limits'
  },
  <String, dynamic>{
    'text': 'Walk in #5:',
    'type': 'dropDown',
    'menuItems': ['Select', 'Freezer', 'Cooler', 'N/A'],
    'databaseVar': 'WalkInFreezerCoolerFive',
    'databaseVarType': 'string',
    'databaseOptCom': 'WalkInFreezerCoolerFiveComments'
  },
  <String, dynamic>{
    'text': "Walk in #5 Cooler/Freezer ",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      'N/A'
    ],
    'happyPathResponse': ['Under 0 (acceptable for freezer)', '0 – 41 (acceptable for cooler)', 'N/A'],
    'databaseVar': 'TempFive',
    'databaseVarType': 'string',
    'databaseOptCom': 'TempFiveComments',
    'actionItem': 'Maintain #5 Cooler/Freezer within acceptable temperature limits'
  },

  <String, dynamic>{
    'text': 'USDA Tag Unit #1',
    'type': 'fillIn',
    'databaseVar': 'USDATagNumberOne',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Serial Unit #1',
    'type': 'fillInNum',
    'databaseVar': 'SerialNumberOne',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': 'Unit #1 Type ',
    'type': 'fillIn',
    'databaseVar': 'TypeOne',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'USDA Tag Unit #2',
    'type': 'fillIn',
    'databaseVar': 'USDATagNumberTwo',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Serial Unit #2',
    'type': 'fillInNum',
    'databaseVar': 'SerialNumberTwo',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': 'Unit #2 Type ',
    'type': 'fillIn',
    'databaseVar': 'TypeTwo',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'USDA Tag Unit #3',
    'type': 'fillIn',
    'databaseVar': 'USDATagNumberThree',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Serial Unit #3',
    'type': 'fillInNum',
    'databaseVar': 'SerialNumberThree',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': 'Unit #3 Type ',
    'type': 'fillIn',
    'databaseVar': 'TypeThree',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'USDA Tag Unit #4',
    'type': 'fillIn',
    'databaseVar': 'USDATagNumberFour',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Serial Unit #4',
    'type': 'fillInNum',
    'databaseVar': 'SerialNumberFour',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': 'Unit #4 Type',
    'type': 'fillIn',
    'databaseVar': 'TypeFour',
    'databaseVarType': 'string',
  },
  // <String, dynamic>{
  //   'text': 'USDA Tag #5',
  //   'type': 'fillIn',
  //   'databaseVar': 'USDATagNumberFive',
  //   'databaseVarType': 'string',
  // },
  // <String, dynamic>{
  //   'text': 'Serial #5',
  //   'type': 'fillInNum',
  //   'databaseVar': 'SerialNumberFive',
  //   'databaseVarType': 'int',
  // },
  // <String, dynamic>{
  //   'text': 'Unit #5 Type',
  //   'type': 'fillIn',
  //   'databaseVar': 'TypeFive',
  //   'databaseVarType': 'string',
  // },
  <String, dynamic>{
    'text': '*Units should not be shared with other programs ',
    'type': 'Display',
  },
];

List<Map<String, dynamic>> audit1Section6Questions = [
  <String, dynamic>{
    'text': 'Plumbing issues?',
    'type': 'issuesNoIssues',
    'happyPathResponse': ['No Issues'],
    'scoring': 1,
    'databaseVar': 'PlumbingIssues',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PlumbingIssuesComments',
    'actionItem': 'Explain issue and action item for plumbing issues: '
  },
  <String, dynamic>{
    'text': 'Sewage issues?',
    'type': 'issuesNoIssues',
    'happyPathResponse': ['No Issues'],
    'scoring': 1,
    'databaseVar': 'SewageIssues',
    'databaseVarType': 'bool',
    'databaseOptCom': 'SewageIssuesComments',
    'actionItem': 'Explain issue and action item for Sewage issues: '
  },
  <String, dynamic>{
    'text': 'Garbage and refuse disposal',
    'type': 'issuesNoIssues',
    'happyPathResponse': ['No Issues'],
    'scoring': 1,
    'databaseVar': 'GarbageRefusalDisposalIssues',
    'databaseVarType': 'bool',
    'databaseOptCom': 'GarbageRefusalDisposalIssuesComments',
    'actionItem': 'Explain issue and action item for garbage and refuse disposal issues: '
  },
  <String, dynamic>{
    'text': 'Was the site able to provide a pest control log/exterminator’s report?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'PestControlReport',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PestControlReportComments',
    'actionItem': 'Submit a copy of current/most recent Pest Control Log/Exterminator’s Report'
  },
  <String, dynamic>{
    'text': 'Name of Pest Control Company:',
    'type': 'fillIn',
    'databaseVar': 'PestControlCompany',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Last Pest Control Service Date:',
    'type': 'date',
    'databaseVar': 'PestControlServiceDate',
    'databaseVarType': 'date',
    'databaseOptCom': 'PestControlServiceDateComments'
  },
  <String, dynamic>{
    'text': 'Are floors, doors, windows, and roofs well sealed to prevent pest entry and water damage?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 1,
    'databaseVar': 'BuildingWellSealed',
    'databaseVarType': 'bool',
    'databaseOptCom': 'BuildingWellSealedComments',
    'actionItem': 'Repair roofs, floors, walls, ceilings, windows and doors to prevent pest entry and water damage'
  },
  <String, dynamic>{
    'text': 'Appropriate Lighting issues?',
    'type': 'issuesNoIssues',
    'happyPathResponse': ['No Issues'],
    'scoring': 1,
    'databaseVar': 'AppropriateLightingIssues',
    'databaseVarType': 'bool',
    'databaseOptCom': 'AppropriateLightingIssuesComments',
    'actionItem': 'Please explain lighting issues and action items: '
  },

  <String, dynamic>{
    'text': 'Ventilation Issues?',
    'type': 'issuesNoIssues',
    'happyPathResponse': ['No Issues'],
    'scoring': 1,
    'databaseVar': 'VentilationIssues',
    'databaseVarType': 'bool',
    'databaseOptCom': 'VentilationIssuesComments',
    'actionItem': 'Please explain ventilation issues and action items in comments: '
  },
  <String, dynamic>{
    'text':
        'Issues with access to all pertinent areas of food program (dry storage, cold storage, intake, distribution)',
    'type': 'issuesNoIssues',
    'happyPathResponse': ['No Issues'],
    'scoring': 1,
    'databaseVar': 'AccessToAllPertinentAreasIssues',
    'databaseVarType': 'bool',
    'databaseOptCom': 'AccessToAllPertinentAreasIssuesComments',
    'actionItem': 'Please explain issues with access to all pertinent areas of food program action items: '
  },
  <String, dynamic>{
    'text': 'Evidence of Rodents/ Insects (Includes fruit and house flies) Please leave specifics in comments:',
    'type': 'yesNo',
    'happyPathResponse': ['No'],
    'scoring': 5,
    'databaseVar': 'EvidenceOfPests',
    'databaseVarType': 'bool',
    'databaseOptCom': 'EvidenceOfPestsComments',
    'actionItem': 'Clean and disinfect area where evidence of rodents/insects were seen'
  },

  // <String, dynamic>{
  //   'text': 'If yes, details:',
  //   'type': 'fillIn',
  //   'databaseVar': 'EvidenceOfPestsComments',
  //   'databaseVarType': 'string',
  // },
];

List<Map<String, dynamic>> audit1Section7Questions = [
  <String, dynamic>{
    'text': 'Have there been any discrimination complaints in the past year?',
    'type': 'yesNo',
    'databaseVar': 'DiscriminationComplaints',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DiscriminationComplaintsComments',
  },
  <String, dynamic>{
    'text': 'Does the program know what to do if there is a discrimination complaint?',
    'type': 'yesNo',
    'databaseVar': 'PantryKnowsResolutionDiscriminationComplaint',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PantryKnowsResolutionDiscriminationComplaintComments',
  },
  <String, dynamic>{
    'text': 'If there have been any discrimination complaints, have they been forwarded to the Food Depository?',
    'type': 'yesNoNa',
    'databaseVar': 'DiscriminationComplaintForwardedToGCFD',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DiscriminationComplaintForwardedToGCFDComments',
  },
  <String, dynamic>{
    'text':
        'If the pantry has questions or problems, what is the name and phone number of their Food Depository contact person?',
    'type': 'fillIn',
    'hideNa': 'true',
    'databaseVar': 'PantryHasFoodDepositoryContactInfoComments',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Issues from last site visit?',
    'type': 'fillIn',
    'databaseVar': 'IssuesFromLastSiteVisit',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Distribution Site Staff Comments: ',
    'type': 'fillIn',
    'databaseVar': 'DistributionSiteStaffComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Food Depository Comments:',
    'type': 'fillIn',
    'databaseVar': 'FoodDepositoryComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Donors:',
    'type': 'fillIn',
    'databaseVarType': 'string',
    'databaseVar': 'Donors',
  },
  // <String, dynamic>{
  //   'text': 'Date Tax Exemption Verified:',
  //   'type': 'date',
  //   'databaseVarType': 'date',
  //   'databaseVar': 'DateTaxExemptionVerified',
  // },
  <String, dynamic>{
    'text': 'Tax Exemption Verified:',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'scoring': 5,
    'databaseVar': 'TaxExemptionVerified',
    'databaseVarType': 'bool',
    'databaseOptCom': 'TaxExemptionVerifiedComments',
    'actionItem': 'Provide documentation showing good standing with IRS or provide an updated active 501c3'
  },
  <String, dynamic>{
    'text': 'Tax Exemption Verified Date:',
    'type': 'date',
    'databaseVar': 'TaxExemptionVerifiedDate',
    'databaseVarType': 'date',
    'databaseOptCom': 'TaxExemptionVerifiedDateComments',
  },
  <String, dynamic>{
    'text': 'Re-verified by:',
    'type': 'fillIn',
    'databaseVarType': 'string',
    'databaseVar': 'ReVerifiedBy',
  },
  // <String, dynamic>{
  //   'text': 'GCFD Monitor:',
  //   'type': 'fillIn',
  //   'databaseVarType': 'string',
  //   'databaseVar': 'GCFDMonitor',
  // },
  <String, dynamic>{
    'text': 'Reviewed by:',
    'type': 'fillIn',
    'databaseVarType': 'string',
    'databaseVar': 'ReviewedBy',
  },
  // <String, dynamic>{
  //   'text': 'Findings Found:',
  //   'type': 'yesNo',
  //   'databaseVarType': 'bool',
  //   'databaseVar': 'FindingsFound',
  //   'databaseOptCom': 'FindingsFoundComments'
  // },
];

List<Map<String, dynamic>> photoData = [
  <String, dynamic>{"filler": "material"}
];

List<Map<String, dynamic>> reviewData = [
  <String, dynamic>{"filler": "material"}
];

List<Map<String, dynamic>> verificationData = [
  <String, dynamic>{"filler": "material"}
];

List<Map<String, dynamic>> developerData = [
  <String, dynamic>{"filler": "material"}
];

List<Map<String, List<Map<String, dynamic>>>> pantryAuditSectionsQuestions = [
  <String, List<Map<String, dynamic>>>{"Confirm Details": confirmDetails},
  <String, List<Map<String, dynamic>>>{"Intro": audit1Section1Questions},
  <String, List<Map<String, dynamic>>>{"Signage": audit1Section2Questions},
  <String, List<Map<String, dynamic>>>{"Distribution & Intake": audit1Section3Questions},
  <String, List<Map<String, dynamic>>>{"Dry Storage": audit1Section4Questions},
  <String, List<Map<String, dynamic>>>{"Cold Storage": audit1Section5Questions},
  <String, List<Map<String, dynamic>>>{"Other": audit1Section6Questions},
  <String, List<Map<String, dynamic>>>{"Complaints & Problems": audit1Section7Questions},
  <String, List<Map<String, dynamic>>>{"Photos": photoData},
  <String, List<Map<String, dynamic>>>{"Review": reviewData},
  <String, List<Map<String, dynamic>>>{"Verification": verificationData},
  // <String, List<Map<String, dynamic>>>{"*Developer*": developerData},
];
