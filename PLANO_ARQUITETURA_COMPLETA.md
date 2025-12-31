# Plano de Arquitetura Completa – ShopMate

Documento-guia para alinhar visão de produto, modelo de dados e plano de entrega em três etapas. Priorizamos **MVP que roda** (Etapa 1) já pensando na evolução para cupons fiscais (Etapa 2) e IA/insights (Etapa 3) sem refatorações drásticas.

---

## 1. Visão e Princípios
- **Offline-first + tempo real**: Firestore com cache local. Lista funciona sem internet e sincroniza depois.
- **Separação de responsabilidades**: UI → Domínio → Dados (ports/adapters). Widgets nunca falam direto com Firestore.
- **Identidade clara dos dados**:
  - **Produto universal** (country+barcode) = identidade compartilhada.
  - **Perfil do produto por usuário** = preferências pessoais (alias, qty, preço típico).
  - **Item da lista** = intenção atual, sempre com texto exibível duplicado para render rápido/offline.
- **Evolução por eventos**: “Escaneou cupom” enriquece catálogo + atualiza perfil do usuário, sem quebrar listas existentes.
- **Segurança desde o dia 1**: Rules e funções server-side para validar escrita em catálogo universal e convites.

---

## 2. Organograma (time mínimo)
- **Produto/CEO**: prioriza funcionalidades.
- **Tech Lead/Arquiteto**: define padrões, revisa PRs.
- **Mobile (Flutter)**: 1–2 devs.
- **Backend (FastAPI/Functions)**: entra na Etapa 2 (cupons).
- **UX/UI (part-time)**: fluxos e consistência visual.
- **QA (part-time)**: smoke e regressão.

---

## 3. Arquitetura (C4 resumido)
- **Contexto**: Usuário ⇆ App Flutter ⇆ Firebase (Auth/Firestore/Storage) ⇆ (Futuro) FastAPI para cupons/relatórios.
- **Containers**:
  - Flutter App (Android/iOS/Web).
  - Firebase Auth + Firestore (realtime + offline).
  - Cloud Functions (convites, sanitização de produtos) – opcional no MVP.
  - FastAPI (Etapa 2) para parsing de NFC-e e jobs.
- **Componentes do App**:
  - App Shell (tema, rotas, DI).
  - Auth (login, onboarding curto).
  - Lists (CRUD de listas).
  - List Detail (itens, check, total estimado).
  - Sharing (convite/link/QR).
  - Settings (perfil, idioma/moeda).
  - Futuro: Receipts, Products, Insights, Pantry.

---

## 4. Modelo de Dados (Firestore)
### 4.1 Catálogo Universal (por país)
`products/{productKey}` — `productKey = ${country}_${barcode}`
- `country`, `barcode`, `gtinType`
- `displayTitle` (mostrado hoje)
- `titleVariants` (máx. 3) [{ title, sourceStoreId?, sourceCnpj?, firstSeenAt, lastSeenAt, count }]
- `brand?`, `categoryId?`, `ncm?`, `package?`, `images?`
- `dataQuality` (“LOW|MEDIUM|HIGH”), `createdAt`, `updatedAt`

### 4.2 Preferências do Usuário
`users/{uid}/productProfiles/{productKey}`
- `aliasTitle` (ex.: “LEITE”)
- `preferredQty`, `preferredUnit`
- `lastPrice?`, `priceTypical?` (média móvel simples)
- `lastPurchasedAt?`, `lastStoreId?`
- `notes?`, `updatedAt`

`users/{uid}/recentFreeItems/{hash}` (autocomplete do que ele digitou)

### 4.3 Listas e Itens (core)
`lists/{listId}`
- `title`, `ownerUid`
- `members` { uid: { role, joinedAt } }, `currency`, `budgetAmount?`
- `createdAt`, `updatedAt`, `archived`, `lastActivityAt`

`lists/{listId}/items/{itemId}`
- `kind`: `free` | `product` | `storeProduct` (quando não há barcode)
- `name` (texto exibido; sempre duplicado)
- `productKey?`, `storeProductKey?`
- `qty?`, `unit?`, `priceEstimate?`
- `category?`, `checked`, `checkedAt?`, `checkedBy?`
- `source`: `manual` | `barcode_scan` | `receipt_import`
- `createdAt`, `updatedAt`, `sortIndex`

### 4.4 Loja e produtos sem barcode (Etapa 2)
`stores/{storeId}` — `storeId = ${country}_${cnpj}` (BR) ou UUID
- `name`, `address`, `geo?`, `createdAt`

`storeProducts/{storeProductKey}` — `storeProductKey = ${country}_${storeId}_${storeSkuOrHash}`
- `storeId`, `storeSku?`
- `displayTitle`, `titleVariants` (máx. 3)
- `categoryGuess?`, `linkedProductKey?`, `createdAt`, `updatedAt`

### 4.5 Receipts (Etapa 2)
`users/{uid}/receipts/{receiptId}`
- `country`, `storeId/cnpj`, `storeName`
- `issuedAt`, `totalPaid`, `totalDiscount`, `paymentMethod`
- `createdAt`

`users/{uid}/receipts/{receiptId}/items/{rid}`
- `barcode?`, `description`, `qty`, `unitPrice`, `totalItem`
- `ncm?`, `storeSku?`, `categoryGuess?`

---

## 5. Regras de Negócio (chaves)
- **Título exibido**:
  - `free`: usa `item.name`.
  - `product`: prioriza `productProfiles.aliasTitle`; senão `item.name` (preenchido na criação) e, opcionalmente, `products.displayTitle` no detalhe.
- **Variações de título (máx. 3)**: novo título via cupom incrementa `count`; se passar de 3, substitui a variante mais fraca (menor `count` e mais antiga).
- **Preço/quantidade do usuário**: nunca no produto universal; ficam em `productProfiles` e/ou `receipts`.
- **Proteção de catálogo**: escrita em `/products` só via backend/Function para sanitizar texto e validar barcode.
- **Itens duplicam texto**: `item.name` sempre preenchido para render rápido/offline (sem “join”).

---

## 6. Fluxos e Possibilidades
- **Digitar “LEITE”**: cria item `free`, salva em `recentFreeItems` (autocomplete).
- **Escanear barcode (sem cupom)**: valida EAN; faz upsert mínimo em `products`; cria item `product` usando alias do usuário se existir.
- **Importar NFC-e**:
  - Para cada item com barcode: enriquece `products` (variantes, NCM, etc.) e atualiza `productProfiles` (preço, última compra).
  - Sem barcode: cria `storeProduct`, vincula ao receipt; futuro: permitir mapear para barcode real.
- **Família colaborando**: Firestore streams + cache; conflitos resolvidos por last write wins (aceitável no MVP).
- **Abuso/spam**: catálogo universal filtrado no backend; app só sugere.

---

## 7. Telas (mapa)
### Etapa 1 (MVP, obrigatórias)
- Splash → Login → Onboarding curto (nome, moeda, termos)
- Home (Minhas Listas) + criar/editar lista
- Detalhe da Lista (itens, check, total)
- Modal de item (nome, qty, unidade, preço estimado, categoria simples)
- Compartilhar lista (membros, gerar convite/QR)
- Configurações (perfil, idioma/moeda, sair)

### Etapa 2 (Pós-MVP)
- Importar cupom (QR + WebView + confirmação)
- Histórico de cupons + detalhe do cupom
- Detalhe de produto (universal) e perfil do produto (usuário)
- Histórico de preços (pessoal)

### Etapa 3 (Futuro/IA)
- Insights (gastos, variação de preços)
- Despensa e receitas
- Sugestões/“esqueceu” e previsão de recorrência
- Assinatura/premium e console admin

---

## 8. Roadmap e Entregáveis
### Etapa 1 — MVP (4–6 semanas)
Entregas:
- Auth + onboarding simples.
- CRUD de listas e itens (free + product).
- Compartilhamento (owner/editor/viewer) por convite/QR.
- Offline-first funcionando; total estimado e orçamento básico.
- Autocomplete (recentes + produtos do usuário).
DoD:
- Duas pessoas editam a mesma lista em tempo real.
- Sem internet: consegue adicionar/marcar e sincroniza depois.

### Etapa 2 — Cupom Fiscal (3–4 semanas)
Entregas:
- Importar NFC-e, armazenar receipts.
- Enriquecer catálogo (3 variações) e perfis do usuário (preço típico).
- Telas de histórico/detalhe de cupom; histórico de preço por item.
- Cloud Functions/Backend para sanitizar catálogo e processar QR.

### Etapa 3 — IA e Insights (4–6 semanas)
Entregas:
- Normalização inteligente de títulos (usa variantes).
- Sugestões “esqueceu” e previsão de recorrência.
- Insights de gastos/categoria, alertas de preço.
- Monetização (premium) e integrações.

---

## 9. Padrões de Implementação (disciplina de código)
- **Camadas**: presentation (UI/state) → domain (entities/usecases) → data (repositories/datasources).
- **Comentários do porquê**: cada arquivo chave inicia com propósito, uso e TODOs.
- **Funções pequenas**: manter legibilidade; sem regra de negócio em Widget.
- **Erros padronizados**: `Failure/Exception` no domínio; logs mínimos (info/warn/error).
- **Segurança**: roles (owner/editor/viewer); Rules validam `memberUids`; escrita em `/products` mediada pelo backend.

---

## 10. Checklist inicial para dev (Etapa 1)
1) Criar projeto Flutter + configurar Firebase (`flutterfire configure`).
2) Subir estrutura de pastas feature-first (UI/Domain/Data).
3) Implementar Auth (Google/Email) → Splash/Login/Onboarding.
4) CRUD de listas (stream) + CRUD de itens com `kind` (`free|product`).
5) Compartilhamento com invites e roles.
6) Total estimado e alerta de orçamento.
7) Testar offline: adicionar/check e sincronizar depois.
8) Registrar eventos básicos (Analytics) e Crashlytics ativo.

