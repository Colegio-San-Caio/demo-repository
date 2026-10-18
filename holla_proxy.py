import http.server
import socketserver

PORT = 8080
HANDLER = http.server.SimpleHTTPRequestHandler

print(f"📡 Launching proxy server locally on port {PORT}...")
print(f"🔗 Open http://127.0.0.1:{PORT} in your browser to view files.")

# Force bind strictly to localhost (127.0.0.1) for secure access
with socketserver.TCPServer(("127.0.0.1", PORT), HANDLER) as httpd:
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\n🛑 Proxy server stopped cleanly.")

