# 📱 Home Page Listagem

Este aplicativo Flutter consome duas APIs para listar motéis e suas informações, como nome, imagem e preço.

---

## 🛠️ Funcionalidades

- Listagem de motéis com imagem, nome e preço.
- Consumo de duas APIs externas:
  - [JSONKeeper](https://jsonkeeper.com/b/1IXK)
  - [nPoint](https://www.npoint.io/docs/e728bb91e0cd56cc0711)
- Tratamento de erros para requisições.
- Arquitetura organizada com Provider.

---

## 🚀 Como Executar

### Pré-requisitos

- Flutter instalado ([Instruções](https://flutter.dev/docs/get-started/install))
- Emulador Android/iOS ou dispositivo físico configurado.


📦 Estrutura do Projeto
```
📂 lib
├── 📁 models
│   └── motel_model.dart  # Modelo de dados para os motéis
├── 📁 services
│   └── api_service.dart  # Serviço de integração com APIs
└── 📁 providers
    └── motel_provider.dart  # Provider para gerenciamento de estado
```
🛑 Pré-requisitos
```
Dart >= 3.0.0
Flutter >= 3.10.0
```
