import 'package:flutter/material.dart';
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
      margin: EdgeInsets.only(left: 11, right: 11, bottom: 6, top: 6),
      height: 100,
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
                    backgroundImage: AssetImage('assets/icon/transfer.png'),
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
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    date,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF696D89)),
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
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    time,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF696D89)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
