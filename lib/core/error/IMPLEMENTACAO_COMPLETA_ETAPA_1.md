# IMPLEMENTACAO COMPLETA ETAPA 1 - ShopMate

## Guia Passo a Passo para Iniciantes

Este documento contém TODOS os códigos necessários para implementar a ETAPA 1 do ShopMate.

### COMO USAR:

1. Crie a estrutura de pastas com os comandos em PASSO 1
2. Para cada arquivo, COPIE o código
3. COLE no arquivo correspondente em seu projeto
4. SALVE o arquivo
5. Repita para todos os arquivos

---

## PASSO 1: CRIAR ESTRUTURA DE PASTAS

No terminal, na raiz do projeto (shopmate), execute:

```bash
mkdir -p lib/core/error lib/core/utils lib/core/theme
mkdir -p lib/domain/entities lib/domain/repositories lib/domain/usecases
mkdir -p lib/data/datasources lib/data/models lib/data/repositories
mkdir -p lib/presentation/bloc lib/presentation/pages lib/presentation/widgets
mkdir -p assets/images assets/icons assets/fonts
```

---

## IMPORTANTE: DEPENDÊNCIAS DO pubspec.yaml

Verifique se seu arquivo pubspec.yaml contém essas dependências:

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.24.0
  firebase_auth: ^4.10.0
  cloud_firestore: ^4.13.0
  provider: ^6.0.0
  equatable: ^2.0.5
  dartz: ^0.10.1
  cached_network_image: ^3.3.0
  intl: ^0.19.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
```

Se faltar alguma, adicione e execute:
`flutter pub get`

---

## PRÓXIMAS SEÇÕES

Acompanhe os arquivos abaixo em ordem. Cada um é essencial para o funcionamento da ETAPA 1.
