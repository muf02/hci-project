import 'package:flutter/material.dart';
import './restLoginPage.dart';

class EditMenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<EditMenuPage> {
  _MenuPageState();
  late String rest;
  void initState() {
    super.initState();
    getMenue();
  }

  final nameController = TextEditingController();
  final priceController = TextEditingController();

  List orders = [
    {
      "name": "Zinger",
      "price": "250",
      "_id": 1
    },
    {
      "name": "Special Pizza",
      "price": "1000",
      "_id": 2
    },
    {
      "name": "Zinger roll",
      "price": "250",
      "_id": 3
    },
    {
      "name": "biryani",
      "price": "150",
      "_id": 4
    }
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[850],
          title: Text(
            "My Menu",
            style: TextStyle(
              color: Colors.orange[400],
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => RestLogin()));
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
                      future: getMenue(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                                return menuItems(
                                    item['name'], item['price'], item['_id']);
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return myAdder();
                });
          },
          tooltip: 'Add an Item',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  getMenue() async {
    return this.orders;
  }

  menuItems(name, price, id) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(1),
        child: ListTile(
            leading: Icon(
              Icons.emoji_food_beverage,
              color: Colors.orange[800],
            ),
            title: Row(children: [
              Text(
                '$name',
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
              Text(
                'Rs. $price',
                style: TextStyle(fontSize: 18),
              ),
            ]),
            trailing: GestureDetector(
                child: Icon(Icons.delete, color: Colors.red),
                onTap: () async {
                  await removeMenu(id);
                })),
      ),
    );
  }

  removeMenu(id) async {
    this.orders.removeWhere((element) => element["_id"] == id);
    setState(() {});
  }

  addItem(name, price) async {
    final obj = this.orders.last;
    this.orders.add({
      "name":name,
      "price":price,
      "_id":obj["_id"]+1
    });
    setState(() {});
    Navigator.of(context).pop();
  }

  myAdder() {
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
              padding: EdgeInsets.only(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Item Name',
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Item Price',
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.green,
                      child: Text(
                        "Enter",
                      ),
                      onPressed: () async {
                        await addItem(
                            nameController.text, priceController.text);
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
  }
}
