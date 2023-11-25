import 'package:flutter/material.dart';
import '../../models/cart_item.dart';
import '../../models/order_item.dart';
import '../order/orders_screen.dart';
import '../../../services/user_service.dart';
import 'package:provider/provider.dart';
import '../cart/cart_manager.dart';
import '../payment_cart/payment_cart_item.dart';
import '../order/order_manager.dart';
import '../shared/dialog_utils.dart';
import '../../widget/custom_rich_text.dart';

class PaymentCartScreen1 extends StatefulWidget {
  static const routeName = '/payment-cart1';

  const PaymentCartScreen1({super.key});

  @override
  State<PaymentCartScreen1> createState() => _PaymentCartScreen1State();
}

class _PaymentCartScreen1State extends State<PaymentCartScreen1> {
  late OrderItem _order;
  String zpTransToken = "";
  String payResult = "Thanh toán bằng tiền mặt";
  late Future<Map<String, dynamic>> _futureFetchUserInformation;
  @override
  void initState() {
    super.initState();
    _futureFetchUserInformation = UserService().fetchUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang thanh toán'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          FutureBuilder<Map<String, dynamic>>(
            future: _futureFetchUserInformation,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          paymentAddress(snapshot.data!['address']),
                          inforNameUser(snapshot.data!['name']),
                          const SizedBox(height: 20),
                          inforPhoneUser(snapshot.data!['phone'])
                        ],
                      )),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          // buildCartSummary(cart, context),
          const SizedBox(height: 10),
          Expanded(
            child: buildCartDetails(cart),
          ),
          buildProductTotal(cart),
          FutureBuilder<Map<String, dynamic>>(
            future: _futureFetchUserInformation,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          paymentNow(snapshot, cart),
                        ],
                      )),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  Widget inforPhoneUser(data) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 150,
          alignment: Alignment.centerLeft,
          child: const Text('Số điện thoại:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20),
          color: Colors.white,
          height: 50,
          width: 200,
          child: Row(
            children: [
              // Container(
              //   padding: const EdgeInsets.all(12),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(100),
              //       border: Border.all(
              //         color: Colors.black,
              //         width: 0.5,
              //       )),
              //   child: Image.asset(
              //     'assets/Images/user-icon.png',
              //     color: Colors.black12,
              //     height: 23,
              //     width: 23,
              //   ),
              // ),
              const SizedBox(width: 7),
              Text(
                data ?? '',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget paymentAddress(data) {
    return Column(children: [
      Container(
        height: 40,
        alignment: Alignment.centerLeft,
        child: const Text('Địa chỉ:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      Container(
        padding: const EdgeInsets.all(10),
        height: 60,
        width: 400,
        margin: const EdgeInsets.only(bottom: 0),
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 64, 59, 59),
                width: 0,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(0)),
        child: Text(
          data,
          style: TextStyle(fontSize: 16),
        ),
      )
    ]);
  }

  Widget inforNameUser(data) {
    return Column(
      children: [
        Container(
          height: 40,
          alignment: Alignment.centerLeft,
          child: const Text('Người mua:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20),
          color: Colors.white,
          height: 60,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    )),
                child: Image.asset(
                  'assets/Images/user-icon.png',
                  color: Colors.black,
                  height: 23,
                  width: 23,
                ),
              ),
              const SizedBox(width: 7),
              Text(
                data ?? '',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildCartDetails(CartManager cart) {
    return ListView(
      children: cart.productEntries
          .map(
            (entry) => CartItemCard(
              productId: entry.key,
              cardItem: entry.value,
            ),
          )
          .toList(),
    );
  }

  Widget buildProductTotal(CartManager cart) {
    return Container(
      height: 100,
      child: Container(
        child: Column(
          children: [
            CustomRowText(
              title: 'Tổng số lượng',
              value: '${cart.totalQuantity}',
            ),
            CustomRowText(
              title: 'Tổng giá',
              value: '${cart.totalAmount}',
            )
          ],
        ),
      ),
    );
  }

  Widget paymentNow(snapshot, cart) {
    return Container(
      width: 400,
      height: 50,
      child: GestureDetector(
        onTap: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              });
          _order = OrderItem(
            amount: cart.totalAmount,
            products: cart.products,
            totalQuantity: cart.totalQuantity,
            name: snapshot.data['name'],
            phone: snapshot.data['phone'],
            address: snapshot.data['address'],
            customerId: snapshot.data['uid'],
            payResult: payResult,
          );
          context.read<OrdersManager>().addOrder(_order);
          // cart.clear();
          showMyDialog(context, cart);
          // Navigator.of(context).pushNamed(OrdersScreen.routeName);
        },
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(1.0),
            ),
            child: Text("Thanh toán bằng tiền mặt",
                style: TextStyle(color: Colors.white, fontSize: 16))),
      ),
    );
  }
}
