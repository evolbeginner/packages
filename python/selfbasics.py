def isNumeric(val):
    import math
    try:
        float(val);
    except(ValueError): 
        return(False);
    else:
        return(True)


def make_dir_force(dir, is_force=False, is_tolerate=False):
    import os
    class MyError( Exception ): pass
    if os.path.exists(dir):
        if not is_tolerate:
            if is_force:
                os.system("rm -rf " + dir + " 2>/dev/null")
                os.system("mkdir -p " + dir)
            else:
                raise MyError('dir ' + dir + ' has already existed!')
        else:
            pass
    else:
        os.system("mkdir -p " + dir)


def byLineReader(filename):
    f = open(filename)
    line = f.readline()
    while line :
        yield line
        line = f.readline()
    f.close()
    yield None


def get_self_methods(object):
    methods = [method for method in dir(object) if callable(getattr(object, method))]
    return(methods)


