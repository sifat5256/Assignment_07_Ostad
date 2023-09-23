import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Product List'),
          centerTitle: true,
        ),
        body: ProductList(),

      ),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: 'Vegetable', price: 10),
    Product(name: 'Fruits', price: 15),
    Product(name: 'Fish', price: 20),
    Product(name: 'Meat', price: 10),
    Product(name: 'Edible Oil', price: 15),
    Product(name: 'Milk', price: 20),
    Product(name: 'Personal Care', price: 10),
    Product(name: 'Chicken', price: 15),
    Product(name: 'Frozen Food', price: 20),
    Product(name: 'IceCream', price: 10),
    Product(name: 'Sweet', price: 15),
    Product(name: 'Pepsi', price: 20),
    Product(name: '7Up', price: 10),
    Product(name: 'Mirinda', price: 15),
    Product(name: 'Buiscits', price: 20),
    Product(name: 'Shampo', price: 10),
    Product(name: 'Oil', price: 15),
    Product(name: 'Dry Fruits', price: 20),
    Product(name: 'Cake', price: 10),
    Product(name: 'Snacks', price: 15),
    Product(name: 'Product 1', price: 20),
    Product(name: 'Product 2', price: 10),
    Product(name: 'Product 3', price: 15),
    Product(name: 'Product 4', price: 20),
    Product(name: 'Product A', price: 10),
    Product(name: 'Product B', price: 15),
    Product(name: 'Product C', price: 20),
    Product(name: 'Product D', price: 10),
    Product(name: 'Product E', price: 15),
    Product(name: 'Product F', price: 20),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(products[index].name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                subtitle: Text('\$${products[index].price}'),
                trailing: ProductCounter(
                  product: products[index],
                  onBuyNowPressed: () {
                    setState(() {
                      products[index].incrementCounter();
                      if (products[index].counter == 5) {
                        _showCongratulationsDialog(products[index]);
                      }
                    });
                  },
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage(products)),
            );
          },
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(

            ), // This is what makes it circular
          ),
          child: Icon(Icons.shopping_cart,size: 29,),
        ),
      ],
    );
  }

  void _showCongratulationsDialog(Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You\'ve bought 5 ${product.name}!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class Product {
  final String name;
  final double price;
  int counter;

  Product({
    required this.name,
    required this.price,
    this.counter = 0,
  });

  void incrementCounter() {
    counter++;
  }
}

class ProductCounter extends StatelessWidget {
  final Product product;
  final VoidCallback onBuyNowPressed;

  ProductCounter({
    required this.product,
    required this.onBuyNowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(child: Text('Counter ${product.counter}')),
        SizedBox(
          height: 1,
        ),

        Expanded(
          child: ElevatedButton(
            child: Text('By Now'),
            onPressed: onBuyNowPressed,
          ),
        ),
      ],
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> cartItems;

  CartPage(this.cartItems);

  @override
  Widget build(BuildContext context) {
    int totalProducts = cartItems.fold(0, (sum, product) => sum + product.counter);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Total Products in Cart: $totalProducts'),
      ),
    );
  }
}
