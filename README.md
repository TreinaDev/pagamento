
[![Build
Status](https://travis-ci.com/TreinaDev/pagamento.svg?branch=master)](https://travis-ci.com/TreinaDev/pagamento)


# README
## API TODOS OS MEIOS DE PAGAMENTO DO CLIENTE

A API que retorna de todos os meios de pagamentos escolhidos e configurados pelo cliente é feita pela chamada da rota:
api/v1/client/:token/payment_methods
:token = Corresponde ao token gerado na criação da conta do cliente

O exemplo abaixo corresponde ao resultado em json de uma simulação de pagamento com 2 métodos de pagamento configurados:
o status de sucesso é :ok

```
{
  :payment_methods=>
  [
    {
      :id=>1,
      :name=>"Cartão de Debito",
      :payment_companies=>
     [
       {
          :name=>"MasterCard",
          :image=> 
          "/rails/active_storage/blobs/bfbae332eee5ce5/mastercard.png"
        }
      ]
    }
  ]
}
```

Caso não tenha configurado ainda um meio de pagamento receberá a seguinte mensagem:
Com status: 404
```
{
  :message=>"Não há meio de pagamentos cadastrados"
}
```

Se o meio de pagamento cadastrado não possuir empresa, receberá uma json com o status: ok
Conforme json abaixo:

```
{
  :payment_methods=>[]
}
```

## API DE SIMULAÇÃO DE PAGAMENTO

A Simulação de Pagamento é feita na chamada dessa rota:
api/v1/client/:token/transaction_simulation?value=

:token = Corresponde ao token gerado na criação da conta do cliente
value = corresponde ao valor total da transação

O exemplo abaixo corresponde ao resultado em json de uma simulação de pagamento com 2 métodos de pagamento configurados:
o status de sucesso é :ok

```
[
   {
:id=>      1
:name=>      "Cartão de Debito",
:value=>      "2000.0",
:installments=>2,
:one_shot=>      "1900.0",
:total_value=>      "2400.0",
:installment_value=>      "1200.0"
   
},
   {
:name=>      "Boleto",
:value=>      "2000.0",
:installments=>5,
:one_shot=>      "1800.0",
:total_value=>      "2600.0",
:installment_value=>      "520.0"
   
}
]
```

Caso não tenha configurado ainda um meio de pagamento receberá um array vazio como resposta

Se ainda não tiver um token cadastrado receberá uma mensagem de perfil não encontrado e o status :not_found
Conforme json abaixo:

``` 
{
  :message=>     "Perfil não encontrado"
}
```

## API DE EFETIVAÇÃO E CONFIRMAÇÃO DE PAGAMENTO

A efetivação e confirmação do pagamento é feita através da chamada da rota: 
'/api/v1/client/:token/order?order_value=&order_id=&payment_method_id=&order_installments=&order_installments_value='

:token = Corresponde ao token gerado na criação da conta do cliente 

order_value = Corresponde ao valor total a ser pago pelo consumidor final

order_id = Corresponde ao indentificador do pedido na plataforma de vendas

payment_method_id = Corresponde ao identificador do meio de pagamento utilizado pelo consumidor final. Este identificador é adquirido na chamada de Simulação de Pagamento.

order_installments = Corresponde ao número de parcelas escolhida pelo consumidor final

order_installments_value = Corresponde ao valor unitário de cada parcela

O JSON abaixo corresponde a uma transação bem sucedida, em que todos os parãmetros foram passados corretamente e o token do cliente foi reconhecido pelo sistema:

```
Rota chamada no exemplo: 
  '/api/v1/client/'QwDASFEQFDFAEFEFE'/order?order_value=500&order_id=24&payment_method_id=1&order_installments=1&order_installments_value=500'
```

```
[
  {
    :message=>"Pagamento efetivado com sucesso",
    :order=>
      {
        :id=>1,
        :order_id=>24,
        :order_value=>"500.0",
        :client_profile_id=>1,
        :payment_method_id=>1,
        :client_value=>"475.0",
        :order_installments=>1,
        :order_installments_value=>"500.0"
      }
  }
]
```

Caso o token enviado esteja nulo ou não relacionado a nenhum cliente registrado, o retorno é o seguinte:

```
Rota chamada no exemplo: '/api/v1/client/''/order?order_id=24&payment_method_id=1'
```

```
[
  {
    :message=>"Cliente não registrado"
  }
]
```

Caso o token esteja correto, compatível com um cliente cadastrado, porém algum dos parâmetros está nulo, o retorno é uma mensagem informando qual ou quais parâmetros obrigatórios não foram passados:

```
Rota chamada no exemplo: '/api/v1/client/'QwDASFEQFDFAEFEFE'/order?order_id=24&payment_method_id=1'
```

```
[
  {
    :message=>["Valor do Pedido não pode ficar em branco", "Parcelas do Pedido não pode ficar em branco", "Valor das parcelas do Pedido não pode ficar em branco"]
  }
]
```
