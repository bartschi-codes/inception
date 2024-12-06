import http.server
import os

# request handler thanks gpt
class RequestHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        # Always serve the index.html file
        self.path = '/index.html'
        return super().do_GET()

#specify directory of index.html
os.chdir('/var/www/html')

# run server
http.server.test(HandlerClass=RequestHandler, port=3000)

