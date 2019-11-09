import sys, os

if __name__ == '__main__':

  arg_names = ['script', 'file']
  args = dict(zip(arg_names, sys.argv))

  if len(args) > 1:
    if os.path.isfile(args['file']):
      with open(args['file'], 'r') as f:
        pass
