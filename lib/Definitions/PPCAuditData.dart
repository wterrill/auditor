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
];

List<Map<String, dynamic>> audit3Section1Questions = [
  <String, dynamic>{
    'text': 'Does Site ensure safe and sanitary conditions are followed? (wearing gloves)',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'EnsuresSafety',
    'databaseOptCom': 'EnsuresSafetyComments',
    'databaseVarType': 'bool',
    'actionItem': 'Site must ensure safe and sanitary procedures are followed '
  },
  <String, dynamic>{
    'text': 'Does Site distribute proper allocation of produce items, dry items and boxes if applicable?',
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'N/A'],
    'databaseVar': 'DistributesProperAllocation',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DistributesProperAllocationComments',
    'actionItem': 'Site must ensure proper allocations of produce, dry items and boxes are being conducted  '
  },
  <String, dynamic>{
    'text': 'Does Site follow proper intake procedures? (checking ID, roster, etc.)',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'FollowsProperIntake',
    'databaseVarType': 'bool',
    'databaseOptCom': 'FollowsProperIntakeComments',
    'actionItem': 'Site must ensure proper intake procedures are being followed '
  },
  <String, dynamic>{
    'text': 'Does Site maintain proper program records on site?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'MaintainsProperRecords',
    'databaseVarType': 'bool',
    'databaseOptCom': 'MaintainsProperRecordsComments',
    'actionItem': 'Site must ensure program records are kept on site '
  },
  <String, dynamic>{
    'text': 'Does Site have adequate storage for left over dry items or boxes, if applicable?',
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'N/A'],
    'databaseVar': 'HasAdequateStorage',
    'databaseVarType': 'bool',
    'databaseOptCom': 'HasAdequateStorageComments',
    'actionItem': 'Site must ensure adequate storage is utilized for leftover dry items and boxes '
  },
  <String, dynamic>{
    'text': 'Does Site have proper staff oversight of distribution?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'HasProperOversight',
    'databaseVarType': 'bool',
    'databaseOptCom': 'HasProperOversightComments',
    'actionItem': 'Site must ensure proper staff oversight during distribution '
  },
  <String, dynamic>{
    'text': 'Does Site properly discard extra produce after distribution?',
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'N/A'],
    'databaseVar': 'DiscardsExtraProduce',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DiscardsExtraProduceComments',
    'actionItem': 'Site must ensure extra produce is properly discarded '
  },
  <String, dynamic>{
    'text': 'Is Distribution space clean and organized?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'DistributionCleanOrganized',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DistributionCleanOrganizedComments',
    'actionItem': 'Site must keep Distribution space clean and organized '
  },
  <String, dynamic>{
    'text': 'Is Site operating as a client choice model? (no pre-bagged items)',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'IsClientChoiceModel',
    'databaseVarType': 'bool',
    'databaseOptCom': 'IsClientChoiceModelComments',
    'actionItem': 'Site must operate under the client choice model'
  },
  <String, dynamic>{
    'text': 'Is Site distributing flyers advertising distribution date and time?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'DistributesFlyers',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DistributesFlyersComments',
    'actionItem': 'Site must ensure flyers are being distributed'
  },
  <String, dynamic>{
    'text': 'Is the Food Depository contact information posted at distribution?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'DepositoryContactIsPosted',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DepositoryContactIsPostedComments',
    'actionItem': 'Site must post Food Depository contact information at distribution'
  },
  <String, dynamic>{
    'text': 'Are only eligible clients participating in distribution?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'OnlyEligibleClients',
    'databaseVarType': 'bool',
    'databaseOptCom': 'OnlyEligibleClientsComments',
    'actionItem': 'Site must ensure only eligible clients participate in distribution'
  },
  <String, dynamic>{
    'text': 'Are Proxy forms used when appropriate?',
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'N/A'],
    'databaseVar': 'ProxyFormsUsed',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ProxyFormsUsedComments',
    'actionItem': 'Site must ensure Proxy forms are used '
  },
  <String, dynamic>{
    'text': 'Is Site soliciting donations, services and / or memberships?',
    'type': 'yesNo',
    'happyPathResponse': ['No'],
    'databaseVar': 'DoesNotSolicit',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DoesNotSolicitComments',
    'actionItem': 'Site must ensure no soliciting of donations, services and or memberships are conducted'
  },
  <String, dynamic>{
    'text': 'Are eligible volunteers receiving food at the end of the distribution?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'VolunteersReceiveFood',
    'databaseVarType': 'bool',
    'databaseOptCom': 'VolunteersReceiveFoodComments',
    'actionItem': 'Site must ensure eligible volunteers are receiving food at the end of distribution'
  },
  <String, dynamic>{
    'text': 'Are monthly surveys up to date?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'MonthlySurveysNotUpToDate',
    'databaseVarType': 'bool',
    'databaseOptCom': 'MonthlySurveysNotUpToDateComments',
    'actionItem': 'Site must ensure monthly surveys are up to date'
  },
  <String, dynamic>{
    'text': 'Is the Contact person information up to date?',
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'N/A'],
    'databaseVar': 'ContactPersonIsUpToDate',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ContactPersonIsUpToDateComments',
    'actionItem': 'Site must ensure Contact information is up to date'
  },
  <String, dynamic>{
    'text': 'Other:',
    'type': 'fillIn',
    'databaseVar': 'OtherQuestion',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Does site provide resources?',
    'type': 'yesNo',
    'databaseVar': 'SiteProvidesResources',
    'databaseVarType': 'bool',
    'databaseOptCom': 'SiteProvidesResourcesComments',
  },
  <String, dynamic>{
    'text': 'Does site have a waiting area?',
    'type': 'yesNo',
    'databaseVar': 'HasWaitingArea',
    'databaseVarType': 'bool',
    'databaseOptCom': 'HasWaitingAreaComments',
  },
  <String, dynamic>{
    'text': 'If Site has a waiting area, where:',
    'type': 'fillIn',
    'databaseVar': 'SiteWaitingAreaLocation',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Where is the distribution done?',
    'type': 'fillIn',
    'databaseVar': 'DistributionLocation',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Is the site media ready?',
    'type': 'yesNo',
    'databaseVar': 'SiteMediaIsReady',
    'databaseVarType': 'bool',
    'databaseOptCom': 'SiteMediaIsReadyComments',
  },
  <String, dynamic>{
    'text': 'General Comments:',
    'type': 'fillIn',
    'databaseVar': 'Comments',
    'databaseVarType': 'string',
  },
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

List<Map<String, List<Map<String, dynamic>>>> pPCAuditSectionsQuestions = [
  <String, List<Map<String, dynamic>>>{"Confirm Details": confirmDetails},
  <String, List<Map<String, dynamic>>>{"Policies": audit3Section1Questions},
  <String, List<Map<String, dynamic>>>{"Photos": photoData},
  <String, List<Map<String, dynamic>>>{"Review": reviewData},
  <String, List<Map<String, dynamic>>>{"Verification": verificationData},
  <String, List<Map<String, dynamic>>>{"*Developer*": developerData},
];
