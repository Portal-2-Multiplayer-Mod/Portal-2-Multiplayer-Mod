# The purpose of this http server is to allow a target for FastDL
# to use so netchan isn't called for listenservers.

import threading
from socketserver import ThreadingMixIn
from http.server import HTTPServer, SimpleHTTPRequestHandler
import Scripts.GlobalVariables as GVars
from Scripts.BasicLogger import Log

# Class to setup the HTTP Server to start in the users Portal 2 Path
class Handler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=GVars.configData["Portal2-Path"]["value"], **kwargs)

# Class to handle the HTTP Server itself and what it does when its finished running
class FastDLHTTPServer(ThreadingMixIn, HTTPServer):
    daemon_threads = True
    
    def serve_forever(self):
        while GVars.gameActive:
            self.handle_request()
        Log("FDLHTTP: Shutting down the FastDL HTTP server...")
        self.shutdown()
        self.server_close()
        Log("FDLHTTP: FastDL HTTP server has been shut down...")

# Called when Portal 2 is called to run, sets up the HTTP server on the set localip and port
def FastDLHTTPServerInit() -> None:
    localip = GVars.configData["FastDL-Server-IP"]["value"]
    port = int(GVars.configData["FastDL-Server-Port"]["value"])
    
    Log("FDLHTTP: Starting up the FastDL HTTP server for FastDL support!")
    server = FastDLHTTPServer((localip, port), Handler)
    Log(f"FDLHTTP: Created FastDL HTTP server on port: {port}")
    threading.Thread(None, server.serve_forever()).start()