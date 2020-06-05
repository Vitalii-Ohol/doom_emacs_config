;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! doom-snippets :disable t)
(package! lsp-python-ms :disable t)
(package! eshell :disable t)
(package! treemacs :disable t)
(package! lsp-ivy :disable t)
; (package! lsp-ui :disable t)

(package! benchmark-init)
(package! company-quickhelp)
(package! undo-tree)
(package! imenu-list)

(package! haskell-mode)
(package! hindent)
(package! company-ghci)
(package! ghci-completion)

;; For personal modeline
(package! anzu)
(package! evil-anzu)

;; flyckeck for back and python
(package! flycheck-pycheckers)
(package! flycheck-checkbashisms)
