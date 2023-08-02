from datetime import datetime
import locale

locale.setlocale(locale.LC_TIME, 'ja_JP.UTF-8')

def time(pl, format='%Y-%m-%d'):
    return [{
        'contents': datetime.now().strftime(format),
        'highlight_groups': ['date']
    }]
