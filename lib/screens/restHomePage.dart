import 'package:flutter/material.dart';
import './editMenuPage.dart';
import './orderHistoryPage.dart';
import './restLoginPage.dart';

class RestaurantHome extends StatefulWidget {
  @override
  _RestaurantHomeState createState() => _RestaurantHomeState();
}

class _RestaurantHomeState extends State<RestaurantHome> {
  _RestaurantHomeState();
  late String rest;
  void initState() {
    super.initState();
    getOrder();
  }
  List orders = [
    {
      "name":"Usman Farooq",
      "product":[
        {
          "item": "Zinger",
          "quantity": 2
        },{
          "item": "special pizza",
          "quantity": 1
        }
      ],
      "price": 1500,
      "address": "hostel 3",
      "_id":3
    },{
      "name":"Mubarak Shah",
      "product":[
        {
          "item": "Zinger roll",
          "quantity": 4
        }
      ],
      "price": 1000,
      "address": "hostel 1",
      "_id":4
    }
  ];

  List history = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text(
                "Active Orders",
                style: TextStyle(
                  color: Colors.orange[400],
                ),
              ),
              backgroundColor: Colors.grey[850],
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: RaisedButton(
                      color: Colors.grey[850],
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    EditMenuPage()));
                      },
                      child: Center(
                        child: Text(
                          'Menu',
                          style: (TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    OrderHistoryPage(this.history)));
                      },
                      child: Icon(
                        Icons.history,
                      ),
                    )),
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
                              return ListView.builder(
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    color: Colors.green,
                                    child: Text(
                                      "Mark as Complete",
                                    ),
                                    onPressed: () async {
                                      await delivered(id);
                                    },
                                  ),
                                )
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
                Icons.restaurant_menu,
                color: Colors.blueGrey,
              ),
              title: Text(
                '$user |  Amount: $price',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              tileColor: Colors.grey[300],
              subtitle: Text('$address'),
              isThreeLine: true,
            ),
          )),
    );
  }

  getOrder() async {
    return this.orders;
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

  delivered(id) async {
    final obj = this.orders.firstWhere((element) => element["_id"]==id);
    this.history.add(obj);
    this.orders.removeWhere((element) => element["_id"] == id);
    setState(() {
      print('reload');
    });
    Navigator.of(context).pop();
  }
}
