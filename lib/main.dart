import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Product> products = [];
  late List<Category> categories = [
    Category(name: 'Electronics'),
    Category(name: 'Fashion'),
    Category(name: 'Home & Kitchen'),
  ];

  @override
  void initState() {
    super.initState();
    generateProducts();
  }

  void generateProducts() {
    final random = Random();
    final List<String> names = [
      'John Doe',
      'Jane Smith',
      'Alex Johnson',
      'Emma Wilson',
      'Michael Brown'
    ];

    setState(() {
      products = List.generate(
        20,
        (index) => Product(
          name: names[random.nextInt(names.length)],
          imageUrl: 'https://picsum.photos/200?random=$index',
          price: 0, // You can customize this based on your data model
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ecommerce App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                'Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            for (var category in categories)
              ListTile(
                title: Text(category.name),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  // Implement navigation or filtering logic for category
                  // Here you can filter products based on the selected category
                  // For demonstration, we'll print the selected category name
                  print('Selected Category: ${category.name}');
                },
              ),
          ],
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductItem(product: products[index]);
        },
      ),
    );
  }
}

class Category {
  final String name;

  Category({required this.name});
}

class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product({required this.name, required this.price, required this.imageUrl});
}

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            product.imageUrl,
            height: 200;
            width: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}