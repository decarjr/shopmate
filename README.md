# shopmate
📱 ShopMate - Sua lista inteligente de compras com compartilhamento em tempo real, barcode scanner e análise de gastos. Offline-first com Firebase Firestore e Flutter.

## Documentação de arquitetura
- [Plano de Arquitetura Completa](PLANO_ARQUITETURA_COMPLETA.md): visão executiva, modelo de dados (produto universal + perfil do usuário + lista), mapa de telas por etapa e roadmap para MVP, cupons fiscais e IA.

## 🚀 Passo-a-passo para começar (leigo-friendly)
1) **Instale o Flutter**  
   - Siga o guia oficial: https://docs.flutter.dev/get-started/install  
   - Certifique-se de que o comando `flutter doctor` não mostre erros críticos.

2) **Clone este repositório e instale dependências**  
   ```bash
   git clone https://github.com/decarjr/shopmate.git
   cd shopmate
   flutter pub get
   ```

3) **Configure o Firebase (gera o arquivo `lib/firebase_options.dart`)**  
   - Instale o CLI do FlutterFire:  
     ```bash
     dart pub global activate flutterfire_cli
     ```  
   - Faça login e escolha seu projeto Firebase:  
     ```bash
     flutterfire configure --project <ID-do-projeto-Firebase>
     ```  
   - O comando acima cria `lib/firebase_options.dart` automaticamente. Sem esse arquivo o app não inicializa o Firebase.

4) **Rodar localmente (web ou emulador)**  
   ```bash
   flutter run -d chrome   # ou -d emulator-5554 / -d ios
   ```  
   Você verá a Splash, login fake e lista de exemplo com progresso e resumo.

5) **(Opcional) Rodar sem Firebase**  
   - O app funciona offline com dados locais. Caso você não tenha um projeto Firebase ainda, o app abre normalmente e mostra as listas demo.
   - Quando quiser ativar o Firebase, execute o passo 3 e reinicie o app.

6) **Publicar no GitHub**  
   ```bash
   git add .
   git commit -m "chore: preparação do app Flutter base"
   git push origin main    # ou o nome da sua branch
   ```  
   Crie um repositório no GitHub (se ainda não existir) e aponte o `origin` para ele.

> Dica: Para iniciantes, siga o roteiro acima na ordem. Se algo falhar, reexecute `flutter pub get` e confirme que o `firebase_options.dart` foi criado pelo FlutterFire CLI.

## 🛒 O que já está pronto na UI
- Splash → Login → Onboarding (fluxo simples, sem backend)  
- Tela de listas com progresso, orçamento opcional e botão de criar nova lista  
- Tela de itens com:
  - Adicionar item (nome, quantidade, unidade, preço)
  - Marcar como comprado (checkbox)
  - Editar e excluir itens
  - Cartão de resumo com total pendente vs. orçamento

> Tudo funciona offline com estado local (`provider`). Quando o Firebase estiver configurado, a mesma estrutura pode ser conectada ao backend.

## 📦 Estrutura Flutter resumida
- `lib/main.dart` – Inicializa Flutter e, se configurado, o Firebase (modo seguro para rodar sem Firebase).
- `lib/app.dart` – Cria o `MaterialApp` e registra as rotas.
- `lib/features/lists/state/lists_controller.dart` – Gerencia as listas e itens em memória (demo/offline).
- `lib/features/lists/presentation/pages/` – Telas de listas e itens com formulários simples.
