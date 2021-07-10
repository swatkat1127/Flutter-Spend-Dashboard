import 'package:flutter/material.dart';

class PaymentCategoriesTile extends StatefulWidget {
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
  _PaymentCategoriesTileState createState() => _PaymentCategoriesTileState();
}

class _PaymentCategoriesTileState extends State<PaymentCategoriesTile> {
  final _containerHeight = 400.0;
  final _containerWidth = 250.0;

  final _columnBlockLength = 7;
  final _rowBlockLength = 4;

  List<Positioned> myBars = [];

  @override
  void initState() {
    super.initState();
    myBars = _buildBlocks(widget.percentage.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: widget.tileColor,
                borderRadius: BorderRadius.circular(6)),
            width: 250,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  widget.title,
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
                  widget.description,
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
                      '₹${widget.amountSpent}',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      '${widget.percentage}%',
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ...myBars,
        ],
      ),
    );
  }

  List<Positioned> _buildBlocks(double percentage) {
    final List<Positioned> _myWidgets = [];
    final _blockLength =
        (_columnBlockLength * _rowBlockLength / 100) * percentage;
    print("block length: $_blockLength");
    print("block length int: ${_blockLength.toInt()}");

    for (var i = 0; i < _blockLength; i++) {
      if (i == _blockLength.toInt()) {
        _myWidgets.add(
          Positioned(
            bottom: _containerHeight /
                _columnBlockLength *
                (i / _rowBlockLength).floor(),
            right: _containerWidth / _rowBlockLength * (i % _rowBlockLength),
            child: AnimatedBarView(
              index: i,
              child: Container(
                height: getDecimalPoints(_blockLength) *
                    (_containerHeight / _columnBlockLength - 1) /
                    100,
                width: _containerWidth / _rowBlockLength - 1,
                color: Colors.black.withOpacity(0.25),
              ),
            ),
          ),
        );
      } else {
        _myWidgets.add(
          Positioned(
            bottom: _containerHeight /
                _columnBlockLength *
                (i / _rowBlockLength).floor(),
            right: _containerWidth / _rowBlockLength * (i % _rowBlockLength),
            child: AnimatedBarView(
              index: i,
              child: Container(
                key: UniqueKey(),
                height: _containerHeight / _columnBlockLength - 1,
                width: _containerWidth / _rowBlockLength - 1,
                color: Colors.black.withOpacity(0.25),
              ),
            ),
          ),
        );
      }
    }
    return _myWidgets;
  }

  double getDecimalPoints(double point) {
    final _stringPoint = point.toString();
    // print("stringPoint: $_stringPoint");
    final _pointsList = _stringPoint.split(".");
    if (_pointsList.length == 1 || _pointsList.length == 0) {
      return 0;
    }
    final _decimalPoint = _pointsList.last;
    // print("decimalPoint: $_decimalPoint");
    final _decimalFirstTwoPoint = _decimalPoint.length >= 2
        ? _decimalPoint.substring(0, 2)
        : "$_decimalPoint" + "0";
    // print("decimalPoint: $_decimalFirstTwoPoint");

    return double.parse(_decimalFirstTwoPoint);
  }
}

class AnimatedBarView extends StatefulWidget {
  final int? index;
  final Widget? child;
  AnimatedBarView({Key? key, @required this.index, @required this.child})
      : super(key: key);

  @override
  _AnimatedBarViewState createState() => _AnimatedBarViewState();
}

class _AnimatedBarViewState extends State<AnimatedBarView> {
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.index! * 250), () {
      setState(() {
        _animate = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 1000),
      opacity: _animate ? 1 : 0,
      curve: Curves.easeInOutQuart,
      child: widget.child!,
    );
  }
}
