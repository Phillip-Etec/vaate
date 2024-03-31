# vaate
Vim configuration with pathogen runtime management, **V**im as a text editor

# Installing submodules:
```
git submodule update --init --recursive
```
# Maintanence:

## Updating plugins:
```
git submodule foreach git pull
```

## Adding a plugin:
```
cd ./bundle && REMOTE="https://github.com/" git submodule add $REMOTE
```

## Removing a plugin should be done with git itself:
```
cd ./bundle && PLUGIN='vim-weedeater' git rm -f $PLUGIN
```
