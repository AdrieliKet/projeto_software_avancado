import 'package:flutter_application/entiadade/item_pedido.dart';

class Pedido {
  final List<ItemPedido> _itens = [];

  double realizarPedido(
    {required String nomeProduto, required int quantidade, required double precoUnidade, double descontoEmReais = 0, String cupom = ''}) {
    var item = ItemPedido(nomeProduto: nomeProduto, quantidade: quantidade, precoUnidade: precoUnidade, descontoEmReais: descontoEmReais, cupom: cupom);
    _itens.add(item);
    return item.getTotalItemComDesconto();
  }

  int contarItens() {
    return _itens.length;
  }

  double getTotal() {
    var total = 0.0;
    for (var item in _itens) {
      total += item.getTotalItemComDesconto();
    }
    return total;
  }
}
