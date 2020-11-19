"""Simple webserver which enable / disable the monitor"""
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import urlparse
import cec

PORT = 8080

class Handler(BaseHTTPRequestHandler):
    ON_PATH = "/on"
    OFF_PATH = "/off"

    cec.init()
    monitor = cec.list_devices()[0]
    print monitor

    def do_GET(self):
        paths = {self.ON_PATH: self._on,
                 self.OFF_PATH: self._off}
        handler_path = paths.get(urlparse(self.path).path, self._error_path)
        handler_path()

    def _error_path(self):
        self.send_response(404)
        self.end_headers()

    def _on(self):
        monitor.power_on()
        self.send_response(204)
        self.end_headers()

    def _off(self):
        monitor.standby()
        self.send_response(204)
        self.end_headers()



if __name__ == '__main__':
    httpd = HTTPServer(('', PORT), Handler)
    httpd.serve_forever()
