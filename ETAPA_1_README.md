# ETAPA 1 - ShopMate MVP

## 🎯 Objetivo
Implementar um aplicativo funcional de lista de compras com:
- Autenticação Firebase
- Listas compartilháveis em tempo real
- CRUD completo de itens
- Offline-first com Hive
- Interface intuitiva com BLoC

## 📋 Estrutura do Projeto

```
shopmate/
├── lib/
│   ├── main.dart
│   ├── core/
│   │   ├── config/
│   │   │   ├── firebase_config.dart
│   │   │   └── theme.dart
│   │   ├── constants/
│   │   │   ├── app_constants.dart
│   │   │   └── firestore_paths.dart
│   │   ├── di/
│   │   │   └── service_locator.dart (GetIt)
│   │   ├── errors/
│   │   │   ├── failures.dart
│   │   │   └── exceptions.dart
│   │   └── utils/
│   │       ├── validators.dart
│   │       ├── currency_formatter.dart
│   │       └── logger.dart
│   ├── data/
│   │   ├── datasources/
│   │   │   ├── local/
│   │   │   │   ├── hive_user_datasource.dart
│   │   │   │   ├── hive_list_datasource.dart
│   │   │   │   └── hive_item_datasource.dart
│   │   │   └── remote/
│   │   │       ├── firestore_auth_datasource.dart
│   │   │       ├── firestore_list_datasource.dart
│   │   │       └── firestore_item_datasource.dart
│   │   ├── models/
│   │   │   ├── user_model.dart
│   │   │   ├── list_model.dart
│   │   │   ├── item_model.dart
│   │   │   └── member_model.dart
│   │   └── repositories/
│   │       ├── auth_repository.dart
│   │       ├── list_repository.dart
│   │       └── item_repository.dart
│   ├── domain/
│   │   ├── entities/
│   │   │   ├── user.dart
│   │   │   ├── shopping_list.dart
│   │   │   ├── shopping_item.dart
│   │   │   └── list_member.dart
│   │   ├── repositories/
│   │   │   ├── i_auth_repository.dart
│   │   │   ├── i_list_repository.dart
│   │   │   └── i_item_repository.dart
│   │   └── usecases/
│   │       ├── auth/
│   │       │   ├── login_usecase.dart
│   │       │   ├── logout_usecase.dart
│   │       │   ├── register_usecase.dart
│   │       │   └── get_current_user_usecase.dart
│   │       ├── lists/
│   │       │   ├── get_my_lists_usecase.dart
│   │       │   ├── create_list_usecase.dart
│   │       │   ├── update_list_usecase.dart
│   │       │   └── delete_list_usecase.dart
│   │       └── items/
│   │           ├── add_item_usecase.dart
│   │           ├── update_item_usecase.dart
│   │           ├── delete_item_usecase.dart
│   │           ├── toggle_checked_usecase.dart
│   │           └── get_list_items_usecase.dart
│   └── presentation/
│       ├── bloc/
│       │   ├── auth/
│       │   │   ├── auth_bloc.dart
│       │   │   ├── auth_event.dart
│       │   │   └── auth_state.dart
│       │   ├── lists_home/
│       │   │   ├── lists_home_bloc.dart
│       │   │   ├── lists_home_event.dart
│       │   │   └── lists_home_state.dart
│       │   └── list_detail/
│       │       ├── list_detail_bloc.dart
│       │       ├── list_detail_event.dart
│       │       └── list_detail_state.dart
│       ├── pages/
│       │   ├── splash_page.dart
│       │   ├── login_page.dart
│       │   ├── lists_home_page.dart
│       │   ├── list_detail_page.dart
│       │   └── onboarding_page.dart
│       └── widgets/
│           ├── list_card.dart
│           ├── item_tile.dart
│           ├── add_item_modal.dart
│           └── custom_button.dart
├── test/
│   ├── unit/
│   └── widget/
├── functions/
│   └── src/
│       ├── index.ts
│       └── package.json
├── firestore.rules
├── pubspec.yaml
├── firebase.json
└── README.md
```

## 🔧 Dependências do pubspec.yaml

### Firebase & Cloud
- `firebase_core: ^2.24.0`
- `cloud_firestore: ^4.13.0`
- `firebase_auth: ^4.10.0`
- `firebase_crashlytics: ^3.3.0`
- `firebase_analytics: ^10.4.0`

### State Management & DI
- `flutter_bloc: ^8.1.3`
- `equatable: ^2.0.5`
- `get_it: ^7.6.0`

### Local Storage
- `hive_flutter: ^1.1.0`
- `hive: ^2.2.3`

### UI & Utilities
- `intl: ^0.19.0` (formatação de moeda em centavos)
- `google_fonts: ^6.1.0`

## 📊 Modelos de Dados CORRIGIDOS

### User Entity (users/{uid})
```dart
class User {
  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;
  final DateTime createdAt;
  final bool onboardingComplete;
}
```

### Shopping List Entity (lists/{listId})
```dart
class ShoppingList {
  final String listId;
  final String title;
  final String ownerUid;
  final Map<String, ListMember> members;      // Map para roles
  final List<String> memberUids;              // ✅ Array para query!
  
  final String currency;
  final int budgetAmountCents;                // ✅ Em centavos!
  
  // Campos derivados (atualizados por trigger)
  final int itemsTotal;
  final int itemsChecked;
  final int totalEstimateCents;               // ✅ Em centavos!
  
  final bool archived;
  final int schemaVersion;
  
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime lastActivityAt;
}
```

### Shopping Item Entity (lists/{listId}/items/{itemId})
```dart
class ShoppingItem {
  final String itemId;
  final String name;
  final String kind;                           // free | product | storeProduct
  
  final double qty;
  final String unit;                           // UN, KG, L, etc
  final int priceEstimateCents;                // ✅ Em centavos!
  
  final String? productKey;                    // Referência ao catálogo
  final String? storeProductKey;
  
  final bool checked;
  final DateTime? checkedAt;
  final String? checkedBy;
  
  final String source;                         // manual, scanned, imported
  final double sortIndex;
  
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;
  final String updatedBy;
}
```

## 🔒 Security Rules (Firestore)

Ver arquivo `firestore.rules` no repositório com:
- Validação de `memberUids` array para query eficiente
- Proteção do catálogo `/products` (read-only)
- Acesso colaborativo com roles (owner/editor/viewer)

## ☁️ Cloud Functions (MVP)

1. **createInvite()** - Gerar convite com token
2. **acceptInvite()** - Aceitar convite e adicionar membro
3. **updateListStats()** - Trigger para atualizar campos derivados

## 🚀 Como Começar

### 1. Pré-requisitos
- Flutter SDK >= 3.13.0
- Dart SDK >= 3.0.0
- Firebase Project criado
- Git instalado

### 2. Clonar o Repositório
```bash
git clone https://github.com/decarjr/shopmate.git
cd shopmate
```

### 3. Instalar Dependências
```bash
flutter pub get
flutter pub run build_runner build  # Para gerar modelos Hive
```

### 4. Configurar Firebase
```bash
flutter pub global activate flutterfire_cli
flutterfire configure
```

### 5. Executar o App
```bash
flutter run
```

## 📝 Próximos Passos

1. Implementar AuthBloc (Login/Register)
2. Implementar Home Page (listagem de listas)
3. Implementar List Detail Page (CRUD de itens)
4. Adicionar validações e tratamento de erros
5. Testes unitários e de widget
6. Deploy no Firebase Hosting

## 🤝 Contribuições

Este é um projeto privado. Para sugestões, abra uma issue ou entre em contato.

## 📄 Licença

MIT License - veja LICENSE para detalhes.
