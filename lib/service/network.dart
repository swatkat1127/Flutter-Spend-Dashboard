// import 'package:http/http.dart' as http;
// import 'dart:convert';

class NetworkHelper {
  final String url;
  NetworkHelper(this.url);

  Future getData() async {
    var data = {
      "results": [
        {
          "title": "Mobile Home Dealers",
          "description": "last payment 17 May",
          "amount": 4948,
          "percentage": 52,
        },
        {
          "title": "Taxicabs And Limousines",
          "description": "last payment 26 May",
          "amount": 449,
          "percentage": 18,
        },
        {
          "title": "Miscellaneous Apparel And Accessory Shops",
          "description": "last payment 6 April",
          "amount": 245,
          "percentage": 28,
        },
        {
          "title": "Miscellaneous Apparel And Accessory Shops",
          "description": "last payment 6 April",
          "amount": 140,
          "percentage": 12,
        },
      ],
      "transactions": [
        {
          "title": "WWWOLACABSCOM",
          "date": "26 May 2021",
          "amount": -449,
          "time": '6:40 PM'
        },
        {
          "title": "Recharge",
          "date": "26 May 2021",
          "amount": 155,
          "time": '6:35 PM'
        },
        {
          "title": "Reliance Retail Ltd",
          "date": "17 May 2021",
          "amount": -4949,
          "time": '12:11 AM'
        },
        {
          "title": "Recharge",
          "date": "26 May 2021",
          "amount": 4500,
          "time": '12:09 AM'
        },
        {
          "title": "Airtel",
          "date": "01 May 2021",
          "amount": -49,
          "time": '8:06 AM'
        },
      ]
    };
    return data;
  }
}
