import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spend_dashboard/service/network.dart';
import 'package:flutter/cupertino.dart';
import '../models/payment_transactions.dart';
import '../models/payment_category.dart';

class MyDashboard extends StatefulWidget {
  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  List<dynamic> paymentCategoriesList = [];
  List<dynamic> paymentTransactionsList = [];

  @override
  void initState() {
    super.initState();
    getPaymentCategoryList();
    getLastestTransactionList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpendList(),
    );
  }

  Color colorRange(index) {
    var colors = [
      Color(0xFF897FF1),
      Color(0xFF129EB9),
      Color(0xFFE06B74),
    ];
    var reminder = (index) % (colors.length);
    return colors[reminder];
  }

  Widget SpendList() {
    return Container(
      child: paymentCategoriesList != null && paymentTransactionsList != null
          ? SafeArea(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 20),
                        child: Text(
                          'PAYMENT CATEGORIES',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Colors.white70),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    height: 380,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        itemCount: paymentCategoriesList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return PaymentCategoriesTile(
                            title: paymentCategoriesList[index]['title'],
                            description: paymentCategoriesList[index]
                                ['description'],
                            amountSpent: paymentCategoriesList[index]['amount'],
                            percentage: paymentCategoriesList[index]
                                ['percentage'],
                            tileColor: colorRange(index), // dynamic
                          );
                        }),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 20),
                        child: Text(
                          'LATEST TRANSACTIONS',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Colors.white70),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Expanded(
                      child: Container(
                    height: double.maxFinite,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding:
                            EdgeInsets.symmetric(horizontal: 08, vertical: 08),
                        itemCount: paymentTransactionsList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          // return Text("asdasd");

                          return PaymentTransactionsTile(
                            title: paymentTransactionsList[index]['title'],
                            date: paymentTransactionsList[index]['date'],
                            amount: paymentTransactionsList[index]['amount'],
                            time: paymentTransactionsList[index]['time'],
                          );
                        }),
                  ))
                ],
              ),
            )
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
    );
  }

  void getPaymentCategoryList() async {
    NetworkHelper np = NetworkHelper('url');
    var data;
    try {
      data = await np.getData();
    } catch (err) {
      data = {'results': null};
    }

    setState(() {
      List<Map<String, dynamic>> results = data['results'];
      // preprocess the array of objects to remove null titles
      results = results.where((d) {
        return d['title'] != null;
      }).toList();
      //sorting of data['results'] based on percentage
      results.sort((b, a) => a["percentage"].compareTo(b["percentage"]));
      paymentCategoriesList = results;
    });
  }

  void getLastestTransactionList() async {
    NetworkHelper nt = NetworkHelper('url');
    var data;
    try {
      data = await nt.getData();
    } catch (err) {
      data = {'transactions': null};
    }
    setState(() {
      // process to remove null values
      var transactions = data['transactions'];
      transactions = transactions.where((d) {
        return d['title'] != null;
      }).toList();
      paymentTransactionsList = transactions;
    });
  }
}
