dotfiles
========

- dotfiles and personal scripts

Notes
--
- .vimrc:
- Require Vim 7.3 or higher.
- For gVim on Windows. Though I'm using it fine with gVim and [Cygwin](http://www.cygwin.com/).
- Please keep in mind that:  
  let Vim source others' scripts this way sure has **SECURITY CONCERN**.

Usage
--
1. Clone this repository to your _/tmp_ path.

	`git clone git://github.com/qiwei/dotfiles.git /tmp/dotfiles`

2. Update submodule (will install NeoBundle):

	```
	cd /tmp/dotfiles
	git submodule init
	git submodule update
	```

3. Start Vim with my vimrc.

	`vim -u /tmp/dotfiles/.vimrc`

4. There would be errors during first run. Install plugins can fix them:  
	Launch `vim` and run `:NeoBundleInstall`

