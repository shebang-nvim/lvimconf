OS := $(shell uname | awk '{print tolower($$0)}')
MACHINE := $(shell uname -m)
CONFIG_HOME := $(HOME)/.config/
NVIM_HOME := $(HOME)/.local/bin
NVIM_EXEC ?= lvim
NVIM = $(NVIM_HOME)/$(NVIM_EXEC)

DEV_ROCKS = "luacheck 0.24.0"

default: help

.PHONY: help
help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

.PHONY: deps lint test docs dev-clean

ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

TAG := $(shell git describe --exact-match HEAD || true)

.PHONY: deps
deps: # install dependecies for testing and dev
	@for rock in $(DEV_ROCKS) ; do \
	  if luarocks list --porcelain $$rock | grep -q "installed" ; then \
	    echo $$rock already installed, skipping ; \
	  else \
	    echo $$rock not found, installing via luarocks... ; \
	  fi \
	done;


.PHONY: docs
docs: # generate documentation
	# FIXME: provide mini.doc manually when lazy.nvim is not loaded
	# nvim --headless --noplugin -u ./scripts/minimal_init.lua -c "lua vim.cmd[[Lazy load mini.doc]]; require'lvm.utils'.on_very_lazy(require'mini.doc'.generate())" -c "qa!"
	$(NVIM) --headless -c "lua vim.cmd[[Lazy load mini.doc]]; require'lvm.utils'.on_very_lazy(require'mini.doc'.generate())" -c "qa!"

.PHONY: lint
lint: # lint lua code
	@luacheck -q .
	@!(grep -R -E -I -n -w '#only|#o' spec && echo "#only or #o tag detected") >&2
	@!(grep -R -E -I -n -- '---\s+ONLY' t && echo "--- ONLY block detected") >&2


.PHONY: dev-clean
dev-clean: # delete plugins and temp data
	@echo "Removing old plugins and cache"
	rm -fr $(HOME)/.cache/lvim/luac
	rm -fr $(HOME)/.local/share/lunarvim/site
	rm -fr $(HOME)/.local/share/lunarvim/lazy
	rm -fr $(HOME)/.cache/lvim/luac
	rm -fr $(HOME)/.cache/lvim/lvim.log
	rm -f $(HOME)/.config/lvim/lazy-lock.json

