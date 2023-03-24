class ItemPedido {
  final String nomeProduto;
  final int quantidade;
  final double precoUnidade;
  final double descontoEmReais;
  final String cupom;

  ItemPedido({required this.nomeProduto, required this.quantidade, required this.precoUnidade, required this.descontoEmReais, required this.cupom});

  double getTotalItem() {
    return quantidade * precoUnidade;
  }

  double getTotalItemComDesconto() {
    var total = getTotalItem();
    if (cupom.isNotEmpty) {
      if (validaCupom()) {
        var desconto = getValorCupom() / 100;
        total -= (desconto * total);
      }
    } else {
      total -= descontoEmReais;
    }
    return total;
  }

  int getValorCupom() {
    return int.parse(cupom.substring(5, 7));
  }

    bool validaCupom() {
    if (cupom.contains('cupom') && getValorCupom() <= 15) {
      return true;
    }
    return false;
  }
}