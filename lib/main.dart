import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> Mycolumn = [
    'Column1',
    'Column2',
    'Column3',
    'Column4',
    'Strike',
    'IV',
    'Column7',
    'Column8',
    'Column9',
    'Column10',
    'Column11',
    'Column12',
  ];
  final List<List<String>> Myrow = [
    [
      'Row1Col1',
      'Row1Col2',
      'Row1Col3',
      'Row1Col4',
      'Row1Col5',
      'Row1Col6',
      'Row1Col7',
      'Row1Col8',
      'Row1Col9',
      'Row1Col10',
      'Row1Col11',
      'Row1Col12',
    ],
    [
      'Row2Col1',
      'Row2Col2',
      'Row2Col3',
      'Row2Col4',
      'Row2Col5',
      'Row2Col6',
      'Row2Col7',
      'Row2Col8',
      'Row2Col9',
      'Row2Col10',
      'Row2Col11',
      'Row2Col12',
    ],
    [
      'Row1Col1',
      'Row1Col2',
      'Row1Col3',
      'Row1Col4',
      'Row1Col5',
      'Row1Col6',
      'Row1Col7',
      'Row1Col8',
      'Row1Col9',
      'Row1Col10',
      'Row1Col11',
      'Row1Col12',
    ],
    [
      'Row2Col1',
      'Row2Col2',
      'Row2Col3',
      'Row2Col4',
      'Row2Col5',
      'Row2Col6',
      'Row2Col7',
      'Row2Col8',
      'Row2Col9',
      'Row2Col10',
      'Row2Col11',
      'Row2Col12',
    ],
    [
      'Row1Col1',
      'Row1Col2',
      'Row1Col3',
      'Row1Col4',
      'Row1Col5',
      'Row1Col6',
      'Row1Col7',
      'Row1Col8',
      'Row1Col9',
      'Row1Col10',
      'Row1Col11',
      'Row1Col12',
    ],
    [
      'Row2Col1',
      'Row2Col2',
      'Row2Col3',
      'Row2Col4',
      'Row2Col5',
      'Row2Col6',
      'Row2Col7',
      'Row2Col8',
      'Row2Col9',
      'Row2Col10',
      'Row2Col11',
      'Row2Col12',
    ],
    [
      'Row1Col1',
      'Row1Col2',
      'Row1Col3',
      'Row1Col4',
      'Row1Col5',
      'Row1Col6',
      'Row1Col7',
      'Row1Col8',
      'Row1Col9',
      'Row1Col10',
      'Row1Col11',
      'Row1Col12',
    ],
    // Add more rows as needed
  ];

  final ScrollController _leftScrollController = ScrollController();
  final ScrollController _rightScrollController = ScrollController();

  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();
    _leftScrollController.addListener(() {
      if (_isSyncing) return;
      _isSyncing = true;
      if (_leftScrollController.hasClients &&
          _rightScrollController.hasClients) {
        double newOffset = _leftScrollController.position.maxScrollExtent -
            _leftScrollController.offset;
        // Ensure the right scroll does not exceed the maximum extent
        double maxScrollExtent =
            _rightScrollController.position.maxScrollExtent;
        if (newOffset > maxScrollExtent) {
          newOffset = maxScrollExtent;
        }
        _rightScrollController.jumpTo(newOffset);
      }
      _isSyncing = false;
    });

    _rightScrollController.addListener(() {
      if (_isSyncing) return;
      _isSyncing = true;
      if (_rightScrollController.hasClients &&
          _leftScrollController.hasClients) {
        double newOffset = _rightScrollController.position.maxScrollExtent -
            _rightScrollController.offset;
        // Ensure the left scroll does not exceed the maximum extent
        double maxScrollExtent = _leftScrollController.position.maxScrollExtent;
        if (newOffset > maxScrollExtent) {
          newOffset = maxScrollExtent;
        }
        _leftScrollController.jumpTo(newOffset);
      }
      _isSyncing = false;
    });
  }

  @override
  void dispose() {
    _leftScrollController.dispose();
    _rightScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('DataTable'),
            centerTitle: true,
            backgroundColor: Colors.pink,
          ),
          body: Container(
            height: 900,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
            child: Stack(
              children: [
                // Left scrollable part
                Positioned(
                  left: 0,
                  top: 40,
                  bottom: 0,
                  right: MediaQuery.of(context).size.width / 2 + 100,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _leftScrollController,
                    child: DataTable(
                      columnSpacing: 1,
                      dataRowColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.yellow[100]),
                      dataRowHeight: 40,
                      headingRowHeight: 70,
                      headingRowColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.grey[300]),
                      dataTextStyle:
                          TextStyle(fontSize: 11, color: Colors.black),
                      headingTextStyle:
                          TextStyle(fontSize: 11, color: Colors.blue),
                      dividerThickness: 2,
                      showBottomBorder: true,
                      border: TableBorder(
                        verticalInside:
                            BorderSide(color: Colors.black, width: 1),
                        horizontalInside:
                            BorderSide(color: Colors.black, width: 1),
                        top: BorderSide(color: Colors.blue, width: 1),
                      ),
                      columns: Mycolumn.sublist(0, 4)
                          .map((e) => DataColumn(label: Text(e)))
                          .toList(),
                      rows: Myrow.map((row) {
                        return DataRow(
                            cells: row
                                .sublist(0, 4)
                                .map((cell) => DataCell(Text(cell)))
                                .toList());
                      }).toList(),
                    ),
                  ),
                ),
                // Fixed columns in the middle
                // Fixed columns in the middle
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 100,
                  top: 40,
                  bottom: 0,
                  child: Container(
                    width: 200,
                    color: Colors.white,
                    child: DataTable(
                      columnSpacing: 1,
                      dataRowColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.grey[100]),
                      dataRowHeight: 40,
                      headingRowHeight: 70,
                      headingRowColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.grey[300]),
                      dataTextStyle:
                          TextStyle(fontSize: 11, color: Colors.black),
                      headingTextStyle:
                          TextStyle(fontSize: 11, color: Colors.blue),
                      dividerThickness: 2,
                      showBottomBorder: true,
                      border: TableBorder(
                        verticalInside:
                            BorderSide(color: Colors.black, width: 1),
                        horizontalInside:
                            BorderSide(color: Colors.black, width: 1),
                        top: BorderSide(color: Colors.blue, width: 1),
                        left: BorderSide(
                            color: Colors.black, width: 1), // Add left border
                        right: BorderSide(
                            color: Colors.black, width: 1), // Add right border
                      ),
                      columns: Mycolumn.sublist(4, 6)
                          .map((e) => DataColumn(label: Text(e)))
                          .toList(),
                      rows: Myrow.map((row) {
                        return DataRow(
                            cells: row
                                .sublist(4, 6)
                                .map((cell) => DataCell(Text(cell)))
                                .toList());
                      }).toList(),
                    ),
                  ),
                ),
                // Right scrollable part
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 + 100,
                  top: 40,
                  bottom: 0,
                  right: 0,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _rightScrollController,
                    child: DataTable(
                      columnSpacing: 1,
                      dataRowColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white),
                      dataRowHeight: 40,
                      headingRowHeight: 70,
                      headingRowColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.grey[300]),
                      dataTextStyle:
                          TextStyle(fontSize: 11, color: Colors.black),
                      headingTextStyle:
                          TextStyle(fontSize: 11, color: Colors.blueAccent),
                      dividerThickness: 2,
                      showBottomBorder: true,
                      border: TableBorder(
                        verticalInside:
                            BorderSide(color: Colors.black, width: 1),
                        horizontalInside:
                            BorderSide(color: Colors.black, width: 1),
                        top: BorderSide(color: Colors.blue, width: 1),
                      ),
                      columns: Mycolumn.sublist(7, 11)
                          .map((e) => DataColumn(label: Text(e)))
                          .toList(),
                      rows: Myrow.map((row) {
                        return DataRow(
                            cells: row
                                .sublist(7, 11)
                                .map((cell) => DataCell(Text(cell)))
                                .toList());
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
