import logging
import re

from odoo import http


class CustomFilter(logging.Filter):
    def filter(self, record):
        return re.search('(GET|HEAD) /(livez|readyz|startupz)', record.getMessage()) is None


class KubeHealthCheck(http.Controller):
    @http.route('/livez', auth='none', methods=['GET', 'HEAD'])
    def live(self):
        return "OK"

    @http.route('/readyz', auth='none', methods=['GET', 'HEAD'])
    def ready(self):
        return "OK"

    @http.route('/startupz', auth='none', methods=['GET', 'HEAD'])
    def startup(self):
        return "OK"
    

logger = logging.getLogger("werkzeug")
logger.addFilter(CustomFilter())
