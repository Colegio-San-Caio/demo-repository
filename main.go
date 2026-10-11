go mod tidy
mkdir -p releases
GOOS=windows GOARCH=amd64 go build -o releases/fieldberry-v14-exe-133.exe main.go
git add main.go go.mod releases/*.exe
git commit -m "main.go final go host plan 14948"
git push
gh release create v14-exe-133 releases/fieldberry-v14-exe-133.exe --title "v14-exe-133" --notes "Plan 14948 Go Host" --clobber 2>/dev/null || gh release create v14-exe-133 releases/fieldberry-v14-exe-133.exe --title "v14-exe-133"
go run main.go
