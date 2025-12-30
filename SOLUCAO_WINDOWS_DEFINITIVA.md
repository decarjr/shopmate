SOLUCAO_WINDOWS_DEFINITIVA.md# SOLUCAO DEFINITIVA - WINDOWS

## PROBLEMA RAIZ

Voce tem DOIS problemas principais:

1. **pubspec.yaml ainda refencia assets/fonts que nao existem**
2. **Windows nao aceita comando mkdir com -p**
3. **Falta lib/app.dart ou referencia errada no build_runner**

## SOLUCAO - 5 MINUTOS

### PASSO 1: Abra o arquivo pubspec.yaml e REMOVA COMPLETAMENTE essa linha

**PROCURE POR ISSO** no seu `pubspec.yaml`:
```yaml
fonts:
  - family: GoogleSans
    fonts:
      - asset: assets/fonts/GoogleSans-Regular.ttf
      - asset: assets/fonts/GoogleSans-Bold.ttf
```

**DELETE TUDO** de `fonts:` até a proxima seção (`flutter:`, `dev_dependencies`, etc)

### PASSO 2: Crie as pastas MANUALMENTE no Windows

Abra o Explorador de Arquivos (Windows Explorer):
1. Vá para: `C:\projetos\shopmate\assets\`
2. CRIE 3 pastas:
   - `images`
   - `icons`
   - `fonts`

OU no PowerShell (NÃO cmd normal):
```powershell
cd C:\projetos\shopmate
New-Item -ItemType Directory -Force -Path "assets\images"
New-Item -ItemType Directory -Force -Path "assets\icons"
New-Item -ItemType Directory -Force -Path "assets\fonts"
```

### PASSO 3: Verifique o pubspec.yaml

Sua seção `flutter:` deve ser EXATAMENTE assim:

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/icons/
```

SEM fonts, SEM google-sans, SEM nada mais!

### PASSO 4: Limpe e rode novamente

```powershell
cd C:\projetos\shopmate
flutter clean
flutter pub get
flutter run -d chrome
```

---

## SE AINDA DER ERRO de lib/app.dart

Isso significa que seu antigo pubspec.yaml ou lib/ tem arquivos antigos.

**SOLUCAO**:

1. Delete a pasta `lib/` inteira:
```powershell
Remove-Item -Recurse -Force lib
```

2. Execute:
```powershell
flutter create .
```

3. Rodeo:
```powershell
flutter run -d chrome
```

---

## COMANDOS WINDOWS CORRETOS

| O que fazer | Bash/Mac/Linux | Windows PowerShell | Windows CMD |
|---|---|---|---|
| Criar pastas | `mkdir -p a/b/c` | `New-Item -ItemType Directory -Force -Path "a\\b\\c"` | `mkdir a\\b\\c` |
| Delete pasta | `rm -rf pasta` | `Remove-Item -Recurse -Force pasta` | `rmdir /s /q pasta` |
| Listar | `ls` | `Get-ChildItem` ou `ls` | `dir` |

---

## RESUMO DO QUE VOCE PRECISA FAZER AGORA

```
1. EDITAR pubspec.yaml - REMOVER fonts
2. CRIAR 3 PASTAS em assets/ (images, icons, fonts)
3. flutter clean
4. flutter pub get
5. flutter run -d chrome
```

**Depois disso, DEVE FUNCIONAR!**
