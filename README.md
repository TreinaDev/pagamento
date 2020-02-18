
[![Build
Status](https://travis-ci.com/TreinaDev/pagamento.svg?branch=master)](https://travis-ci.com/TreinaDev/pagamento)


# README
## API TODOS OS MEIOS DE PAGAMENTO DO CLIENTE

A API com retorno de todos os meios de pagamentos escolhidos e configurados pelo cliente é 

## API DE SIMULAÇÃO DE PAGAMENTO

A Simulação de Pagamento é feita na chamada dessa rota:
api/v1/client/:token/transaction_simulation?value=

:token = Corresponde ao token gerado na criação da sua conta
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

{
  :message=>     "Perfil não encontrado"
}
