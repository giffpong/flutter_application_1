import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product_model.dart';

class ShowListProduct extends StatefulWidget {
  @override
  _ShowListProductState createState() => _ShowListProductState();
}

class _ShowListProductState extends State<ShowListProduct> {
  //Field
  List<ProductModel> productModels = [];

  //Method
  @override
  void initState() {
    super.initState();
    readAllData();
  }

  Future<void> readAllData() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference collectionReference =
        firebaseFirestore.collection('product');
    await collectionReference.snapshots().listen((response) {
      List<DocumentSnapshot> snapshots = response.docs;
      for (var snapshot in snapshots) {
        print('snapshot = ${snapshot.data()['name']}');

        ProductModel productModel = ProductModel.fromMap(snapshot.data());
        setState(() {
          productModels.add(productModel);
        });
      }
    });
  }

  Widget showImage(int index) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.3,
        padding: EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: NetworkImage(productModels[index].pathImage),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }

  Widget showName(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          productModels[index].name,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade300,
          ),
        ),
      ],
    );
  }

  Widget showDetail(int index) {
    String productDetailString = productModels[index].detail;
    if (productDetailString.length > 100) {
      productDetailString = productDetailString.substring(0, 99);
      productDetailString = '$productDetailString ...';
    }
    return Text(
      productDetailString,
      style: TextStyle(
        fontSize: 14.0,
        fontStyle: FontStyle.italic,
        color: Colors.grey.shade600,
      ),
    );
  }

  Widget showText(int index) {
    return Container(
      padding: EdgeInsets.only(right: 20.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          showName(index),
          showDetail(
            index,
          )
        ],
      ),
    );
  }

  Widget showListView(int index) {
    return Row(
      children: <Widget>[showImage(index), showText(index)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: productModels.length,
        itemBuilder: (BuildContext builContext, int index) {
          return showListView(index);
        },
      ),
    );
  }
}
