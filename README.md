# vaate
Vim configuration with pathogen runtime management, **V**im **a**s **a** **t**ext **e**ditor

# Installing submodules:
```
(cd ~/.vim && git submodule update --init --recursive)
```
# Maintanence:

## Updating plugins:
```
(cd ~/.vim && git submodule update --recursive --remote)
```

## Adding a plugin:
```
(cd ~/.vim/bundle && REMOTE="https://github.com/weedeater/vim" && git submodule add $REMOTE)
```

## Adding an extra plugin:
```
(cd ~/.vim/extra && REMOTE="https://github.com/weedeater/vim" && git submodule add $REMOTE)
```

## Removing a plugin should be done with git itself:
```
(cd ~/.vim/bundle && PLUGIN='vim-weedeater' && git rm -f $PLUGIN)
```
