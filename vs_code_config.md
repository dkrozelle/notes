
# background

- These instructions are intended to configure an interactive R environment.

# install packages and vscode extensions

- [general config recommendations](https://github.com/REditorSupport/vscode-R/wiki/Installation:-Linux)
- radian is highly recommended as the R terminal for interactive use
- Extension for vscode: R extension, R debugger, 
- only install one R-coding extension, otherwise they cause conflicting terminal settings


# configure remote paths

These components are shared for all workspaces on this server. Open the visual setting editor with cmd+, however I prefer to edit the settings.json directly which can toggled from the ui. 


{
  <!-- R path for interactive terminals (Linux). Can also be radian etc. -->
  "r.rterm.linux": "/home/danr/.local/bin/radian",

  <!-- Path to an R executable to launch R background processes (Linux). Must be "vanilla" R, not radian etc.! -->
  "r.rpath.linux": "/usr/local/bin/R"

  <!-- Use bracketed paste mode when sending code to terminal, enable with radian -->
  "r.bracketedPaste": true
}


{
  "r.rpath.linux": "/DATA/DAPPS/R/3.5.0/bin/R",
  "r.terminalPath": "/home/drozelle/.local/bin/radian",
  "r.interpreterPath": "/DATA/DAPPS/R/3.5.0/bin/R",
  "r.bracketedPaste": true,
  "r.rterm.linux": "/home/drozelle/.local/bin/radian"
}

# python code formatting and linting

- install black and pylint locally 
- 