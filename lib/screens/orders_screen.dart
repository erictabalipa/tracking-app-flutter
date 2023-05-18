import 'dart:convert';

import 'package:app_pinho_express/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../components/app_top_navigation.dart';
import '../components/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _dataOrder = [];
  List<Map<String, dynamic>> _dataOrderFiltered = [];
  bool _sortAscending = true;
  int _sortColumnIndex = 0;
  int _statusCode = 1;
  bool selectedOne = true;
  bool selectedTwo = false;
  bool selectedTree = false;
  bool selectedFour = false;

  void _sort<T>(
    Comparable<T> Function(Map<String, dynamic>) getField,
    int columnIndex,
    bool ascending,
  ) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      _dataOrderFiltered.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return ascending
            ? Comparable.compare(aValue, bValue)
            : Comparable.compare(bValue, aValue);
      });
    });
  }

  Future<void> getData(_statusCode) async {
    final headers = {
      'apikey':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdmaGVmZ2huYmFrZ29vcGlvbGdlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4MjYwNDExMSwiZXhwIjoxOTk4MTgwMTExfQ.X-_oDqgUBmr9yjcexk3KnkmAPVjOhhE34NgmvbnQxTA',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdmaGVmZ2huYmFrZ29vcGlvbGdlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4MjYwNDExMSwiZXhwIjoxOTk4MTgwMTExfQ.X-_oDqgUBmr9yjcexk3KnkmAPVjOhhE34NgmvbnQxTA',
    };
    String url = '';
    if (_statusCode == 1) {
      url =
          'https://gfhefghnbakgoopiolge.supabase.co/rest/v1/order?status_code=eq.1&select=*';
      setState(() {
        selectedOne = true;
        selectedTwo = false;
        selectedTree = false;
        selectedFour = false;
      });
    } else if (_statusCode == 2) {
      url =
          'https://gfhefghnbakgoopiolge.supabase.co/rest/v1/order?status_code=eq.2&select=*';
          setState(() {
        selectedOne = false;
        selectedTwo = true;
        selectedTree = false;
        selectedFour = false;
      });
    } else if (_statusCode == 3) {
      url =
          'https://gfhefghnbakgoopiolge.supabase.co/rest/v1/order?status_code=eq.3&select=*';
          setState(() {
        selectedOne = false;
        selectedTwo = false;
        selectedTree = true;
        selectedFour = false;
      });
    } else {
      url =
          'https://gfhefghnbakgoopiolge.supabase.co/rest/v1/order?status_code=eq.4&select=*';
          setState(() {
        selectedOne = false;
        selectedTwo = false;
        selectedTree = false;
        selectedFour = true;
      });
    }
    final responseOrder = await http.get(Uri.parse(url), headers: headers);

    // Check if the responseOrder is successful
    if (responseOrder.statusCode == 200) {
      final dataOrder = jsonDecode(responseOrder.body);
      setState(() {
        _dataOrder = List<Map<String, dynamic>>.from(dataOrder);
        _dataOrderFiltered = List<Map<String, dynamic>>.from(dataOrder);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  TextStyle _getTextStyle(Map<String, dynamic> data) {
    Color textColor = data['color'].toString() == 'green'
        ? Colors.green
        : data['color'].toString() == 'yellow'
            ? const Color.fromARGB(255, 209, 193, 44)
            : data['color'].toString() == 'red'
                ? Colors.red
                : Colors.grey;
    return TextStyle(
      color: textColor,
    );
  }

  @override
  void initState() {
    super.initState();
    getData(_statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopNavigation(title: 'PEDIDOS'),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              // used padding just for demo purpose to separate from the appbar and the main content
              padding: const EdgeInsets.all(5),

              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        child: Container(
                            height: 30,
                            padding: const EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width * 0.975,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: InkWell(
                                        onTap: () => getData(_statusCode = 1),
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: selectedOne ? Colors.blue : Colors.white,
                                              borderRadius: const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  topLeft: Radius.circular(5))),
                                          child: Text(
                                              "PRONTO PARA EMBARQUE",
                                              style: TextStyle(
                                                  color: selectedOne ? Colors.white : Colors.blue,
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600)),
                                        ))),
                                        Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical:0),
                                    child: Container(
                                        color: selectedOne || selectedTwo
                                            ? Colors.transparent
                                            : Colors.blue,
                                        width: 1)),
                                       
                                Expanded(
                                    child: InkWell(
                                        onTap: () => getData(_statusCode = 2),
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: selectedTwo
                                                  ? Colors.blue
                                                  : Colors.white,
                                              ),
                                          child: Text(
                                              "EM TRÂNSITO INTERNACIONAL",
                                              style: TextStyle(
                                                  color: selectedTwo ? Colors.white : Colors.blue,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600)),
                                        ))),
                                Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical:0),
                                    child: Container(
                                        color: selectedTwo || selectedTree
                                            ? Colors.transparent
                                            : Colors.blue, width: 1)),
                                Expanded(
                                    child: InkWell(
                                        onTap: () => getData(_statusCode = 3),
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: selectedTree
                                                  ? Colors.blue
                                                  : Colors.white,
                                              ),
                                          child: Text(
                                              "CUSTOMER CLEARENCE",
                                              style: TextStyle(
                                                  color: selectedTree
                                                      ? Colors.white
                                                      : Colors.blue,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600)),
                                        ))),
                                Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical:0),
                                    child: Container(
                                        color: selectedTree || selectedFour
                                            ? Colors.transparent
                                            : Colors.blue, width: 1)),
                                Expanded(
                                    child: InkWell(
                                        onTap: () => getData(_statusCode = 4),
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: selectedFour
                                                  ? Colors.blue
                                                  : Colors.white,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomRight:
                                                          Radius.circular(5),
                                                      topRight:
                                                          Radius.circular(5))),
                                          child: Text("LIBERADO",
                                              style: TextStyle(
                                                  color: selectedFour
                                                      ? Colors.white
                                                      : Colors.blue,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600)),
                                        )))
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: PaginatedDataTable(
                          sortColumnIndex: _sortColumnIndex,
                          sortAscending: _sortAscending,
                          header: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: TextField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                labelText: 'Buscar registro',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                suffixIcon: Icon(Icons.search),
                                border: UnderlineInputBorder(),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _dataOrderFiltered = _dataOrder
                                      .where((data) =>
                                          data['order_code']
                                              .toLowerCase()
                                              .contains(value.toLowerCase()) ||
                                          data['ecommerce']
                                              .toLowerCase()
                                              .contains(value.toLowerCase()) ||
                                          data['supplier']
                                              .toLowerCase()
                                              .contains(value.toLowerCase()) ||
                                          data['buyer_name']
                                              .toLowerCase()
                                              .contains(value.toLowerCase()) ||
                                          data['consent']
                                              .toLowerCase()
                                              .contains(value.toLowerCase()) ||
                                          data['product_name']
                                              .toLowerCase()
                                              .contains(value.toLowerCase()))
                                      .toList();
                                });
                              },
                            ),
                          ),
                          columns: [
                            DataColumn(
                              label: const Text('ORDER',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12)),
                              onSort: (columnIndex, ascending) {
                                _sort<String>(
                                  (data) => data['order_code'].toString(),
                                  columnIndex,
                                  ascending,
                                );
                              },
                            ),
                            DataColumn(
                              label: const Text('ECOMMERCE',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12)),
                              onSort: (columnIndex, ascending) {
                                _sort<String>(
                                  (data) => data['ecommerce'].toString(),
                                  columnIndex,
                                  ascending,
                                );
                              },
                            ),
                            DataColumn(
                              label: const Text('FORNECEDOR',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12)),
                              onSort: (columnIndex, ascending) {
                                _sort<String>(
                                  (data) => data['supplier'].toString(),
                                  columnIndex,
                                  ascending,
                                );
                              },
                            ),
                            DataColumn(
                              label: const Text('COMPRADOR',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12)),
                              onSort: (columnIndex, ascending) {
                                _sort<String>(
                                  (data) => data['buyer_name'].toString(),
                                  columnIndex,
                                  ascending,
                                );
                              },
                            ),
                            DataColumn(
                              label: const Text('ANUÊNCIA',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12)),
                              onSort: (columnIndex, ascending) {
                                _sort<String>(
                                  (data) => data['consent'].toString(),
                                  columnIndex,
                                  ascending,
                                );
                              },
                            ),
                            DataColumn(
                              label: const Text('PRODUTO',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12)),
                              onSort: (columnIndex, ascending) {
                                _sort<String>(
                                  (data) => data['product_name'].toString(),
                                  columnIndex,
                                  ascending,
                                );
                              },
                            ),
                            DataColumn(
                              label: const Text('QTDE',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12)),
                              onSort: (columnIndex, ascending) {
                                _sort<int>(
                                  (data) => data['quantity'],
                                  columnIndex,
                                  ascending,
                                );
                              },
                            ),
                            DataColumn(
                              label: const Text('P.LÍQUIDO',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12)),
                              onSort: (columnIndex, ascending) {
                                _sort<double>(
                                  (data) => data['net_weight_und'],
                                  columnIndex,
                                  ascending,
                                );
                              },
                            ),
                            DataColumn(
                              label: const Text('P.BRUTO',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12)),
                              onSort: (columnIndex, ascending) {
                                _sort<double>(
                                  (data) => data['gross_weight_und'],
                                  columnIndex,
                                  ascending,
                                );
                              },
                            ),
                            DataColumn(
                              label: const Text('V.UNITÁRIO',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12)),
                              onSort: (columnIndex, ascending) {
                                _sort<double>(
                                  (data) => data['price_und'],
                                  columnIndex,
                                  ascending,
                                );
                              },
                            ),
                            DataColumn(
                              label: const Text('V.TOTAL',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12)),
                              onSort: (columnIndex, ascending) {
                                _sort<int>(
                                  (data) =>
                                      (data['quantity'] * data['price_und']),
                                  columnIndex,
                                  ascending,
                                );
                              },
                            ),
                            DataColumn(
                              label: const Text('TRIBUTO',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12)),
                              onSort: (columnIndex, ascending) {
                                _sort<double>(
                                  (data) =>
                                      (data['quantity'] *
                                      data['price_und'] *
                                      0.6) * 5,
                                  columnIndex,
                                  ascending,
                                );
                              },
                            ),
                          ],
                          source: YourDataTableSource(_dataOrderFiltered,
                              context: context),
                          rowsPerPage: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}

class YourDataTableSource extends DataTableSource {
  final formatCurrencyBrl =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  final formatCurrencyUsd =
      NumberFormat.currency(locale: 'pt_BR', symbol: '\$');

  TextStyle _getTextStyle(Map<String, dynamic> data) {
    Color textColor = data['color'].toString() == 'green'
        ? Colors.green
        : data['color'].toString() == 'yellow'
            ? const Color.fromARGB(255, 209, 193, 44)
            : data['color'].toString() == 'red'
                ? Colors.red
                : Colors.grey;
    return TextStyle(
      color: textColor,
    );
  }

  final List<Map<String, dynamic>> _data;

  final BuildContext context;

  YourDataTableSource(this._data, {required this.context});

  @override
  DataRow getRow(int index) {
    final data = _data[index];
    return DataRow(cells: [
      DataCell(InkWell(
          onTap: () {
            YourDataTableSource dataTableSource =
                YourDataTableSource(_data, context: context);
            dataTableSource
                .navigateToTrackingScreen(data['order_code'].toString());
          },
          child:
              Text(data['order_code'].toString(), style: _getTextStyle(data)))),
      DataCell(Text(
          data['ecommerce'].toString().substring(0, 1).toUpperCase() +
              data['ecommerce'].toString().substring(1),
          style: _getTextStyle(data))),
      DataCell(Text(data['supplier'].toString(), style: _getTextStyle(data))),
      DataCell(Text(data['buyer_name'].toString(), style: _getTextStyle(data))),
      DataCell(Text(data['consent'].toString(), style: _getTextStyle(data))),
      DataCell(
          Text(data['product_name'].toString(), style: _getTextStyle(data))),
      DataCell(Text(data['quantity'].toStringAsFixed(2),
          style: _getTextStyle(data))),
      DataCell(Text('${data['net_weight_und'].toStringAsFixed(2)} kg',
          style: _getTextStyle(data))),
      DataCell(Text('${data['gross_weight_und'].toStringAsFixed(2)} kg',
          style: _getTextStyle(data))),
      DataCell(Text(formatCurrencyUsd.format(data['price_und']),
          style: _getTextStyle(data))),
      DataCell(Text(
          formatCurrencyUsd.format(data['quantity'] * data['price_und']),
          style: _getTextStyle(data))),
      DataCell(Text(
          formatCurrencyBrl.format((data['quantity'] * data['price_und'] * 0.6) * 5),
          style: _getTextStyle(data))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;

  void navigateToTrackingScreen(String orderCode) {
    Navigator.of(context).pushNamed(
      AppRoutes.TRACKING_ROUTE,
      arguments: {'order': orderCode},
    );
  }
}
