# FIXAR ERROS - SOLUCAO RAPIDA

## VOCE TEM 3 ERROS - FACIL DE CONSERTAR!

### ERRO 1: Web nao esta configurado
```
This application is not configured to build on the web.
```

**SOLUCAO:** Execute ISTO na pasta shopmate:
```bash
flutter create . --platforms web
```

Isso vai criar:
- web/index.html
- web/manifest.json
- web/icons/

---

### ERRO 2: Assets ausentes
```
Error: unable to find directory entry in pubspec.yaml: C:\projetos\shopmate\assets\images\
Error: unable to find directory entry in pubspec.yaml: C:\projetos\shopmate\assets\icons\
```

**SOLUCAO:** Crie as pastas (voce ja tem o comando do SETUP_PROJECT_WINDOWS.ps1):
```bash
mkdir -p assets/images assets/icons assets/fonts
```

---

### ERRO 3: Font ausente
```
Error: unable to locate asset entry in pubspec.yaml: "assets/fonts/GoogleSans-Regular.ttf"
```

**SOLUCAO:** REMOVA essa linha do seu pubspec.yaml!

VA ATE O SEU pubspec.yaml e DELETE:
```yaml
fonts:
  - family: GoogleSans
    fonts:
      - asset: assets/fonts/GoogleSans-Regular.ttf
```

OU cole este pubspec.yaml CORRIGIDO abaixo.

---

## PASSO A PASSO RAPIDO (3 MINUTOS)

### 1. Abra terminal na pasta shopmate
```bash
cd C:\projetos\shopmate
```

### 2. Configure web
```bash
flutter create . --platforms web
```

### 3. Crie as pastas
```bash
mkdir -p assets/images assets/icons assets/fonts
```

### 4. SUBSTITUA seu pubspec.yaml
COPIE o arquivo abaixo e SUBSTITUA seu pubspec.yaml inteiro.

### 5. Faça pub get
```bash
flutter pub get
```

### 6. Rode a app
```bash
flutter run -d chrome
```

---

## pubspec.yaml CORRETO

COPIE E SUBSTITUA TODO o seu arquivo pubspec.yaml:

```yaml
name: shopmate
description: "ShopMate - Sua lista inteligente de compras."
publish_to: "none"

version: 1.0.0+1

environment:
  sdk: ^3.0.0

dependencies:
  flutter:
    sdk: flutter

  firebase_core: ^2.24.0
  firebase_auth: ^4.10.0
  cloud_firestore: ^4.13.0
  provider: ^6.0.0
  equatable: ^2.0.5
  dartz: ^0.10.1
  intl: ^0.19.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/icons/
```

---

## DEPOIS: cria as pastas assets

```bash
mkdir -p assets/images
mkdir -p assets/icons
mkdir -p assets/fonts
```

AGORA SIM vai funcionar!

---

## E SE AINDA TIVER ERRO?

Execute:
```bash
flutter clean
flutter pub get
flutter run -d chrome
```

---

**Depois disso, o app vai rodar SEM ERROS!**
