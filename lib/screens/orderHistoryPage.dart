import 'package:flutter/material.dart';
import './restLoginPage.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  final delivered;
  OrderHistoryPage(this.delivered);
  _OrderHistoryPageState createState() => _OrderHistoryPageState(this.delivered);
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  _OrderHistoryPageState(delivered);
  late String rest;
  List orders = [];
  void initState() {
    super.initState();
    getOrder();
    orders = widget.delivered;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text(
                "Order History",
                style: TextStyle(
                  color: Colors.orange[400],
                ),
              ),
              backgroundColor: Colors.grey[850],
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    RestLogin()));
                      },
                      child: Icon(
                        Icons.logout,
                      ),
                    )),
              ],
            ),
            body: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Expanded(
                      child: FutureBuilder(
                          future: getOrder(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return ListView.separated(
                                  separatorBuilder: (context, index) => Divider(
                                        color: Colors.black,
                                        indent: 10,
                                        endIndent: 10,
                                      ),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    var item = snapshot.data[index];
                                    return activeOrders(
                                        item['name'],
                                        item['product'],
                                        item['price'],
                                        item['address'],
                                        item['_id']);
                                  });
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    )
                  ],
                ),
              ),
            )));
  }

  activeOrders(user, product, price, address, id) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    insetPadding: EdgeInsets.all(10),
                    content: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                                child: GestureDetector(
                              child: Icon(Icons.close),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            )),
                          ),
                        ),
                        Form(
                          child: Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                for (var item in product) items(item),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Padding(
            padding: EdgeInsets.all(2),
            child: ListTile(
              leading: Icon(
                Icons.done_all,
                color: Colors.blueGrey,
              ),
              title: Text(
                '$user |  Amount: $price',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              trailing: GestureDetector(
                  child: Icon(Icons.delete, color: Colors.red),
                  onTap: () async {
                    await removeOrder(id);
                  }),
              subtitle: Text('$address'),
              isThreeLine: true,
            ),
          )),
    );
  }

  getOrder() async {
    return this.orders;
  }

  removeOrder(id) async {
    this.orders.removeWhere((element) => element["_id"] == id);
    setState(() {});
  }

  items(products) {
    var name = products['item'];
    var quant = products['quantity'];
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '$quant x $name',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
