import bottle
import os
import sys
from beaker.middleware import SessionMiddleware
import routes

session_opts = {
    'session.type': 'file',
    'session.cookie_expires': 100000,
    'session.data_dir': './data',
    'session.auto': True
}
app = SessionMiddleware(bottle.app(), session_opts)

if '--debug' in sys.argv[1:] or 'SERVER_DEBUG' in os.environ:
    # Debug mode will enable more verbose output in the console window.
    # It must be set at the beginning of the script.
    bottle.debug(True)

def wsgi_app():
    """Returns the application to make available through wfastcgi. This is used
    when the site is published to Microsoft Azure."""
    #return SessionMiddleware(bottle.default_app(), session_opts)
    return bottle.default_app()

if __name__ == '__main__':
    PROJECT_ROOT = os.path.abspath(os.path.dirname(__file__))
    STATIC_ROOT = os.path.join(PROJECT_ROOT, 'static').replace('\\', '/')
    HOST = os.environ.get('SERVER_HOST', 'localhost')
    try:
        PORT = int(os.environ.get('SERVER_PORT', '61616'))
    except ValueError:
        PORT = 61616

    @bottle.route('/static/<filepath:path>')
    def server_static(filepath):
        """Handler for static files, used with the development server.
        When running under a production server such as IIS or Apache,
        the server should be configured to serve the static files."""
        return bottle.static_file(filepath, root=STATIC_ROOT)

    # Starts a local server.
    bottle.run(server='paste', host=HOST, port=PORT, app=app)