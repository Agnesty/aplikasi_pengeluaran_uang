import 'package:flutter/material.dart';

import '../model/transaksi_model.dart';
import 'list_transaksi_item.dart';

class ListTransaksi extends StatefulWidget {
  final Function edit;
  final List<Transaksi> transaksi;
  final Function delete;
  const ListTransaksi({required this.edit, required this.transaksi, required this.delete, super.key});

  @override
  State<ListTransaksi> createState() => _ListTransaksiState();
}

class _ListTransaksiState extends State<ListTransaksi> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
      widget.transaksi.isEmpty
          ? Center(
              child: Container(
              child: Text('Belum ada yang ditambahkan', style: TextStyle(),),
            ))
          : 
          ListView.builder(
            itemCount: widget.transaksi.length,
            itemBuilder: (ctx, index){
              return ListTransaksiItem(
                transaksi: widget.transaksi[index], 
                delete: widget.delete,
                edit: widget.edit,);
            })
    );
  }
}


