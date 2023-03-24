import 'package:flutter_application/entiadade/pedido.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('não deve criar um pedido com CPF invalido', () {
    expect(() => Pedido(cpf: '111'), throwsException);
  });

  test('deve criar um pedido com 3 itens', () {
    var pedido = Pedido(cpf: '264.310.820-52');
    pedido.realizarPedido(nomeProduto: 'coca-cola', quantidade: 2, precoUnidade: 6.5);
    pedido.realizarPedido(nomeProduto: 'fanta', quantidade: 1, precoUnidade: 6);
    pedido.realizarPedido(nomeProduto: 'chokito', quantidade: 3, precoUnidade: 3.5);
    expect(pedido.contarItem(), 3);
  });

  test(
      'ao adicionar um produto existente no pedido, deve alterar a quantidade sem criar um novo items',
      () {
    var pedido = Pedido(cpf: '264.310.820-52');
    pedido.realizarPedido(nomeProduto: 'coca-cola', quantidade: 2, precoUnidade: 6.5);
    pedido.realizarPedido(nomeProduto: 'coca-cola', quantidade: 1, precoUnidade: 6);
    pedido.realizarPedido(nomeProduto: 'chokito', quantidade: 3, precoUnidade: 3.5);
    expect(pedido.contarItem(), 2);
  });

  test('deve apresentar a soma de um item corretamente', () {
    var pedido = Pedido(cpf: '264.310.820-52');
    var totalItem = pedido.realizarPedido(
        nomeProduto: 'coca-cola', quantidade: 2, precoUnidade: 6.5);
    expect(totalItem, 13.0);
  });

  test('deve permitir desconto em reais do item de no máximo 15%', () {
    var pedido = Pedido(cpf: '264.310.820-52');
    expect(
        pedido.realizarPedido(
            nomeProduto: 'fanta',
            quantidade: 2,
            precoUnidade: 5,
            descontoEmReais: 1.5),
        8.5);
  });

  test('deve apresentar o total do pedido corretamente', () {
    var pedido = Pedido(cpf: '264.310.820-52');
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
    var pedido = Pedido(cpf: '264.310.820-52');
    expect(pedido.validaCupom('cupom20'), false);
    expect(pedido.validaCupom('cupom15'), true);
  });

  test('deve adicionar um cupom de desconto', () {
    var pedido = Pedido(cpf: '264.310.820-52');

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
