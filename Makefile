all: sync

sync:
	ln -snf $(PWD)/vimrc ~/.config/nvim/init.vim
	ln -snf $(PWD)/coc-settings.json ~/.config/nvim/coc-settings.json
	ln -snf $(PWD)/zshrc ~/.zshrc
	ln -snf $(PWD)/tmux.conf ~/.tmux.conf

	# ln -snf $(PWD)/alacritty.yml ~/.config/alacritty/alacritty.yml
	# ln -snf $(PWD)/p10k.zsh ~/.p10k.zsh
	# ln -snf $(PWD)/init.lua ~/.hammerspoon/init.lua
	# ln -snf $(PWD)/karabiner.json ~/.config/karabiner/karabiner.json

clean:
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.config/nvim/coc-settings.json
	rm -f ~/.config/alacritty/alacritty.yml
	rm -f ~/.zshrc
	rm -f ~/.tmux.conf
	rm -f ~/.p10k.zsh

.PHONY: all clean sync build run kill
