# -*- coding: utf-8 -*-
from kubernetes_py import K8sConfig
from powerline.theme import requires_filesystem_watcher
from os.path import expanduser

watcher = None
context = ''
namespace = ''


@requires_filesystem_watcher
def kubernetes(pl, create_watcher):
    global watcher, context, namespace
    if watcher is None:
        watcher = create_watcher()
        config = K8sConfig()
        context = config.current_context
        namespace = config.namespace
    elif watcher("{0}/.kube/config".format(expanduser("~"))):
        config = K8sConfig()
        context = config.current_context
        namespace = config.namespace

    return [{
        'contents': '{}/{}'.format(context, namespace),
        'highlight_groups': ['kubernetes']
    }]
