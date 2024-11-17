# vaate
Vim configuration with pathogen runtime management, **V**im **a**s **a** **t**ext **e**ditor

# Installing submodules:
```sh
(cd ~/.vim && git submodule update --init --recursive)
```
# Maintanence:

## Updating plugins:
```sh
(cd ~/.vim && git submodule update --recursive --remote)
```

## Adding a plugin:
```sh
(cd ~/.vim/bundle && REMOTE="https://github.com/weedeater/vim" && git submodule add $REMOTE)
```

## Adding an extra plugin:
```sh
(cd ~/.vim/extra && REMOTE="https://github.com/weedeater/vim" && git submodule add $REMOTE)
```

## Removing a plugin should be done with git itself:
```sh
(cd ~/.vim/bundle && PLUGIN='vim-weedeater' && git rm -f $PLUGIN)
```
## Plugin modifications:
Make a diff file from submodules' changes:
```sh
git --no-pager diff --no-color --submodule=diff > patch.diff
```
then apply it:
```sh
patch -p1 < patch.diff || git apply patch.diff
```
