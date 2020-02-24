.PHONY: all install app dotfiles clean help

all: clean install ## clean previous setup and install this

install: app dotfiles ## install apps and configs

app: ## install emacs-nox and doom-emacs
	sudo apt install emacs-nox ripgrep git -y
	@if [ ! -d $$HOME/.emacs.d ]; then \
		git clone https://github.com/hlissner/doom-emacs $$HOME/.emacs.d; \
		$$HOME/.emacs.d/bin/doom install; \
	fi

dotfiles: ## install config files
	@echo "HOME:  $(HOME)";
	@echo "PWD    $(PWD)";
	# === DOTFILES-DIRS ===
	@for dir in $(shell find $(PWD) -type d \
			| egrep -v "(useful|.git)" \
			| sed s:"$(PWD)/":: | sed 1d); do \
		mkdir -p $(HOME)/$$dir; \
	done;
	# === DOTFILES-FILES ===
	@for file in $(shell find $(PWD) -type f \
			| egrep -v "(.git|Makefile|README.md|LICENSE)" \
			| sed s:"$(PWD)/"::); do \
		ln -sf $(PWD)/$$file $(HOME)/$$file; \
	done;
	$$HOME/.emacs.d/bin/doom refresh
	$$HOME/.emacs.d/bin/doom purge -g


clean: ## clean this config
	@if [ -d $$HOME/.emacs.d ]; then \
		rm -rf $$HOME/.emacs.d; \
	fi
	@if [ -d $$HOME/.doom.d ]; then \
		rm -rf $$HOME/.doom.d; \
	fi
	# sudo apt purge emacs emacs-gtk emacs-nox -y

help: ## this help window
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
