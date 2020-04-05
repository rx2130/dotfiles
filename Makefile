all: sync

sync:
	mkdir -p ~/.config/alacritty
	mkdir -p ~/.config/nvim

	[ -f ~/.config/nvim/init.vim ] || ln -s $(PWD)/.vimrc ~/.config/nvim/init.vim
	[ -f ~/.config/nvim/coc-settings.json ] || ln -s $(PWD)/coc-settings.json ~/.config/nvim/coc-settings.json
	[ -f ~/.config/alacritty/alacritty.yml ] || ln -s $(PWD)/alacritty.yml ~/.config/alacritty/alacritty.yml
	[ -f ~/.zshrc ] || ln -s $(PWD)/.zshrc ~/.zshrc
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/.tmux.conf ~/.tmux.conf

clean:
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.config/nvim/coc-settings.json
	rm -f ~/.config/alacritty/alacritty.yml
	rm -f ~/.zshrc
	rm -f ~/.tmux.conf

.PHONY: all clean sync build run kill
