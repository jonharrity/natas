import sys
from select import select
rlist, _, _ = select([sys.stdin], [], [], 4)
words = ''
if rlist: 
    words = sys.stdin.read()
else:
    print('no input to letter.py')
    sys.exit()

opts = ''
for word in words.split('\n'):
    if len(word) == 0: continue
    if len(opts) == 0: 
        opts = ''.join(set(word))
    if len(opts) == 1: 
        print(opts)
        sys.exit()
    for c in opts:
        if not c in word:
   #         print('word=%s set=%s remove %s' % (word, opts, c))
            opts = opts.replace(c, '')
if set(opts) == set('qu'):
    print('q')#special case
    sys.exit()
print('found nothing')
sys.exit()

