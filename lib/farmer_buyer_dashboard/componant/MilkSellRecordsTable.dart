// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';

class MilkSellRecordsTable extends StatefulWidget {
  final List<Map<String, dynamic>> milkData; // Replace with your actual data
  const MilkSellRecordsTable({super.key, required this.milkData});

  @override
  State<MilkSellRecordsTable> createState() => _MilkSellRecordsTableState();
}

class _MilkSellRecordsTableState extends State<MilkSellRecordsTable> {
  double _totalWeight = 0;
  double _totalAmount = 0;

  @override
  void initState() {
    super.initState();
    _calculateTotals();
  }

  void _calculateTotals() {
    _totalWeight =
        widget.milkData.fold(0, (sum, item) => sum + item['quantity']);
    _totalAmount =
        widget.milkData.fold(0, (sum, item) => sum + item['total_price']);
  }

  @override
  void didUpdateWidget(covariant MilkSellRecordsTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.milkData != widget.milkData) {
      _calculateTotals();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
          top: 0,
          bottom: 60, // Adjust the height of the summary row
          left: 0,
          right: 0,
          child: SingleChildScrollView(
              child: Column(children: [
            DataTable(
                decoration: BoxDecoration(shape: BoxShape.rectangle),
                headingRowColor: WidgetStateProperty.all(AppColor.appColor),
                dataTextStyle:
                    TextStyle(fontSize: 14.0, color: AppColor.appColor),
                columnSpacing: (MediaQuery.of(context).size.width / 8) / 16,
                horizontalMargin: 10.0,
                headingTextStyle:
                    TextStyle(fontSize: 14.0, color: AppColor.whiteClr),
                columns: _buildColumns(),
                rows: widget.milkData.isNotEmpty
                    ? widget.milkData
                        .map((item) =>
                            _buildDataRow(item.cast<String, dynamic>()))
                        .toList()
                    : [
                        DataRow(
                            cells: List.generate(7, (index) => DataCell.empty))
                      ])
          ]))),
      Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
              color: AppColor.appColor, // Set the background color
              child: DataTable(
                  decoration: BoxDecoration(shape: BoxShape.rectangle),
                  headingRowColor: WidgetStateProperty.all(AppColor.appColor),
                  dataTextStyle:
                      TextStyle(fontSize: 14.0, color: AppColor.appColor),
                  columnSpacing: (MediaQuery.of(context).size.width / 8) / 16,
                  horizontalMargin: 10.0,
                  headingTextStyle:
                      TextStyle(fontSize: 14.0, color: AppColor.whiteClr),
                  headingRowHeight: 0, // Hide the heading row
                  columns:
                      _buildColumnstype2(), // Provide the same columns for consistency
                  rows: _buildSummaryRows())))
    ]);
  }

  List<DataColumn> _buildColumns() {
    const columnHeaders = [
      'Shift',
      'Date',
      'Weight',
      'FAT/SNF',
      'Rate',
      'Bonus',
      'Total'
    ];
    return columnHeaders
        .map((header) => DataColumn(
            label: Container(
                width: MediaQuery.of(context).size.width /
                    8, // Fixed width for each column
                alignment: Alignment.center,
                child: Text(header, textAlign: TextAlign.center))))
        .toList();
  }

  List<DataColumn> _buildColumnstype2() {
    const columnHeaders = ['Total Qunatity', 'Total Qunatity'];
    return columnHeaders
        .map((header) => DataColumn(
            label: Container(
                width: MediaQuery.of(context).size.width /
                    8, // Fixed width for each column
                alignment: Alignment.center,
                child: Text(header, textAlign: TextAlign.center))))
        .toList();
  }

  DataRow _buildDataRow(Map<String, dynamic> data) {
    final cellWidth = MediaQuery.of(context).size.width / 8;
    final date = DateTime.parse(data['date']);
    final formattedDate = DateFormat('dd MMM').format(date);
    return DataRow(
      cells: [
        DataCell(
          Container(
            width: cellWidth, // Set fixed width
            child: Center(
              child: Icon(
                (data['shift'] == 'M') ? Icons.sunny : Icons.nightlight,
                size: 20.0,
                color: AppColor.appColor, // Adjust color as needed
              ),
            ),
          ),
        ),
        dataCell(txt: formattedDate),
        dataCell(txt: '${data['quantity'].toStringAsFixed(2)} L'),
        dataCell(
            txt:
                '${data['fat'].toStringAsFixed(1)}/${data['snf'].toStringAsFixed(1)}'),
        dataCell(txt: data['price'].toStringAsFixed(2)),
        dataCell(txt: data['bonus'].toStringAsFixed(2)),
        dataCell(txt: data['total_price'].toStringAsFixed(2))
      ],
    );
  }

  dataCell({txt}) {
    final cellWidth = MediaQuery.of(context).size.width / 8;
    return DataCell(
      Container(
        width: cellWidth, // Set fixed width
        child: Center(
          child: Text('$txt'),
        ),
      ),
    );
  }

  List<DataRow> _buildSummaryRows() {
    TextStyle __textstyle = TextStyle(
        fontSize: 16.0, color: AppColor.whiteClr, fontWeight: FontWeight.bold);
    return [
      DataRow(
        color: WidgetStateProperty.all(AppColor.appColor),
        cells: [
          DataCell(
            Text(
              'Total Quantity \n ${_totalWeight.toStringAsFixed(2)} L',
              style: __textstyle,
            ),
          ),
          DataCell(
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                textAlign: TextAlign.end,
                'Total Amount \n ${_totalAmount.toStringAsFixed(2)}',
                style: __textstyle,
              ),
            ),
          ),
        ],
      ),
    ];
  }
}
