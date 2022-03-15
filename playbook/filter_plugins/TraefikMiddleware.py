def to_traefik_middleware(mdwname):

    if mdwname:
        return "kube-core-" + mdwname + "@kubernetescrd"

    return ""


class FilterModule(object):
    def filters(self):
        return {
            'to_traefik_middleware': to_traefik_middleware
        }
