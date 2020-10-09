import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import '../CustomDataTable.dart';
import 'CalendarResultsDataSource.dart';
import 'CustomPaginatedDataTable.dart';
// import 'dart:async';

class ApptDataTable extends StatefulWidget {
  @override
  _ApptDataTableState createState() => _ApptDataTableState();
}

class _ApptDataTableState extends State<ApptDataTable> {
  String filterText = "";
  @override
  void initState() {
    super.initState();

    // Timer(Duration(microseconds: 100), () {
    //   _sort<String>((CalendarResult d) => d.startDateTime.toString(), 0, false);
    // });
  }

  CalendarResultsDataSource _calendarResultsDataSource = CalendarResultsDataSource([]);

  bool isLoaded = false;
  String lastFilterText = "";
  bool filterTimeToggle;
  int _rowsPerPage = CustomPaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex = 0;
  bool _sortAscending = false;

  void _sort<T>(Comparable<T> getField(CalendarResult d), int columnIndex, bool ascending) {
    print('columnIndex: $columnIndex');
    print('ascending: $ascending');
    _calendarResultsDataSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  void getData(Box calendarBox) {
    print("entered getData");

    List<CalendarResult> calendarResults = [];
    if (calendarBox != null) {
      calendarResults = calendarBox.values.toList() as List<CalendarResult>;
      print(calendarResults);
    } else {
      print("calendar results are null");
    }

    List<CalendarResult> filteredCalendarResults = filter(calendarResults);

    calendarResults = filterTimeApply(filteredCalendarResults);
    bool newEventAdded = Provider.of<ListCalendarData>(context, listen: false).newEventAdded;

    bool firstload_or_StartFiltering_or_DeleteFilter_or_AddEvent = !isLoaded ||
        (lastFilterText != filterText && filterText != "") ||
        (lastFilterText.length == 1 && filterText == "") ||
        newEventAdded;

    if (firstload_or_StartFiltering_or_DeleteFilter_or_AddEvent) {
      // setState(() {
      _calendarResultsDataSource = CalendarResultsDataSource(calendarResults);
      isLoaded = true;
      Provider.of<ListCalendarData>(context, listen: false).lastFilterValue = filterText;
      Provider.of<ListCalendarData>(context, listen: false).newEventAdded = false;
      // });
    }
  }

  List<CalendarResult> filter(List<CalendarResult> listToFilter) {
    List<CalendarResult> filteredResults = [];
    if (filterText != "") {
      for (CalendarResult result in listToFilter) {
        if (result.agencyName.toLowerCase().contains(filterText.toLowerCase())) {
          filteredResults.add(result);
        } else if (result.programNum.toLowerCase().contains(filterText.toLowerCase())) {
          filteredResults.add(result);
        }
      }
      return filteredResults;
    }
    return listToFilter;
  }

  Map<String, DateTime> getTimeRange() {
    DateTime now = DateTime.now();
    DateTime future = now.add(Duration(days: 7));
    DateTime past = now.subtract(Duration(days: 7));
    return {'past': past, 'future': future};
  }

  List<CalendarResult> filterTimeApply(List<CalendarResult> listToFilter) {
    List<CalendarResult> filteredResults = [];

    if (filterTimeToggle) {
      Map<String, DateTime> range = getTimeRange();
      for (CalendarResult result in listToFilter) {
        DateTime resultTime = result.startDateTime;
        if (resultTime.isAfter(range['past']) && resultTime.isBefore(range['future'])) {
          filteredResults.add(result);
        }
      }
      return filteredResults;
    }
    return listToFilter;
  }

  @override
  Widget build(BuildContext context) {
    bool initializedx = Provider.of<ListCalendarData>(context).initializedx;
    filterTimeToggle = Provider.of<ListCalendarData>(context, listen: false).filterTimeToggle;

    lastFilterText = Provider.of<ListCalendarData>(context, listen: false).lastFilterValue;
    filterText = Provider.of<ListCalendarData>(context, listen: false).filterValue;
    print("building paginated data table");
    Box calendarBox = Provider.of<ListCalendarData>(context).calendarBox;
    getData(calendarBox);
    print("BUILD PAGINATEDDATATABLE2");
    // _sort<String>((CalendarResult d) => d.startDateTime.toString(),
    //     _sortColumnIndex, _sortAscending);
    return !initializedx
        ? (Text("Initializing..."))
        : Expanded(
            child: Container(
              color: ColorDefs.colorTimeBackground,
              child: SingleChildScrollView(
                child: CustomPaginatedDataTable(
                  source: _calendarResultsDataSource,
                  showCheckboxColumn: false,
                  headingRowHeight: 70,
                  headingRowColor: ColorDefs.colorLogoDarkGreen,
                  rowsPerPage: _rowsPerPage,
                  onRowsPerPageChanged: (int value) {
                    setState(() {
                      print("value: $value");
                      print("_calendarResultsDataSource.rowCount: ${_calendarResultsDataSource.rowCount}");
                      _rowsPerPage = value;
                      print(_rowsPerPage);
                    });
                  },
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  columnSpacing: 0,
                  dataRowHeight: 60,
                  horizontalMargin: 0,
                  columns: <CustomDataColumn>[
                    CustomDataColumn(
                        label: Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                          child: Text('Date', style: ColorDefs.textBodyWhite20),
                        ),
                        numeric: false,
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((CalendarResult d) => d.startDateTime.toString(), columnIndex, ascending)),
                    CustomDataColumn(
                      label: Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                        child: Text('Start', style: ColorDefs.textBodyWhite20),
                      ),
                      numeric: false,
                      onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((CalendarResult d) => d.startTime, columnIndex, ascending),
                    ),
                    CustomDataColumn(
                        label: Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                          child: Text('Agency', style: ColorDefs.textBodyWhite20),
                        ),
                        numeric: false,
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((CalendarResult d) => d.agencyName, columnIndex, ascending)),
                    CustomDataColumn(
                        label: Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                          child: Text('Prog #', style: ColorDefs.textBodyWhite20),
                        ),
                        numeric: false,
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((CalendarResult d) => d.programNum, columnIndex, ascending)),
                    CustomDataColumn(
                        label: Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                          child: Text('Audit Type', style: ColorDefs.textBodyWhite20),
                        ),
                        numeric: false,
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((CalendarResult d) => d.auditType, columnIndex, ascending)),
                    // DataColumn(
                    //     label: Expanded(
                    //         child: Center(
                    //             child: Text('Prog Type',
                    //                 style: ColorDefs.textBodyBlue20))),
                    //     numeric: false,
                    //     onSort: (int columnIndex, bool ascending) =>
                    //         _sort<String>((CalendarResult d) => d.programType,
                    //             columnIndex, ascending)),
                    CustomDataColumn(
                        label: Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                          child: Text('Auditor', style: ColorDefs.textBodyWhite20),
                        ),
                        numeric: false,
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((CalendarResult d) => d.auditor, columnIndex, ascending)),
                    CustomDataColumn(
                        label: Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                          child: Text('Status', style: ColorDefs.textBodyWhite20),
                        ),
                        numeric: false,
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((CalendarResult d) => d.status, columnIndex, ascending)),
                  ],
                ),
              ),
            ),
          );
  }
}
