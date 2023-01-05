import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pengelolaan_uang_app/widget/edit_transaksi_baru.dart';

import '../model/transaksi_model.dart';

class ListTransaksiItem extends StatefulWidget {
  final Transaksi transaksi;
  final Function delete;
  const ListTransaksiItem({
    required this.delete,
    required this.transaksi,
    Key? key,
  }) : super(key: key);

  @override
  State<ListTransaksiItem> createState() => _ListTransaksiItemState();
}

class _ListTransaksiItemState extends State<ListTransaksiItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            ' Date : ${DateFormat('dd-MM-yyyy').format(widget.transaksi.chosenDate)}',
            style: const TextStyle(color: Colors.black38, fontSize: 14),
          ),
          Card(
            elevation: 5,
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                      margin: EdgeInsets.only(
                          top: 10, left: 5, bottom: 10, right: 5),
                      child: Container(
                        child: Text(
                          'Rp ${widget.transaksi.amount.toStringAsFixed(3)}',
                          style: TextStyle(fontSize: 16),
                        ),
                      )),
                  title: Text(widget.transaksi.expenses),
                  subtitle: Text(widget.transaksi.descript),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => EditTransaksiBaru(
                                        transaksi: widget.transaksi,
                                      )))
                              .then((value) {
                                setState((){});
                              });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          widget.delete(context, widget.transaksi.id);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
