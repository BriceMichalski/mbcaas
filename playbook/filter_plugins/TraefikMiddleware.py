class FilterModule(object):
    def filters(self):
        return {
            'traefik_middleware': self.format_middleware
        }

    def format_middleware(middlewarname):
        return "namespace-" + middlewarname + "@Kubernetescrd"

