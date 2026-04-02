---
description: Tự động push code lên GitHub và deploy lên Vercel
---

# Deploy lên GitHub và Vercel

Workflow này tự động hóa quá trình đẩy code lên GitHub và deploy lên Vercel production.

**Project directory:** `c:\Users\Admin\.gemini\antigravity\scratch\nong-san-dia-phuong`

## Bước 1: Kiểm tra Git đã cài chưa

// turbo
1. Chạy lệnh kiểm tra git:
```powershell
git --version
```

Nếu git chưa được cài, thông báo cho user cài Git tại https://git-scm.com/downloads và dừng workflow.

## Bước 2: Kiểm tra và khởi tạo Git repo

// turbo
2. Kiểm tra git repo:
```powershell
git -C "c:\Users\Admin\.gemini\antigravity\scratch\nong-san-dia-phuong" rev-parse --is-inside-work-tree
```

Nếu git chưa được init, chạy:
```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
git -C "c:\Users\Admin\.gemini\antigravity\scratch\nong-san-dia-phuong" init
git -C "c:\Users\Admin\.gemini\antigravity\scratch\nong-san-dia-phuong" branch -M main
```

## Bước 3: Kiểm tra remote GitHub

// turbo
3. Kiểm tra remote đã có chưa:
```powershell
git -C "c:\Users\Admin\.gemini\antigravity\scratch\nong-san-dia-phuong" remote -v
```

Nếu chưa có remote origin, hỏi user GitHub repo URL rồi chạy:
```powershell
git -C "c:\Users\Admin\.gemini\antigravity\scratch\nong-san-dia-phuong" remote add origin <GITHUB_REPO_URL>
```

## Bước 4: Stage, Commit, Push lên GitHub

// turbo
4. Tạo commit message từ nội dung thay đổi hoặc dùng mặc định, rồi push:
```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
cd "c:\Users\Admin\.gemini\antigravity\scratch\nong-san-dia-phuong"
git add .
git commit -m "chore: update website - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git push -u origin main
```

Nếu push thất bại do branch chưa tồn tại, thêm `--set-upstream origin main`.

## Bước 5: Deploy lên Vercel Production

// turbo
5. Deploy lên Vercel:
```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
cd "c:\Users\Admin\.gemini\antigravity\scratch\nong-san-dia-phuong"
vercel --prod --yes
```

## Bước 6: Thông báo kết quả

6. Sau khi deploy thành công, thông báo cho user:
- URL production trên Vercel
- Commit đã push lên GitHub
- Thời gian deploy
