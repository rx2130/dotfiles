all: sync

sync:
	mkdir -p ~/.config/alacritty
	mkdir -p ~/.config/nvim

	ln -snf $(PWD)/vimrc ~/.config/nvim/init.vim
	ln -snf $(PWD)/coc-settings.json ~/.config/nvim/coc-settings.json
	ln -snf $(PWD)/alacritty.yml ~/.config/alacritty/alacritty.yml
	ln -snf $(PWD)/zshrc ~/.zshrc
	ln -snf $(PWD)/tmux.conf ~/.tmux.conf
	ln -snf $(PWD)/p10k.zsh ~/.p10k.zsh

clean:
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.config/nvim/coc-settings.json
	rm -f ~/.config/alacritty/alacritty.yml
	rm -f ~/.zshrc
	rm -f ~/.tmux.conf
	rm -f ~/.p10k.zsh

.PHONY: all clean sync build run kill
