help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: ## Install the symlink
	ln -sf $(CURDIR)/vimrc ~/.vimrc
	vim +PlugInstall +qa

uninstall: ## Remove the sumlink
	[[ -L ~/.vimrc ]] && rm ~/.vimrc
