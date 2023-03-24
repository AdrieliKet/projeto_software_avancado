import 'package:flutter_application/entiadade/item_pedido.dart';
import 'package:flutter_application/entiadade/pedido.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('deve criar um pedido com 3 itens', () {
    var pedido = Pedido();
    pedido.realizarPedido(
        nomeProduto: 'coca-cola', quantidade: 2, precoUnidade: 6.5);
    pedido.realizarPedido(nomeProduto: 'fanta', quantidade: 1, precoUnidade: 6);
    pedido.realizarPedido(
        nomeProduto: 'chokito', quantidade: 3, precoUnidade: 3.5);
    expect(pedido.contarItens(), 3);
  });


  test('deve apresentar a soma de um item corretamente', () {
    var pedido = Pedido();
    var totalItem = pedido.realizarPedido(
        nomeProduto: 'coca-cola', quantidade: 2, precoUnidade: 6.5);
    expect(totalItem, 13.0);
  });

  test('deve permitir desconto em reais do item de no máximo 15%', () {
    var pedido = Pedido();
    expect(
        pedido.realizarPedido(
            nomeProduto: 'fanta',
            quantidade: 2,
            precoUnidade: 5,
            descontoEmReais: 1.5),
        8.5);
  });

  test('deve apresentar o total do pedido corretamente', () {
    var pedido = Pedido();
    pedido.realizarPedido(
        nomeProduto: 'coca-cola',
        quantidade: 2,
        precoUnidade: 6.5,
        descontoEmReais: 1);
    pedido.realizarPedido(
        nomeProduto: 'fanta',
        quantidade: 2,
        precoUnidade: 5,
        descontoEmReais: 1.5);
    expect(pedido.getTotal(), 20.5);
  });

  test('deve validar e calcular o desconto de um cupom de desconto', () {
    var pedido = Pedido();
    var itemPedido = ItemPedido(
        nomeProduto: 'coca-cola',
        quantidade: 2,
        precoUnidade: 6.5,
        descontoEmReais: 0,
        cupom: 'cupom20');

    expect(itemPedido.validaCupom(), false);
  });

  test('deve adicionar um cupom de desconto', () {
    var pedido = Pedido();

    expect(
        pedido.realizarPedido(
            nomeProduto: 'coca-cola',
            quantidade: 2,
            precoUnidade: 6.5,
            descontoEmReais: 0,
            cupom: 'cupom15'),
        11.05);
  });
}
