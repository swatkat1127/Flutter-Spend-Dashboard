import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spend_dashboard/service/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_widgets/animated_widgets.dart';

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
                    height: 4,
                  ),
                  Expanded(
                    child: Container(
                      height: double.maxFinite,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          itemCount: paymentCategoriesList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return PaymentCategoriesTile(
                              title: paymentCategoriesList[index]['title'],
                              description: paymentCategoriesList[index]
                                  ['description'],
                              amountSpent: paymentCategoriesList[index]
                                  ['amount'],
                              percentage: paymentCategoriesList[index]
                                  ['percentage'],
                              tileColor: colorRange(index), // dynamic
                            );
                          }),
                    ),
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

class PaymentCategoriesTile extends StatelessWidget {
  String title, description;
  Color tileColor;
  int amountSpent, percentage;
  PaymentCategoriesTile(
      {required this.title,
      required this.description,
      required this.amountSpent,
      required this.percentage,
      required this.tileColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
      height: 80,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
          ),
          Container(
            decoration: BoxDecoration(
                color: tileColor, borderRadius: BorderRadius.circular(6)),
            width: 250,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  description,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70),
                ),
                SizedBox(
                  height: 157,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '₹$amountSpent',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      '$percentage%',
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            height: percentage * 3.00,
            child: SizeAnimatedWidget(
              enabled: true,
              duration: Duration(milliseconds: 1500),
              values: [Size(0, 0), Size(0, 0), Size(150, 150), Size(250, 250)],
              curve: Curves.linear,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(6)),
                width: 250,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PaymentTransactionsTile extends StatelessWidget {
  String title;
  String date;
  int amount;
  String time;
  PaymentTransactionsTile({
    required this.title,
    required this.date,
    required this.amount,
    required this.time,
  });

  Color fontColor(input) {
    if (input > 0) {
      return Colors.green;
    }
    return Colors.red;
  }

  String rupeeText(input) {
    if (input > 0) {
      return '+ ₹$input';
    }
    input = input * -1;
    return '- ₹$input';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 05, right: 5),
      height: 100,
      child: Stack(
        children: <Widget>[
          Container(
            height: 100,
            padding: EdgeInsets.all(06),
            child: SafeArea(
              child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    AssetImage('assets/icon/transfer.png'),
                              )),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                title,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500,),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Text(
                                date,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400,color: Color(0xFF696D89)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                rupeeText(amount),
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: fontColor(amount),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Text(
                                time,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 12, fontWeight:FontWeight.w400,color: Color(0xFF696D89)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          //
          Divider(),
        ],
      ),
    );
  }
}
