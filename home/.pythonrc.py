try:
    import readline
    import rlcompleter

    class irlcompleter(rlcompleter.Completer):

        """Indentable rlcompleter

        Extend standard rlcompleter module to let tab key can indent
        and also completing valid Python identifiers and keywords."""
        def complete(self, text, state):
            if text == "":
                readline.insert_text('\t')
                return None
            else:
                return rlcompleter.Completer.complete(self,text,state)

    #you could change this line to bind another key instead tab.
    readline.parse_and_bind("tab: complete")
    readline.set_completer(irlcompleter().complete)

    import os

    histfile = os.path.join(os.environ["HOME"], ".python_history")

    try:
        readline.read_history_file(histfile)
    except IOError:
        pass

    import atexit

    atexit.register(readline.write_history_file, histfile)

    del os, histfile

except ImportError:
    pass
    
