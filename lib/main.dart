import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Colors.grey)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  double pAmount = 0;
  String loanClass = 'Personal';
  String termsPerMonth = '1';
  double interestRate = 0;
  double totalDiminishing = 0;

  String calculateMonthlyPayment() {
    if (int.parse(termsPerMonth) <= 2) {
      interestRate = 0.03;
    } else if (int.parse(termsPerMonth) <= 4) {
      interestRate = 0.05;
    } else if (int.parse(termsPerMonth) <= 6) {
      interestRate = 0.10;
    } else {
      interestRate = 0;
    }

    double monthlyPrincipal = pAmount / int.parse(termsPerMonth);
    double monthlyInterest = pAmount * interestRate;
    totalDiminishing = monthlyPrincipal + monthlyInterest;

    if (loanClass == 'Personal') {
      return (monthlyPrincipal + monthlyInterest).toStringAsFixed(2);
    } else {
      double remainingPrincipal = pAmount;
      double monthlyPayment = monthlyPrincipal + monthlyInterest;
      double counter = 1;
      String payments =
          'M${counter.toStringAsFixed(0)} = ${(monthlyPrincipal + monthlyInterest).toStringAsFixed(2)}\n';

      while (counter != double.parse(termsPerMonth)) {
        counter += 1;
        remainingPrincipal = remainingPrincipal - monthlyPrincipal;
        monthlyPayment = remainingPrincipal * interestRate;
        payments = payments +
            '${List.filled(34, '\t').join()}M${counter.toStringAsFixed(0)} = ${(monthlyPrincipal + monthlyPayment).toStringAsFixed(2)}\n';
        totalDiminishing += monthlyPrincipal + monthlyPayment;
      }
      return payments;
    }
  }

  double calculateTotalAmount() {
    if (loanClass == 'Personal') {
      return double.parse(calculateMonthlyPayment()) * int.parse(termsPerMonth);
    } else {
      return totalDiminishing;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
                child: Text('Loan Calculator',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff090c9b)))),
            backgroundColor: Color(0xffb4c5e4),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Name\t\t\t\t\t                 : $name'),
                Text('Principal Amount  : $pAmount'),
                Text('Classification        : $loanClass'),
                Text('Monthly Terms      : $termsPerMonth'),
                Text('Monthly Due          : ${calculateMonthlyPayment()}'),
                Text('-----------------------------------------------'),
                Text(
                    'Total Amount Due : ${calculateTotalAmount().toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close',
                      style: TextStyle(color: Color(0xff090c9b)))),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff7f7f7),
        appBar: AppBar(
          title: Text(
            'Mind Master Solution Inc.',
            style: TextStyle(
                color: Color(0xfff7f7f7),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff090c9b),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/logo/logo.png'),
                    )),
                    width: 167,
                    height: 42,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    decoration: InputDecoration(
                      label: const Text('Name',
                          style: TextStyle(color: Color(0xff3c3744))),
                      hintText: 'Enter your name',
                      hintStyle: TextStyle(color: Color(0xff3c3744)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xff3066be)),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xff3066be), width: 2),
                          borderRadius: BorderRadius.circular(15)),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.red), // Optional for error display
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.red), // Optional for error display
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                    validator: (name) => name == null || name.isEmpty
                        ? 'Please enter your name'
                        : null,
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                  const SizedBox(height: 25.0),
                  TextFormField(
                    decoration: InputDecoration(
                      label: const Text('Principal Ammount',
                          style: TextStyle(color: Color(0xff3c3744))),
                      hintText: 'Enter amount',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xff3066be)),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xff3066be), width: 2),
                          borderRadius: BorderRadius.circular(15)),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.red), // Optional for error display
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.red), // Optional for error display
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.number,
                    validator: (name) => name == null || name.isEmpty
                        ? 'Please enter amount'
                        : null,
                    onChanged: (value) {
                      setState(() {
                        pAmount = double.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  const SizedBox(height: 25.0),
                  DropdownButtonFormField<String>(
                    value: loanClass,
                    dropdownColor: Color(0xffb4c5e4),
                    decoration: InputDecoration(
                        label: const Text('Loan Classification',
                            style: TextStyle(color: Color(0xff3c3744))),
                        hintText: 'Select Class',
                        hintStyle: TextStyle(color: Color(0xff3c3744)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xff3066be)),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xff3066be)),
                            borderRadius: BorderRadius.circular(10))),
                    onChanged: (String? newValue) {
                      setState(() {
                        loanClass = newValue!;
                      });
                    },
                    items: <String>['Personal', 'Commercial']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child:
                            Text(value, style: TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your category';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25.0),
                  DropdownButtonFormField<String>(
                    value: termsPerMonth,
                    dropdownColor: Color(0xffb4c5e4),
                    decoration: InputDecoration(
                        label: const Text('Terms per Month',
                            style: TextStyle(color: Color(0xff3c3744))),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xff3066be)),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xff3066be)),
                            borderRadius: BorderRadius.circular(10))),
                    onChanged: (String? newValue) {
                      setState(() {
                        termsPerMonth = newValue!;
                      });
                    },
                    items: <String>['1', '2', '3', '4', '5', '6']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child:
                            Text(value, style: TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select number of terms';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25.0),
                  new SizedBox(
                      width: 230,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xff090c9b)),
                        ),
                        onPressed: _submitForm,
                        child: Text(
                          'Calculate',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ],
              ),
            )));
  }
}
