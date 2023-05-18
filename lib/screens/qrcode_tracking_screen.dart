import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:app_pinho_express/components/linear_steps.dart';
import 'package:flutter/material.dart';
import '../components/app_top_navigation.dart';
import '../components/app_drawer.dart';

List<Map<String, dynamic>> _dataOrder = [];
List<Map<String, dynamic>> _dataOrderProduct = [];

Future<List<Map<String, dynamic>>> getDataOrder(String order) async {
  //API KEYS
  final headers = {
    'apikey':
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdmaGVmZ2huYmFrZ29vcGlvbGdlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4MjYwNDExMSwiZXhwIjoxOTk4MTgwMTExfQ.X-_oDqgUBmr9yjcexk3KnkmAPVjOhhE34NgmvbnQxTA',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdmaGVmZ2huYmFrZ29vcGlvbGdlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4MjYwNDExMSwiZXhwIjoxOTk4MTgwMTExfQ.X-_oDqgUBmr9yjcexk3KnkmAPVjOhhE34NgmvbnQxTA'
  };

  //REQUEST TO GET ORDER
  final responseOrder = await http.get(
      Uri.parse(
          'https://gfhefghnbakgoopiolge.supabase.co/rest/v1/order_details?tracking_code=eq.${order}&select=*'),
      headers: headers);

  // Check if the responseOrder is successful
  if (responseOrder.statusCode == 200) {
    final dataOrder = jsonDecode(responseOrder.body);
    _dataOrder = List<Map<String, dynamic>>.from(dataOrder);
    return List<Map<String, dynamic>>.from(dataOrder);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Map<String, dynamic>>> getDataOrderProduct(String order) async {
  //API KEYS
  final headers = {
    'apikey':
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdmaGVmZ2huYmFrZ29vcGlvbGdlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4MjYwNDExMSwiZXhwIjoxOTk4MTgwMTExfQ.X-_oDqgUBmr9yjcexk3KnkmAPVjOhhE34NgmvbnQxTA',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdmaGVmZ2huYmFrZ29vcGlvbGdlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4MjYwNDExMSwiZXhwIjoxOTk4MTgwMTExfQ.X-_oDqgUBmr9yjcexk3KnkmAPVjOhhE34NgmvbnQxTA'
  };

  //REQUEST TO GET PRODUCT OF ORDER
  final responseOrderProduct = await http.get(
      Uri.parse(
          'https://gfhefghnbakgoopiolge.supabase.co/rest/v1/product?code=eq.${order}&select=*'),
      headers: headers);

  // Check if the responseOrderProduct is successful
  if (responseOrderProduct.statusCode == 200) {
    final dataOrderProduct = jsonDecode(responseOrderProduct.body);
    _dataOrderProduct = List<Map<String, dynamic>>.from(dataOrderProduct);
    return List<Map<String, dynamic>>.from(dataOrderProduct);
  } else {
    throw Exception('Failed to load data');
  }
}

class QrCodeTrackingPage extends StatefulWidget {
  const QrCodeTrackingPage({Key? key, this.trackingCode}) : super(key: key);
  final String? trackingCode;
  @override
  State<QrCodeTrackingPage> createState() => _QrCodeTrackingPageState();
}

class _QrCodeTrackingPageState extends State<QrCodeTrackingPage> {
  String? qrCodeTrackingCode;
  final formatCurrencyBrl =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  final formatCurrencyUsd =
      NumberFormat.currency(locale: 'pt_BR', symbol: '\$');

  @override
  Widget build(BuildContext context) {
    qrCodeTrackingCode = widget.trackingCode;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'RASTREIO: #$qrCodeTrackingCode',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.white,
            ),
          )
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
            future: getDataOrder(qrCodeTrackingCode!),
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Return a loading indicator while waiting for data
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Handle any errors that may have occurred
                return const Center(child: Text('Failed to load data'));
              } else {
                // Once data has been retrieved, check if _dataOrder is not empty
                if (_dataOrder.isNotEmpty) {
                  // Set tracking_code to the value of _dataOrder[0]['id']
                  final orderStatus = _dataOrder.isNotEmpty
                      ? _dataOrder[0]['status'].toString()
                      : '';
                  final orderBuyerName = _dataOrder.isNotEmpty
                      ? _dataOrder[0]['buyer_name'].toString()
                      : '';
                  final orderBuyerDocType = _dataOrder.isNotEmpty
                      ? _dataOrder[0]['buyer_doc_type'].toString()
                      : '';
                  final orderBuyerDocNumber = _dataOrder.isNotEmpty
                      ? _dataOrder[0]['buyer_doc_number'].toString()
                      : '';
                  final orderEcommerce = _dataOrder.isNotEmpty
                      ? _dataOrder[0]['ecommerce'].toString()
                      : '';
                  final orderOriginCountry = _dataOrder.isNotEmpty
                      ? _dataOrder[0]['origin_country'].toString()
                      : '';
                  final orderTotalValue = _dataOrder.isNotEmpty
                      ? _dataOrder[0]['total_value'].toString()
                      : '';

                  // Return the widget tree with the tracking_code value interpolated into the Text widget

                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Card(
                        child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 3,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top:5),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      'STATUS ATUAL: ',
                                                      style: TextStyle(
                                                        fontFamily:'Poppins',
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 13,
                                                        color: Color.fromRGBO(66,70,77,1),
                                                      ),
                                                    ),
                                                    Text(
                                                      orderStatus.toUpperCase(),
                                                      style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 13,
                                                        color: Color.fromRGBO(127,133,141,1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          LinearStepsWidget(status: orderStatus),
                                          const Divider(),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 5, left: 5),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            Text(
                                                              'DATA: ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                fontSize: 12,
                                                                color:
                                                                    Color.fromRGBO(
                                                                        66,
                                                                        70,
                                                                        77,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              '20/03/2023',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 12,
                                                                color:
                                                                    Color.fromRGBO(
                                                                        127,
                                                                        133,
                                                                        141,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            width: 20),
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'ECOMMERCE: ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        66,
                                                                        70,
                                                                        77,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              orderEcommerce,
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 12,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        127,
                                                                        133,
                                                                        141,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'COMPRADOR: ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12,
                                                            color:
                                                                Color.fromRGBO(
                                                                    66,
                                                                    70,
                                                                    77,
                                                                    1),
                                                          ),
                                                        ),
                                                        Text(
                                                          '$orderBuyerName - $orderBuyerDocType: $orderBuyerDocNumber',
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 12,
                                                            color:
                                                                Color.fromRGBO(
                                                                    127,
                                                                    133,
                                                                    141,
                                                                    1),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                       mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Text(
                                                              'P.BRUTO: ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                fontSize: 12,
                                                                color:
                                                                    Color.fromRGBO(
                                                                        66,
                                                                        70,
                                                                        77,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              '0,435 kg   ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 12,
                                                                color:
                                                                    Color.fromRGBO(
                                                                        127,
                                                                        133,
                                                                        141,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            width: 12),
                                                        Row(
                                                          children: const [
                                                            Text(
                                                              'P. LÍQUIDO: ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        66,
                                                                        70,
                                                                        77,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              '0,410 kg',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 12,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        127,
                                                                        133,
                                                                        141,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'PAÍS DE ORIGEM: ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                fontSize: 12,
                                                                color:
                                                                    Color.fromRGBO(
                                                                        66,
                                                                        70,
                                                                        77,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              orderOriginCountry,
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 12,
                                                                color:
                                                                    Color.fromRGBO(
                                                                        127,
                                                                        133,
                                                                        141,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        
                                                        
                                                      ],
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: const [
                                                            Text(
                                                              'MOEDA: ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        66,
                                                                        70,
                                                                        77,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              'USD',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 12,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        127,
                                                                        133,
                                                                        141,
                                                                        1),
                                                              ),
                                                            ),
                                                              SizedBox(
                                                                width: 55),
                                                          ],
                                                        ),
                                                        
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'VALOR TOTAL: ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                fontSize: 12,
                                                                color:
                                                                    Color.fromRGBO(
                                                                        66,
                                                                        70,
                                                                        77,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              '\$ $orderTotalValue,00',
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 12,
                                                                color:
                                                                    Color.fromRGBO(
                                                                        127,
                                                                        133,
                                                                        141,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          const Divider(),
                                          FutureBuilder<
                                                  List<Map<String, dynamic>>>(
                                              future:
                                                  getDataOrderProduct(
                                                  qrCodeTrackingCode!),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<
                                                          List<
                                                              Map<String,
                                                                  dynamic>>>
                                                      snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const CircularProgressIndicator();
                                                }
                                                if (snapshot.hasError) {
                                                  return Text(
                                                      'Error: ${snapshot.error}');
                                                }
                                                final dataOrderProduct =
                                                    snapshot.data;
                                                return SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      2.5,
                                                  child: ListView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount: dataOrderProduct!
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final item =
                                                          dataOrderProduct[
                                                              index];
                                                      return SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child:
                                                                  _buildPanel(
                                                                      item),
                                                            ),
                                                            const Divider(
                                                                height: 0)
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              }),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    )),
                  );
                } else {
                  // If _dataOrder is empty, display a message to the user
                  return const Text(
                    'O CÓDIGO DE RASTREIO GERADO VIA QRCODE É INVÁLIDO OU INEXISTENTE',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Color.fromRGBO(66, 70, 77, 1),
                    ),
                  );
                }
              }
            }));
  }
}

Widget _buildPanel(Map<String, dynamic> item) {
  final formatCurrencyBrl =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  final formatCurrencyUsd =
      NumberFormat.currency(locale: 'pt_BR', symbol: '\$');
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'CÓDIGO DO PRODUTO: ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Color.fromRGBO(66, 70, 77, 1),
                    ),
                  ),
                  Text(
                    item['supplier_code'],
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Color.fromRGBO(127, 133, 141, 1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 150,
                height: 150,
                child: Container(
                  color: Colors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: Image.network(
                          item['image_url'],
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'NOME: ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Color.fromRGBO(66, 70, 77, 1),
                            ),
                          ),
                          Text(
                            item['name'],
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Color.fromRGBO(127, 133, 141, 1),
                            ),
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TSP/NCM: ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color.fromRGBO(66, 70, 77, 1),
                        ),
                      ),
                      Text(
                        item['ncm'],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Color.fromRGBO(127, 133, 141, 1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ESPECIFICACOES DA MERCADORIA: ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color.fromRGBO(66, 70, 77, 1),
                        ),
                      ),
                      const SizedBox(height: 2.5),
                      Text(
                        item['description'],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Color.fromRGBO(127, 133, 141, 1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height:10),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'QUANTIDADE: ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Color.fromRGBO(66, 70, 77, 1),
                            ),
                          ),
                          Text(
                            item['quantity'].toString(),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Color.fromRGBO(127, 133, 141, 1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width:20),
                      Row(
                        children: [
                          const Text(
                            'TIPO DE VOLUME: ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Color.fromRGBO(66, 70, 77, 1),
                            ),
                          ),
                          Text(
                            item['volume_type'].toString(),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Color.fromRGBO(127, 133, 141, 1),
                            ),
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'UND DE COMERCIALIZACAO: ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Color.fromRGBO(66, 70, 77, 1),
                            ),
                          ),
                          Text(
                            item['marketing_unit'].toString(),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Color.fromRGBO(127, 133, 141, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text(
                        'QTDE DE COMERCIALIZACAO: ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color.fromRGBO(66, 70, 77, 1),
                        ),
                      ),
                      Text(
                        item['marketing_quantity'].toString(),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Color.fromRGBO(127, 133, 141, 1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'V.UNITÁRIO: ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color.fromRGBO(66, 70, 77, 1),
                        ),
                      ),
                      Text(
                        formatCurrencyUsd.format(item['price_unit']),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Color.fromRGBO(127, 133, 141, 1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2.5),
                  Row(
                    children: [
                      const Text(
                        'TRIBUTO ESTIMADO UNITÁRIO: ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color.fromRGBO(30, 173, 40, 1),
                        ),
                      ),
                      Text(
                        formatCurrencyBrl
                            .format((item['price_unit'] * 0.6) * 5),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Color.fromRGBO(30, 173, 40, 1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text(
                        'V.TOTAL: ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color.fromRGBO(66, 70, 77, 1),
                        ),
                      ),
                      Text(
                        formatCurrencyUsd.format(item['price_unit']),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Color.fromRGBO(127, 133, 141, 1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2.5),
                  Row(
                    children: [
                      const Text(
                        'TRIBUTO ESTIMADO TOTAL: ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color.fromRGBO(30, 173, 40, 1),
                        ),
                      ),
                      Text(
                        formatCurrencyBrl
                            .format((item['price_unit'] * 0.6) * 5),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Color.fromRGBO(30, 173, 40, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
