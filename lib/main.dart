import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';
import 'payment_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Payhere',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(title: 'Payhere'),
    ),
    GoRoute(
      path: '/payment-success',
      builder: (context, state) {
        final paymentId = state.extra as String;
        return PaymentSuccessPage(paymentId: paymentId);
      },
    ),
  ],
);

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _initiatePayment() {
    final paymentObject = PaymentService.createPaymentObject();

    PayHere.startPayment(paymentObject, (paymentId) {
      print("One Time Payment Success. Payment Id: $paymentId");
      _router.go('/payment-success', extra: paymentId);
    }, (error) {
      print("One Time Payment Failed. Error: $error");
    }, () {
      print("One Time Payment Dismissed");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: _initiatePayment,
              child: const Text('Initiate Payment'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PaymentSuccessPage extends StatelessWidget {
  final String paymentId;

  const PaymentSuccessPage({Key? key, required this.paymentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Payment was successful!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Payment ID: $paymentId',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
