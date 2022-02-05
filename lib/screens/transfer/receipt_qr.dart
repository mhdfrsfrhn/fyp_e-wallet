import 'package:fyp3/imports.dart';
import 'package:fyp3/screens/transfer/transfer_process_qr.dart';
import 'package:fyp3/widgets/widgets.dart';

class ReceiptScreenQR extends StatefulWidget {
  final PassreceiptQR value;

  ReceiptScreenQR({Key? key, required this.value}) : super(key: key);

  @override
  _ReceiptScreenQRState createState() => _ReceiptScreenQRState();
}

class _ReceiptScreenQRState extends State<ReceiptScreenQR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Transaction Receipt',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 25),
                Text(
                  'Transaction ID;',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${widget.value.transactionid}',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                _textDividerReceipt(),
                Text(
                  'Date and Time:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${widget.value.timedate}',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                _textDividerReceipt(),
                Text(
                  'Recipient Email:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${widget.value.recipientemail}',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                _textDividerReceipt(),
                Text(
                  'Recipient UID:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${widget.value.recipientuid}',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                _textDividerReceipt(),
                Text(
                  'Recipient Reference:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${widget.value.recipientreference}',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                _textDividerReceipt(),
                Text(
                  'Amount:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'RM ${widget.value.amount}',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                _textDividerReceipt(),
                SizedBox(height: 23),
                Align(
                  child: _finishButton(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _textDividerReceipt() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.all(10),
          ),
          Expanded(child: Divider()),
        ],
      ),
    );
  }
}

Widget _finishButton(BuildContext context) {
  return Container(
    child: RaisedButton(
      splashColor: Colors.grey,
      color: Colors.white,
      shape: StadiumBorder(),
      child: Text(
        'Back to Homepage',
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () => wPushReplaceTo(context, HomePage()),
    ),
  );
}
