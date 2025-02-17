# 🏨 Replica List Moteis

<div align="center">

[![Flutter](https://img.shields.io/badge/Flutter-3.10.0-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0.0-blue.svg)](https://dart.dev/)

</div>

 Aplicativo desenvolvido em Flutter para listagem de motéis e suas suítes.

>📌 Descrição do Desafio
O desafio consiste em criar uma réplica da tela de listagem de motéis (apenas a aba "Ir Agora") do aplicativo Guia de Motéis GO, utilizando os seguintes links como API mock para obter os dados:

https://jsonkeeper.com/b/1IXK

https://www.npoint.io/docs/e728bb91e0cd56cc0711

>📌 Requisitos:
A listagem deve exibir os motéis disponíveis com nome, preço e imagem.
O design não precisa ser 100% fiel, podendo utilizar outros ícones ou variações visuais.
Não é necessário implementar navegação para outras telas.

## 📱 Demonstração

<div align="center">

[📸 Ver Screenshot](https://drive.google.com/file/d/1hQvoYbYQ1-bt23Ms5vrn-wbmmrsNljJ6/view?usp=sharing)

[🎥 Ver Vídeo Demo](https://drive.google.com/file/d/1XQGog0BsXClY-rHvsSn5RlAOHb2VtGKC/view?usp=sharing).

</div>

## ✨ Funcionalidades

- 📋 Listagem de motéis e suítes
- 💰 Exibição de preços e descontos
- 🌐 Integração com API
- 🔄 Gerenciamento de estado com Provider
- ⚡ Carregamento otimizado de imagens 

## 🛠️ Tecnologias Utilizadas

- Flutter
- Dart
- Provider (Gerenciamento de Estado)
- Cached Network Image
- HTTP
- ...

## 📂 Estrutura do Projeto
```
lib/
├── controllers/ # Controladores de lógica de negócios
│ └── motel_controller.dart
│
├── models/ # Modelos de dados
│ ├── motel_model.dart
│
├── providers/ # Gerenciamento de estado
│ └── motel_provider.dart
│
├── services/ # Serviços e integrações
│ └── api_service.dart
│
├── views/ # Telas da aplicação
│ └── motel_list_screen.dart
│
├── widgets/ # Componentes reutilizáveis
│ ├── itens_suite_widgets.dart
│ ├── motel_item_widgets.dart
│ ├── periodo_widgets.dart
│ └── motel_item.dart
│ └── suite_widgets.dart
│
└── main.dart # Ponto de entrada da aplicação
```

Esta estrutura foi pensada para:
- 🎯 Manter o código organizado
- 🔄 Facilitar a manutenção
- 📦 Permitir reuso de componentes
- 🛠️ Separar responsabilidades
- ⚡ Melhorar performance
