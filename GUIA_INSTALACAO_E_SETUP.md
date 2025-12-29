# GUIA COMPLETO DE INSTALAÇÃO E SETUP - ShopMate ETAPA 1

## 🛍️ Pré-Requisitos (LEA COM ATENÇÃO!)

Antes de começar, você precisa ter INSTALADO na sua máquina:

### 1. **Flutter SDK** (versão >= 3.13.0)
- **Download**: https://flutter.dev/docs/get-started/install
- **Passos**:
  1. Baixe a versão para seu SO (Windows/Mac/Linux)
  2. Extraia em um diretório (recomendado: C:\\flutter ou ~/flutter)
  3. Adicione ao PATH (variável de ambiente)
  4. Execute no terminal: `flutter doctor` para verificar

### 2. **Dart SDK** (já vem com Flutter)
- Verifique: `dart --version`

### 3. **Git** (para versionamento)
- **Download**: https://git-scm.com/
- Verifique: `git --version`

### 4. **Android Studio ou Xcode**
- **Android Studio**: Para emulador Android
- **Xcode**: Para emulador iOS (macOS apenas)
- Execute: `flutter doctor` para diagnosticar

### 5. **Visual Studio Code** ou **Android Studio** (IDE)
- Instale a extensão Flutter no VS Code

## 🚀 PASSO 1: Clonar o Repositório

```bash
# Clone do GitHub
git clone https://github.com/decarjr/shopmate.git
cd shopmate

# Ou, se usar SSH (mais seguro):
git clone git@github.com:decarjr/shopmate.git
cd shopmate
```

## 🔧 PASSO 2: Instalar Dependências Flutter

```bash
# Limpar cache (recomendado)
flutter clean

# Obter todas as dependências do pubspec.yaml
flutter pub get

# Gerar códigos automáticos (Hive, BuildRunner, etc)
flutter pub run build_runner build --delete-conflicting-outputs
```

## 🔥 PASSO 3: Configurar Firebase (IMPORTANTE!)

### 3.1 Criar um projeto Firebase
1. Acesse: https://console.firebase.google.com
2. Clique em "Criar projeto"
3. Nome: `shopmate-dev` (ou seu próprio nome)
4. Selecione sua conta Google
5. Ative Google Analytics (opcional)
6. AGUARDE A CRIAÇÃO!

### 3.2 Registrar seu app com Firebase
1. No Firebase Console, adicione um app Flutter
2. Siga as instruções para cada plataforma:
   - **iOS**: Copie o arquivo `GoogleService-Info.plist`
   - **Android**: Copie o arquivo `google-services.json`

### 3.3 Usar FlutterFire CLI (RECOMENDADO)
```bash
# Ativar CLI globalmente
flutter pub global activate flutterfire_cli

# Configurar automaticamente
flutterfire configure

# Siga as instruções interativas!
```

## 📊 PASSO 4: Configurar Firestore Database

### 4.1 Criar Firestore Database
1. No Firebase Console, vá para "Firestore Database"
2. Clique em "Criar banco de dados"
3. Localização: Escolha a mais próxima de você
4. Modo de segurança: Comece em **modo teste** (permite leitura/escrita)
5. AGUARDE A CRIAÇÃO!

### 4.2 Carregar Security Rules
1. Vá para "Rules"
2. Substitua todo o conteúdo pelo arquivo `firestore.rules` do repositório
3. Publique!

## 🧐 PASSO 5: Configurar Authentication

### 5.1 Ativar Email/Password
1. No Firebase Console, vá para "Authentication"
2. Clique em "Ativar método de login"
3. Selecione "Email/Senha"
4. Ative e salve

### 5.2 (Opcional) Ativar Google Sign-In
1. Vá para Authentication > Configuração OAuth
2. Selecione "Google"
3. Siga as instruções

## 🌟 PASSO 6: Executar o App (FINALMENTE!)

### Opção A: Emulador Android
```bash
# Liste os emuladores disponíveis
flutter emulators --list

# Inicie um emulador
flutter emulators --launch <emulator_id>

# Execute o app
flutter run
```

### Opção B: Emulador iOS (macOS)
```bash
flutter run -d macos  # Ou
iOS Simulator simárico
```

### Opção C: Dispositivo Físico
```bash
# Liste os dispositivos conectados
flutter devices

# Execute em um dispositivo específico
flutter run -d <device_id>
```

## ⚠️ TROUBLESHOOTING (Problemas Comuns)

### "Flutter not found" (Windows)
- Adicione Flutter ao PATH:
  1. Abra "Variáveis de Ambiente" do Windows
  2. Adicione: `C:\\Users\\<SeuUsuário>\\flutter\\bin`
  3. Reinicie o Terminal/VS Code

### "pub get failed"
```bash
flutter pub cache clean
flutter pub get
```

### "Gradle error" (Android)
```bash
flutter clean
flutter pub get
```

### "No signingConfig" (Android)
- Verifique que você executou `flutterfire configure`

## 🙋 PRÓXIMAS ETAPAS (Depois da Instalação)

1. **Explore o código**
   - Abra `lib/main.dart` e siga a estrutura
   - Leia `ETAPA_1_README.md` para entender a arquitetura

2. **Crie sua primeira lista**
   - Faça login com email/senha
   - Teste criar uma lista e adicionar itens

3. **Teste offline-first**
   - Desconecte a internet
   - Crie items (devem funcionar)
   - Reconecte para sincronizar

4. **Implemente as features pendentes**
   - Leia as issues do GitHub
   - Siga o roadmap na documentação

## 📈 PRÓXIMAS ETAPAS DO PROJETO (Fase 2 e 3)

### ETAPA 2: Barcode Scanner + Cupom Fiscal
- Ler códigos de barras com câmera
- Integrar com API de produtos (ex: ANVISA, SupermarketAPI)
- Importar cupom fiscal (NFC-e)

### ETAPA 3: IA e Analytics
- Sugestões inteligentes de produtos
- Análise de gastos com gráficos
- Previsões de orçamento

## 📞 SUPORTE E DÚVIDAS

Se encontrar problemas:
1. Leia este guia novamente
2. Verifique a estrutura do projeto em `ETAPA_1_README.md`
3. Consulte o `flutter doctor -v` para diagnósticos
4. Abra uma issue no GitHub

## ✅ CHECKLIST: Instalação Completa

- [ ] Flutter SDK instalado e `flutter doctor` OK
- [ ] Git configurado
- [ ] Repositório clonado
- [ ] `flutter pub get` executado com sucesso
- [ ] `flutter pub run build_runner build` OK
- [ ] Firebase project criado
- [ ] FlutterFire CLI configurado
- [ ] Firestore Database criado
- [ ] Security Rules carregadas
- [ ] Authentication habilitado
- [ ] App executa sem erros (`flutter run`)
- [ ] Consegue fazer login

**Parabéns! Você está pronto para ETAPA 1!** 🚀
