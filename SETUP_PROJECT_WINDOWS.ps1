# ShopMate - Script de Setup Completo (Windows PowerShell)
# Executa este script com: powershell -ExecutionPolicy Bypass -File SETUP_PROJECT_WINDOWS.ps1

$projectRoot = Get-Location
Write-Host "🚀 Iniciando setup completo do ShopMate em $projectRoot" -ForegroundColor Cyan

# Criar estrutura de pastas
Write-Host "\n📁 Criando estrutura de pastas..." -ForegroundColor Yellow

$folders = @(
    "lib/core/config",
    "lib/core/constants",
    "lib/core/di",
    "lib/core/errors",
    "lib/core/utils",
    "lib/data/datasources",
    "lib/data/models",
    "lib/data/repositories",
    "lib/domain/entities",
    "lib/domain/repositories",
    "lib/domain/usecases/auth",
    "lib/domain/usecases/lists",
    "lib/presentation/bloc/auth",
    "lib/presentation/bloc/lists_home",
    "lib/presentation/pages",
    "lib/presentation/widgets",
    "assets/images",
    "assets/icons",
    "assets/fonts"
)

foreach ($folder in $folders) {
    $path = Join-Path $projectRoot $folder
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Force -Path $path | Out-Null
        Write-Host "  ✓ Criada: $folder" -ForegroundColor Green
    }
}

Write-Host "\n✅ Setup de pastas concluído!" -ForegroundColor Green
Write-Host "\n📝 Próximo passo:" -ForegroundColor Cyan
Write-Host "  1. Copie os arquivos do GitHub" -ForegroundColor White
Write-Host "  2. Execute: flutter clean && flutter pub get" -ForegroundColor White
Write-Host "  3. Execute: flutter run -d chrome" -ForegroundColor White
Write-Host "\n🎉 Boa sorte!" -ForegroundColor Cyan
