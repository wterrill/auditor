import 'colorDefs.dart';

Map<String, dynamic> programTypeTextAndColorLookup(String site) {
  Map<String, dynamic> endColorText;
  switch (site) {
    case ("Pantry"):
      endColorText = <String, dynamic>{'color': ColorDefs.colorAudit3, 'text': ColorDefs.textBodyWhite20};
      break;

    case ("Pantry Audit"):
      endColorText = <String, dynamic>{'color': ColorDefs.colorAudit3, 'text': ColorDefs.textBodyWhite20};
      break;

    case ("Older Adults Program"):
      endColorText = <String, dynamic>{'color': ColorDefs.colorAudit2, 'text': ColorDefs.textBodyBlack20};
      break;

    case ("Healthy Student Market"):
      endColorText = <String, dynamic>{'color': ColorDefs.colorAudit1, 'text': ColorDefs.textBodyWhite20};
      break;

    case ("Congregate"):
      endColorText = <String, dynamic>{'color': ColorDefs.colorAudit4, 'text': ColorDefs.textBodyWhite20};
      break;
    case ("Congregate Audit"):
      endColorText = <String, dynamic>{'color': ColorDefs.colorAudit4, 'text': ColorDefs.textBodyWhite20};
      break;
    case ("Audit 1"):
      endColorText = <String, dynamic>{'color': ColorDefs.colorAudit1, 'text': ColorDefs.textBodyWhite20};
      break;

    case ("Audit 2"):
      endColorText = <String, dynamic>{'color': ColorDefs.colorAudit2, 'text': ColorDefs.textBodyBlack20};
      break;

    case ("Audit 3"):
      endColorText = <String, dynamic>{'color': ColorDefs.colorAudit3, 'text': ColorDefs.textBodyWhite20};
      break;

    case ("Audit 4"):
      endColorText = <String, dynamic>{'color': ColorDefs.colorAudit4, 'text': ColorDefs.textBodyWhite20};
      break;

    // case ("Audit 5"):
    //   endColorText = <String, dynamic>{
    //     'color': ColorDefs.colorAudit5,
    //     'text': ColorDefs.textBodyBlack20
    //   };
    //   break;
  }
  print(site);
  return endColorText;
}
