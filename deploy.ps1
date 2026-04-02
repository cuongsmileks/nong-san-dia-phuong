# ==============================================
# DEPLOY SCRIPT - Nong San Dia Phuong Website
# Push len GitHub va Deploy len Vercel
# ==============================================

$PROJECT_DIR = $PSScriptRoot
$TIMESTAMP = Get-Date -Format "yyyy-MM-dd HH:mm"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  DEPLOY: Nong San Dia Phuong" -ForegroundColor Cyan
Write-Host "  $TIMESTAMP" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# --- Kiem tra Git ---
Write-Host "[1/4] Kiem tra Git..." -ForegroundColor Yellow
try {
    $gitVersion = git --version 2>&1
    Write-Host "  Git OK: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "  LOI: Git chua duoc cai dat!" -ForegroundColor Red
    Write-Host "  Tai Git tai: https://git-scm.com/downloads" -ForegroundColor Red
    exit 1
}

# --- Kiem tra va init repo ---
Write-Host ""
Write-Host "[2/4] Kiem tra Git repo..." -ForegroundColor Yellow
Set-Location $PROJECT_DIR

$isRepo = git rev-parse --is-inside-work-tree 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "  Khoi tao Git repo moi..." -ForegroundColor Yellow
    git init
    git branch -M main
    Write-Host "  Git repo da tao!" -ForegroundColor Green
    
    $remoteUrl = Read-Host "  Nhap GitHub repo URL (VD: https://github.com/user/repo.git)"
    git remote add origin $remoteUrl
} else {
    $remote = git remote -v 2>&1
    if ($remote -eq "") {
        $remoteUrl = Read-Host "  Nhap GitHub repo URL (VD: https://github.com/user/repo.git)"
        git remote add origin $remoteUrl
    } else {
        Write-Host "  Git repo OK" -ForegroundColor Green
    }
}

# --- Push len GitHub ---
Write-Host ""
Write-Host "[3/4] Push len GitHub..." -ForegroundColor Yellow

$commitMsg = Read-Host "  Noi dung commit (Enter de dung mac dinh: 'update: $TIMESTAMP')"
if ($commitMsg -eq "") {
    $commitMsg = "update: $TIMESTAMP"
}

git add .
git commit -m $commitMsg

$pushResult = git push -u origin main 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "  Thu push voi --force..." -ForegroundColor Yellow
    git push --set-upstream origin main
}

if ($LASTEXITCODE -eq 0) {
    Write-Host "  GitHub: Push thanh cong!" -ForegroundColor Green
} else {
    Write-Host "  CANH BAO: Push GitHub that bai. Tiep tuc deploy Vercel..." -ForegroundColor Yellow
}

# --- Deploy len Vercel ---
Write-Host ""
Write-Host "[4/4] Deploy len Vercel..." -ForegroundColor Yellow

$vercelResult = vercel --prod --yes 2>&1
Write-Host $vercelResult

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  HOAN THANH! Website da deploy!" -ForegroundColor Green
    Write-Host "  URL: https://nong-san-dia-phuong.vercel.app" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "  LOI: Deploy Vercel that bai!" -ForegroundColor Red
    Write-Host "  Kiem tra: vercel --prod --yes" -ForegroundColor Red
}

Write-Host ""
