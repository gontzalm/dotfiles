c.TerminalInteractiveShell.editing_mode = "vi"
c.TerminalInteractiveShell.autoindent = False
c.TerminalInteractiveShell.colors = "Linux"
c.TerminalInteractiveShell.emacs_bindings_in_vi_insert_mode = False
c.InteractiveShellApp.extensions = ["autoreload", "rich"]
c.InteractiveShellApp.exec_lines = [
    "%autoreload 2",
    "from rich import traceback; __tb = traceback.install(show_locals=True);",
]
