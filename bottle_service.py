# bottle-server.py
import win32serviceutil
import win32service
import servicemanager

# Bottle insists on stdout and stderr being there.  We'll placate him.
import sys
if sys.stdout == None:
    sys.stdout = open(r'c:\inetpub\stdout.log', 'a')
if sys.stderr == None:
    sys.stderr = open(r'c:\inetpub\stderr.log', 'a')

# resume imports
import bottle
from paste import httpserver
import citer

class PasteServer(bottle.ServerAdapter):
    def run(self, handler):
        # Send parameter start_loop=false so we can put the paste server in a
        # variable for later stopping.
        self.paste = httpserver.serve(handler, host=self.host, port=str(self.port), start_loop=False)
        self.paste.serve_forever()

    def stop(self):
        self.paste.server_close()


class AppServerSvc(win32serviceutil.ServiceFramework):
    _svc_name_ = "Citer-Bottle-Service"
    _svc_display_name_ = "Citer Services"
    _svc_description_ = "Services citer application requests."

    def __init__(self, args):
        win32serviceutil.ServiceFramework.__init__(self, args)
        self.server = PasteServer(host='0.0.0.0', port=8090)

    def SvcStop(self):
        self.ReportServiceStatus(win32service.SERVICE_STOP_PENDING)
        self.server.stop()

    def SvcDoRun(self):
        servicemanager.LogMsg(servicemanager.EVENTLOG_INFORMATION_TYPE,
                              servicemanager.PYS_SERVICE_STARTED,
                              (self._svc_name_, ''))
        self.main()

    def main(self):
        citer.app.run(server=self.server)

if __name__ == '__main__':
    win32serviceutil.HandleCommandLine(AppServerSvc)