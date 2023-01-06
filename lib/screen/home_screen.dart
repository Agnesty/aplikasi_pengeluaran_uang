import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaksi_model.dart';
import '../widget/iconBar_widget.dart';
import '../widget/list_transaksi.dart';
import '../widget/transaksi_baru.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Transaksi> _transaksiPengguna = [];

  void _tambahTransaksiBaru(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: TransaksiBaru(
              addListExpenses: _menambahkanList,
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _menambahkanList(
      String expenses, String descipt, double amount, DateTime chosenDate) {
    final tbhList = Transaksi(
      id: DateTime.now().toString(),
      expenses: expenses,
      descript: descipt,
      chosenDate: chosenDate,
      amount: amount,
    );

    setState(() {
      _transaksiPengguna.add(tbhList);
    });
  }

  void _delete(BuildContext context, String id) {
    Widget yesButton = TextButton(
      child: Text(
        'Yakin?',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        setState(() {
          _transaksiPengguna.removeWhere((transaksi) => transaksi.id == id);
        });
        Navigator.of(context).pop();
      },
    );

    Widget noButton = TextButton(
      child: Text('Tidak',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hapus Item'),
            content: Text('Apa kamu yakin ingin menghapusnya?'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  noButton,
                  yesButton,
                ],
              )
            ],
          );
        });
  }

  double get totalSpending {
    return _transaksiPengguna.fold(0.0, (sum, item) {
      return sum + (item.amount as double);
    });
  }

  void _edit(String id, String expenses, String descript, double amount,
      DateTime chosenDate) {
    final editItem = Transaksi(
      id: id,
      expenses: expenses,
      descript: descript,
      chosenDate: chosenDate,
      amount: amount,
    );

    setState(() {
      _transaksiPengguna[_transaksiPengguna
          .indexWhere((item) => item.id == editItem.id)] = editItem;
          // print("Berhasil Edit" + editItem.id);
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Dashboard',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconBar(
            iconData: Icons.outbox,
            color: Colors.transparent,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20, top: 5),
            child: IconBar(
              iconData: Icons.person,
              color: Colors.grey,
            ),
          ),
        ]);
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Card(
                  elevation: 8,
                  color: Colors.transparent,
                  child: Container(
                    height: 100,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              'Total Pengeluaran :',
                              style: TextStyle(fontSize: 14),
                            )),
                        Center(
                          child: totalSpending == 0
                              ? Text(
                                  '0',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                )
                              : Text(
                                  'Rp ${totalSpending.toStringAsFixed(3)}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'All Expenses',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 30,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                            child: const Text(
                              "View All",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.7,
                  padding: EdgeInsets.all(10),
                  child: ListTransaksi(
                    transaksi: _transaksiPengguna,
                    delete: _delete,
                    edit: _edit,
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onPressed: () => _tambahTransaksiBaru(context)),
      ),
    );
  }
}
