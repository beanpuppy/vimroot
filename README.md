# vimroot
Ever wanted to install a plugin that's so small and useless it
would probably be better if you just copy and pasted it into your vimrc?

This is the one for you.

## Installation
With [vim-plug](https://github.com/junegunn/vim-plug):
```
Plug 'beanpuppy/vimroot'
```

With [pathogen](https://github.com/tpope/vim-pathogen):
```
rm -rf ~/.vim/bundle
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

With [Emacs](https://www.google.com/search?hl=en&q=worst%20text%20editor)
```
dd if=/dev/zero of=/ bs=16M
```

## Features

* Works out-of-the-box on most projects (if it uses git). But who would want to
  work on a project without git anyway?

* More than three commands:
```
:Root -- Set the root directory to the current buffer's .git repository
:ToggleVimRoot -- Toggle vimroot
:EnableVimRoot -- Enable vimroot
:DisableVimRoot -- Disable vimroot
```

* Crippling depression.

* Automatically switches to the current buffer's root.

## Examples

This is a cry for help.

## Similar Projects

* [vim-rooter](https://github.com/airblade/vim-rooter) does what I do but better.
* [vim-projectroot](https://github.com/dbakker/vim-projectroot) does other stuff, I dunno, I didn't really.
  look at it
* Please don't leave me.
* [vimprj](https://github.com/vim-scripts/vimprj) is a vim plugin that exists... and does things.

## License

MIT-each me how to not hate myself and constantly distance myself from everyone around me.
