from http.server import HTTPServer, BaseHTTPRequestHandler
import sqlite3,json,os
DB="MOSFETQexchange/output/telemetry.db"
class H(BaseHTTPRequestHandler):
 def do_POST(self):
  os.makedirs(os.path.dirname(DB),exist_ok=True)
  con=sqlite3.connect(DB); c=con.cursor()
  c.execute("CREATE TABLE IF NOT EXISTS oeneye_view_counter (id INTEGER PRIMARY KEY CHECK(id=1), total_views INTEGER DEFAULT 0)")
  c.execute("INSERT INTO oeneye_view_counter VALUES (1,0) ON CONFLICT(id) DO NOTHING")
  c.execute("UPDATE oeneye_view_counter SET total_views=total_views+1 WHERE id=1")
  c.execute("SELECT total_views FROM oeneye_view_counter WHERE id=1"); v=c.fetchone()[0]
  con.commit(); con.close()
  open("view_count.json","w").write(json.dumps({"total_views":v}))
  self.send_response(200); self.send_header('Content-type','application/json'); self.send_header('Access-Control-Allow-Origin','*'); self.end_headers()
  self.wfile.write(json.dumps({"total_views":v,"proxy":"by.NET"}).encode())
 def do_GET(self):
  self.send_response(200); self.send_header('Access-Control-Allow-Origin','*'); self.end_headers()
  self.wfile.write(b"proxy.NET ready")
 def log_message(self,*a): pass
print("PROXY.NET by proxy on :5005")
HTTPServer(("0.0.0.0",5005),H).serve_forever()
