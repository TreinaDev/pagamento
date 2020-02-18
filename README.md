
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

