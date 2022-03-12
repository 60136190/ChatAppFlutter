import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/src/constants/constants.dart';
import 'detailuser.dart';

class TabE extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5),
        child: GridView(
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: [
            CountryCard(title: 'Quynh Nhu', age: '22', address: 'nha trang', image: 'https://i.pinimg.com/564x/f6/77/35/f67735ea4d412e2f537d97974bee885b.jpg'),
            CountryCard(title: 'Kim binh', age: '23', address: 'Cam lam', image: 'https://i.pinimg.com/236x/8a/3e/00/8a3e006b97979d32298bd4c3c20e40a2.jpg'),
            CountryCard(title: 'Thuy Trang', age: '22', address: 'nha trang', image: 'https://i.pinimg.com/236x/5e/fa/d0/5efad092eacd726e6c5bc7a835367d6f.jpg'),
            CountryCard(title: 'Hoai Thu', age: '22', address: 'nha trang', image: 'https://i.pinimg.com/236x/26/ed/1a/26ed1aefd90327e809ab300d513cf86d.jpg'),
            CountryCard(title: 'Thuy Linh', age: '22', address: 'nha trang', image: 'https://i.pinimg.com/236x/f7/a8/5e/f7a85ea1524b9b7cca991d418f2791f8.jpg'),
            CountryCard(title: 'My Linh', age: '25', address: 'nha trang', image: 'https://i.pinimg.com/236x/c6/93/99/c69399bfc8c7c141881be122726312ae.jpg'),
            CountryCard(title: 'My Tham', age: '23', address: 'nha trang', image: 'https://i.pinimg.com/236x/48/c1/03/48c103c247d40ede5ccacb792a666e17.jpg'),
            CountryCard(title: 'Thu Hoai', age: '24', address: 'nha trang', image: 'https://i.pinimg.com/236x/44/59/43/4459439c9857cec7f9d48d841dce2a1f.jpg'),

          ],
        ),
      ),
    );
  }
}

class CountryCard extends StatelessWidget {
  final String title;
  final String address;
  final String age;
  final String image;

  const CountryCard(
      {Key? key, required this.title, required this.age, required this.address, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: 200,
            child: Material(
              child: InkWell(

                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DetailScreen())),
                },
                child:ClipRRect(
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
            child: Text(title,
                style: TextStyle(
                    color: kPink,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            margin: new EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              address,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
