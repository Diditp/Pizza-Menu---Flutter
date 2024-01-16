// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class Pizza {
  String nama;
  String img;
  int harga;
  Map<String, int> toppings;

  Pizza(this.nama, this.img, this.harga, this.toppings);

  // int getPrice() {
  //   return this.harga;
  // }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Pizza? pilihanPizza;

  String? ukuranPizza = "Medium";

  List<String> ukuranPizzas = ["Small", "Medium", "Large"];

  List<String> pilihanToping = [];

  bool tercentang = false;

  Map<String, int> toppingDefaults = {
    "avocado": 1,
    "broccoli": 1,
    "onions": 1,
    "zucchini": 1,
    "tuna": 2,
    "lobster": 2,
    "oyster": 2,
    "salmon": 2,
    "bacon": 3,
    "duck": 3,
    "ham": 3,
    "sausage": 3,
  };

  List<Pizza> katalogPizza = [
    Pizza("Pizza1", "assets/images/pizza1.jpeg", 8, {
      "avocado": 1,
      "broccoli": 1,
      "onions": 1,
      "zucchini": 1,
      "tuna": 2,
      "ham": 3,
    }),
    Pizza("Pizza2", "assets/images/pizza2.jpeg", 10, {
      "broccoli": 1,
      "onions": 1,
      "zucchini": 1,
      "lobster": 2,
      "oyster": 2,
      "salmon": 2,
      "bacon": 3,
      "ham": 3,
    }),
    Pizza("Pizza3", "assets/images/pizza3.jpeg", 12, {
      "broccoli": 1,
      "onions": 1,
      "zucchini": 1,
      "tuna": 2,
      "bacon": 3,
      "duck": 3,
      "ham": 3,
      "sausage": 3,
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pizza",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: katalogPizza
                      .map(
                        (pizza) => Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                child: Image.asset(
                                  pizza.img,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                pizza.nama,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$${pizza.harga}'.toString(),
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Radio(
                                  value: pizza,
                                  groupValue: pilihanPizza,
                                  onChanged: (Pizza? value) {
                                    setState(() {
                                      pilihanPizza = value;
                                      print(pilihanPizza);
                                    });
                                  })
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Size",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ['Small', 'Medium', 'Large']
                      .map(
                        (size) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Radio(
                              value: size,
                              groupValue: ukuranPizza,
                              onChanged: (value) {
                                setState(() {
                                  ukuranPizza = value;
                                });
                              },
                            ),
                            Text("$size")
                          ],
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Toppings",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Column(
                children: pilihanPizza != null
                    ? pilihanPizza!.toppings.keys.map((topping) {
                        return Row(
                          children: [
                            Checkbox(
                                value: pilihanToping.contains(topping),
                                onChanged: (value) {
                                  setState(() {
                                    if (value != null) {
                                      pilihanToping.add(topping);
                                    } else {
                                      pilihanToping.remove(topping);
                                    }
                                  });
                                }),
                            Text(
                              "${topping}",
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                          ],
                        );
                      }).toList()
                    : toppingDefaults.keys.map((topping) {
                        return Row(
                          children: [
                            Checkbox(
                                value: tercentang,
                                onChanged: (bool? value) {
                                  setState(() {
                                    tercentang = value!;
                                  });
                                }),
                            Text(
                              "${topping}",
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
              )
            ]),
            SizedBox(
              height: 30,
            ),
            Text(
              'Total Price: \$${hitungTotalBayar()}',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  int hitungTotalBayar() {
    int hitungTotalBayar = pilihanPizza != null ? pilihanPizza!.harga : 0;
    if (ukuranPizza == 'Large') {
      hitungTotalBayar += 2;
    } else if (ukuranPizza == 'Small') {
      hitungTotalBayar -= 1;
    }

    for (String toppping in pilihanToping) {
      hitungTotalBayar += pilihanPizza!.toppings[toppping]!;
    }

    return hitungTotalBayar;
  }
}
