import 'dart:convert';

import 'package:exchange_app/model/currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Para Birimi Çevirici'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String apiResponse = "";
  Currency? currencyModel;
  String? baseCurrency;
  String? convertTo;
  String imageUrl= "";
  bool isResponseAvailable = false;
  final amountController = TextEditingController();

  Future<Currency> fetchCurrency(String base, String to, num amount) async {
    String apiKey = "s2o7lv3de0gh2diel8774g9tnssjk99ugnb539ujtfg8cae0qbjj3b";
    final response = await http.get(Uri.parse(
        'https://anyapi.io/api/v1/exchange/convert?base=$base&to=$to&amount=$amount&apiKey=$apiKey'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      setState(() {});
      currencyModel = Currency.fromJson(jsonDecode(response.body));
      if(currencyModel != null) {
        isResponseAvailable = true;
        setState(() {

        });
        if (currencyModel?.to == 'USD') {
          imageUrl =
          'https://static.vecteezy.com/system/resources/previews/006/059/910/large_2x/dollar-icon-american-currency-symbol-illustration-usd-coin-free-vector.jpg';
        } else if (currencyModel?.to == 'EUR') {
          imageUrl =
          'https://static.vecteezy.com/system/resources/previews/009/097/082/non_2x/euro-gold-coin-illustration-vector.jpg';
        } else {
          imageUrl =
          'https://static.vecteezy.com/system/resources/previews/007/530/473/non_2x/bronze-coin-of-turkish-lira-concept-of-internet-currency-vector.jpg';
        }
      }
      return Currency.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Bağlantı Başarısız');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        child: Wrap(
          spacing: 15.0,
          children: [
            SizedBox(
              child: Column(
                children: [
                  DropdownButton<String>(
                      items: const [
                        DropdownMenuItem(
                          value: "TRY",
                          child: Text("TRY"),
                        ),
                        DropdownMenuItem(
                          value: "USD",
                          child: Text("USD"),
                        ),
                        DropdownMenuItem(
                          value: "EUR",
                          child: Text("EUR"),
                        )
                      ],
                      hint: const Text("Baz alınacak para birimi :"),
                      value: baseCurrency,
                      onChanged: (String? value) {
                        setState(() {
                          baseCurrency = value ?? "";
                        });
                      }),
                ],
              ),
            ),
            SizedBox(
                child: Column(
              children: [
                DropdownButton<String>(
                    items: const [
                      DropdownMenuItem(
                        value: "TRY",
                        child: Text("TRY"),
                      ),
                      DropdownMenuItem(
                        value: "USD",
                        child: Text("USD"),
                      ),
                      DropdownMenuItem(
                        value: "EUR",
                        child: Text("EUR"),
                      )
                    ],
                    hint: const Text(
                        "Çevrilmesini istediğiniz para birimini seçiniz:"),
                    value: convertTo,
                    onChanged: (String? value) {
                      setState(() {
                        convertTo = value ?? "";
                      });
                    })
              ],
            )),
            SizedBox(
              width: 150,
              child: Column(
                children: [
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 40.0),
                      border: OutlineInputBorder(),
                      labelText: "Adet: ",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Row(
                children: [
                  CupertinoButton(
                      color: Colors.amberAccent,
                      onPressed: () => {
                            fetchCurrency(baseCurrency!, convertTo!,
                                num.parse(amountController.text)),
                          },
                      child: const Text("Değeri Getir")),
                ],
              ),
            ),
            const Divider(
              endIndent: 15,
              indent: 15,
              height: 15,
              thickness: 3,
            ),

           if(isResponseAvailable) Card(
              elevation: 50,
              shadowColor: Colors.black,
              color: Colors.greenAccent[100],
              child: SizedBox(
                width: 300,
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green[500],
                        radius: 108,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(imageUrl), //NetworkImage
                          radius: 100,
                        ), //CircleAvatar
                      ), //CircleAvatar
                      const SizedBox(
                        height: 10,
                      ), //SizedBox
                      Text(
                        'Güncel Kur',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.green[900],
                          fontWeight: FontWeight.w500,
                        ), //Textstyle
                      ), //Text
                      const SizedBox(
                        height: 10,
                      ), //SizedBox
                       Text(
                         '${currencyModel?.amount.toString()}'+' ' +'${currencyModel?.base}'+' ' +'${currencyModel?.converted.toString()}'+' ' +'${currencyModel?.to.toString()}'+ ' EDER.',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.green,
                        ), //Textstyle
                      ), //Text
                      const SizedBox(
                        height: 10,
                      ), //SizedBox
                      SizedBox(
                        width: 100,

                        child: ElevatedButton(
                          onPressed: () => 'Null',
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Wrap(
                              spacing: 16.0,
                              direction: Axis.horizontal,
                              children: const [
                                Icon(Icons.touch_app),
                                Text('Next Page')
                              ],
                            ),
                          ),
                        ),
                        // RaisedButton is deprecated and should not be used
                        // Use ElevatedButton instead

                        // child: RaisedButton(
                        //   onPressed: () => null,
                        //   color: Colors.green,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(4.0),
                        //     child: Row(
                        //       children: const [
                        //         Icon(Icons.touch_app),
                        //         Text('Visit'),
                        //       ],
                        //     ), //Row
                        //   ), //Padding
                        // ), //RaisedButton
                      ) //SizedBox
                    ],
                  ), //Column
                ), //Padding
              ), //SizedBox
            ), //Card
          ],
        ),
      ),
    );
  }
}
