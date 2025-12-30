# 📋 CÓDIGO COMPLETO ETAPA 1 - GUIA COPIAR & COLAR

> **IMPORTANTE**: Este documento contém TODO o código que você precisa para a ETAPA 1. 
Copie e cole nos arquivos corretos do seu projeto Flutter local.

## 🚀 Como Usar Este Documento

### PASSO 1: Preparar seu projeto local
```bash
cd C:\projetos\shopmate
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### PASSO 2: Copiar código para os arquivos corretos
Cada seção abaixo mostra:
- **Caminho do arquivo**: Onde copiar
- **CÓdigo**: O que copiar

### PASSO 3: Rodar o app
```bash
flutter run -d chrome
```

---

## 📜 Arquivo 1: lib/main.dart
**Caminho**: `lib/main.dart`
**Status**: Já está no GitHub

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();
  
  runApp(const ShopMateApp());
}

class ShopMateApp extends StatelessWidget {
  const ShopMateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopMate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            const Text(
              'ShopMate',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Sua lista inteligente de compras',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
```

---

## 💡 Próximos Passos (Imediatamente)

Ag ora que você já tem:

✅ **Documentação completa** (ETAPA_1_README.md)  
✅ **Guia de instalação** (GUIA_INSTALACAO_E_SETUP.md)  
✅ **Arquivo main.dart** (lib/main.dart)  
✅ **pubspec.yaml** com todas as dependências  
✅ **firestore.rules** otimizadas  

### Você deve agora:

1. **Rodar o app** para confirmar que funciona:
   ```bash
   flutter run -d chrome
   ```
   Deve mostrar a tela de Splash com o ícone de carrinho

2. **Próximo commit**: Implementar os **BLoCs** (Autenticação)
   - AuthBloc para login/logout/register
   - Estado com user autenticado

3. **Depois**: Implementar **Pages** (Telas)
   - LoginPage
   - HomePage (listagem de listas)
   - ListDetailPage (CRUD de itens)

## 📄 Checklist

- [ ] Executou `flutter pub get`
- [ ] Executou `flutter pub run build_runner build`  
- [ ] Rodar `flutter run` funciona
- [ ] Veê a tela de Splash
- [ ] Entendeu a estrutura de pastas
- [ ] Está pronto para PRÓXIMA ETAPA (Implementing BLoCs)

---

## 🔂 Ciclo de Desenvolvimento Recomendado

**ETAPA 1.1** (Atual)
- main.dart ✅
- pubspec.yaml ✅
- firestore.rules ✅

**ETAPA 1.2** (Próxima)
- Domain/Entities
- Data/Models
- Data/Datasources
- Data/Repositories
- BLoCs

**ETAPA 1.3**
- Pages (Splash, Login, Home, Detail)
- Widgets reutilizáveis
- Tema da apliccao

**ETAPA 1.4**
- Testes unitários
- Testes de widget
- Firebase Auth integration

---

## 🗑️ Estrutura Final do Projeto (ETAPA 1)

```
shopmate/
├── lib/
│   ├── main.dart                     ✅ ✔️
│   ├── core/
│   │   ├── config/
│   │   ├── constants/
│   │   ├── di/                       (próximo)
│   │   ├── errors/
│   │   └── utils/
│   ├── data/
│   │   ├── datasources/             (próximo)
│   │   ├── models/                 (próximo)
│   │   └── repositories/           (próximo)
│   ├── domain/
│   │   ├── entities/               (próximo)
│   │   ├── repositories/           (próximo)
│   │   └── usecases/               (próximo)
│   ├── presentation/
│   │   ├── bloc/                   (próximo)
│   │   ├── pages/                  (próximo)
│   │   └── widgets/                (próximo)
│   ├── test/
└── pubspec.yaml                     ✅ ✔️
└── firestore.rules                  ✅ ✔️
```

---

## 🎆 Celebração!

**Você conseguiu!** 🎆🎆🎆

A infraestrutura básica da ETAPA 1 está pronta. Agora é só implementar as features de forma sistemática.

Próximo passo: Me avise quando rodar o app com sucesso! 🚀
