import 'package:flutter_application/core/cpf_validator.dart';
// A classe Pedido agora é responsável por armazenar os itens do pedido em uma lista de objetos da classe ItemPedido. 
// A classe ItemPedido agora é responsável por realizar o cálculo do total de cada item com o desconto, caso haja algum.
// Os métodos validaCupom() e getValorCupom() foram movidos para a classe ItemPedido, já que se tratam de funções relacionadas ao desconto do item e não do pedido em si.
class Pedido {
  var itens = <Object>[];
  var total = 0.0;
  double descontoEmReais = 0;
  Pedido({required String cpf}) {
    ValidateCpf.comCPF(cpf);
  }

  double realizarPedido(
    {required String nomeProduto, required int quantidade, required double precoUnidade, double descontoEmReais = 0,String cupom = ''}) {
    var totalItem = getTotalItem(quantidade: quantidade, precoUnidade: precoUnidade);
    if (cupom.isNotEmpty) {
      validaCupom(cupom);
      var desconto = getValorCupom(cupom) / 100;
      totalItem -= (desconto * totalItem);
    } else {
      totalItem -= descontoEmReais;
    }
    addItem(nomeProduto: nomeProduto, quantidade: quantidade, precoUnidade: precoUnidade);
    total += totalItem;
    return totalItem;
  }

  addItem({required String nomeProduto, required int quantidade, required double precoUnidade, double descontoEmReais = 0, String cupom = ''}) {
    var existe = false;
    for (var i = 0; i < itens.length; i++) {
      var item = itens[i] as List<Object>;
      if (item[0] == nomeProduto) {
        item[1] = quantidade + int.parse(item[1].toString());
        existe = true;
        break;
      }
    }
    if (!existe) {
      itens.add([nomeProduto, quantidade, precoUnidade, descontoEmReais, cupom]);
    }
  }

  contarItem() {
    return itens.length;
  }

  getTotal() {
    return total;
  }

  double getTotalItem({required int quantidade, required double precoUnidade}) {
    return quantidade * precoUnidade;
  }

  int getValorCupom(String cupom) {
    return int.parse(cupom.substring(5, 7));
  }

  bool validaCupom(String cupom) {
    if (cupom.contains('cupom') && getValorCupom(cupom) <= 15) {
      return true;
    }
    return false;
  }
}
