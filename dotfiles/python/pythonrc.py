def __tab_complete():
    """Enable tab completion."""
    import rlcompleter, readline
    readline.parse_and_bind('tab:complete')
__tab_complete()

def __history():
    """Save history"""
    import atexit, os.path, readline
    history_path = os.path.expanduser('~/.pyhistory')
    if os.path.isfile(history_path):
       readline.read_history_file(history_path)
    atexit.register(lambda x=history_path: readline.write_history_file(x))
__history()
