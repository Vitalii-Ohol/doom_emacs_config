;;; package --- Summary
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(setq user-full-name "Vitalii Ohol"
      user-mail-address "ohol.vitaliy@gmail.com")

(setq use-package-verbose t
      use-package-compute-statistics t)

(after! evil-escape
   (setq evil-escape-key-sequence "jk"))

;; benchmark
(use-package benchmark-init
  :config
    ;; To disable collection of benchmark data after init is done.
    (add-hook 'after-init-hook 'benchmark-init/deactivate))

;; theme config
(use-package doom-themes
  ;;:after (treemacs flycheck)
  :config
    ;; Treat all themes as safe
    (setq custom-safe-themes t)

    (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
          doom-themes-enable-italic t) ; if nil, italics is universally disabled
    (load-theme 'doom-molokai t)

    ;; Enable flashing mode-line on errors
    (doom-themes-visual-bell-config)

    (doom-themes-org-config)

    (set-face-background 'hl-line "gray13")

    ;; Enable custom treemacs theme
    ;;(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
    ;;(doom-themes-treemacs-config)

    ;; Color the border of windows according to the `highlight' color of the doom's theme
    (add-hook! 'doom-load-theme-hook
      ;; A more visible window border
      (set-face-attribute 'vertical-border nil :foreground (doom-color 'highlight))
      ;; Flycheck errors use the color of functions
      (set-face-attribute 'flycheck-error nil
        :underline `(:color ,(doom-color 'functions)
        :style wave))))

;; Modeline config
(use-package doom-modeline
  :config
    (setq
        doom-modeline-icon t
        doom-modeline-major-mode-icon nil
        doom-modeline-major-mode-color-icon nil
        doom-modeline-github t
        doom-modeline-minor-modes nil
        doom-modeline-enable-word-count t
        doom-modeline-checker-simple-format t
        doom-modeline-persp-name t
        doom-modeline-lsp t
        doom-modeline-mode t
        doom-modeline-indent-info t
        ; doom-modeline-unicode-fallback t
        doom-modeline-buffer-encoding t
        doom-modeline-python-executable "python3"
        doom-modeline-env-version t))

;; Setting the indent guides to show a specific character
(use-package highlight-indent-guides
    :hook (prog-mode . highlight-indent-guides-mode)
    :config
      (setq highlight-indent-guides-method 'character
          highlight-indent-guides-character ?\┆
          highlight-indent-guides-delay 0.01
          highlight-indent-guides-responsive 'top
          highlight-indent-guides-auto-enabled nil)
    )

(use-package evil-surround
  :config
    (global-evil-surround-mode 1)
    (push '(?< . ("< " . " >")) evil-surround-pairs-alist))

(use-package evil-nerd-commenter
  :config
    (defun comment-or-uncomment-region-or-line ()
      "Comments or uncomments the region or the current line if there's no active region."
      (interactive)
      (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))
    (map! :leader
          :g "/" 'comment-or-uncomment-region-or-line))

;;which-key integration
(use-package which-key
  :config (which-key-mode))

;; rescan rags for treemacs
(use-package imenu
  :config
    (setq imenu-create-index-function 'semantic-create-imenu-index-1)
    (setq imenu-auto-rescan t))

;; Select the IList buffer when it is shown
(use-package imenu-list
  :after imenu
  :config
    (set-popup-rule! "^\\*Ilist"
        :side 'right
        :size 35
        :quit nil
        :select t
        :ttl 0))

;; ibuffer
(use-package ibuffer
  :config
    ;; nearly all of this is the default layout
    (setq ibuffer-formats
      '((mark modified read-only " "
              (name 50 50 :left :elide) ; changed
              " "
              (size 9 -1 :right)
              " "
              (mode 16 16 :left :elide)
              " " filename-and-process)
        (mark " "
              (name 16 -1)
              " " filename))))

;; isearch
(use-package isearch
  :config
    ;; Scrolling commands do not cancel isearch
    (setq isearch-allow-scroll t))

(use-package iedit
  :config
    (map!
        :leader
        (:prefix ("r" . "Remove/Replace")
          :desc "iedit" "i" 'iedit-mode
        ))
    (map!
       :map iedit-mode-keymap
       :g "C-c C-c" 'iedit-toggle-selection)
    ;; (define-key iedit-mode-keymap (kbd "C-c C-c") 'iedit-toggle-selection))
    )

;; smartparens
(after! smartparens
  (map! :leader
      (:prefix ("i" . "Insert")
        :desc "Wrap round" "(" 'sp-wrap-round
        :desc "Wrap round" ")" 'sp-wrap-round
        :desc "Wrap curly" "{" 'sp-wrap-curly
        :desc "Wrap curly" "}" 'sp-wrap-curly
        :desc "Wrap square" "[" 'sp-wrap-square
        :desc "Wrap square" "]" 'sp-wrap-square
      ))
  (map! :leader
      (:prefix ("r" . "Remove/Replace")
        :desc "Wrap" "w" 'sp-unwrap-sexp
        :desc "Rewrap" "r" 'sp-rewrap-sexp
      ))
  (sp-use-paredit-bindings)
  (setq sp-escape-quotes-after-insert t)
  (defun my-create-newline-and-enter-sexp (&rest _ignored)
    "Open a new brace or bracket expression, with relevant newlines and indent. "
    (newline)
    (indent-according-to-mode)
    (forward-line -1)
    (indent-according-to-mode))
  (setq sp-escape-quotes-after-insert nil)
  (sp-local-pair 'c++-mode "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))
  (sp-local-pair 'c-mode "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))
  (sp-local-pair 'java-mode "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))
  (sp-local-pair 'web-mode "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))
  (sp-local-pair 'typescript-mode "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))
  (sp-local-pair 'js-mode "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET"))))

;; Larger undo tree window
(use-package undo-tree
  :init (global-undo-tree-mode)
  :config
    (set-popup-rule! " \\*undo-tree\\*"
        :slot 2
        :side 'left
        :size 30
        :modeline nil
        :select t
        :quit t)
  :commands (undo-tree-visualize))

;; completion ivy
(use-package ivy
  :config
    (add-to-list 'ivy-re-builders-alist '(counsel-projectile-find-file . ivy--regex-fuzzy))
    (add-to-list 'ivy-re-builders-alist '(t . ivy--regex-fuzzy))

    (setq ivy-initial-inputs-alist
          '((counsel-minor . "")
            (counsel-package . "")
            (counsel-org-capture . "")
            (counsel-M-x . "")
            (counsel-describe-function . "")
            (counsel-describe-variable . "")))
    ;; Add a kill action to Ivy's buffer switching
    (ivy-set-actions 'ivy-switch-buffer '(("k" kill-buffer "kill")))
    ;; Add a kill action to DOOM's buffer switching
    (ivy-set-actions '+ivy/switch-workspace-buffer '(("k" kill-buffer "kill"))))

;; Projectile
(use-package projectile
  :config
    (setq projectile-require-project-root t)
    (setq projectile-create-missing-test-files t)
    (projectile-mode)
    (projectile-load-known-projects))

;; Yasnippet
(use-package yasnippet
  :config
    (setq yas-snippet-dirs
        '("~/.doom.d/snippets"                 ;; personal snippets
    ))
;;;    ;; Remove Yasnippet's default tab key binding
;;;    (define-key yas-minor-mode-map (kbd "<tab>") nil)
;;;    (define-key yas-minor-mode-map (kbd "TAB") nil)
;;;    ;; Alternatively use Control-c + tab
;;;    (define-key yas-minor-mode-map (kbd "\C-c TAB") 'yas-expand)
    (set-face-background 'secondary-selection "gray")
  :commands (yas-global-mode))

(use-package company
  :after (yasnippet haskell-mode company-lsp)
  :config
    (setq company-selection-wrap-around nil
          ;; do or don't automatically start completion after <idle time>
          company-idle-delay 0.1
          ;; at least 1 letters need to be there though
          company-minimum-prefix-length 1
          ;; show completion numbers for hotkeys
          company-show-numbers t
          ;; show limited number of suggestions
          company-tooltip-limit 10
          ;; align annotations to the right
          company-tooltip-align-annotations t
          company-search-regexp-function #'company-search-flex-regexp
          company-require-match nil
          )
    (set-company-backend! '(text-mode) '(company-capf company-abbrev company-dabbrev company-semantic))
    (set-company-backend! '(prog-mode) '(company-capf company-abbrev company-complete  company-dabbrev company-semantic))
    (set-company-backend! '(emacs-lisp-mode) '(company-elisp company-keywords company-semantic company-files company-yasnippet company-dabbrev-code))
    (set-company-backend! '(python-mode) '(company-lsp company-keywords company-semantic company-files company-yasnippet company-dabbrev-code))
    (set-company-backend! '(haskell-mode) '(company-ghci company-keywords company-semantic company-yasnippet company-dabbrev-code))
    (set-company-backend! '(sh-mode) '(company-capf company-keywords company-semantic company-files company-yasnippet company-dabbrev-code))
    (set-company-backend! '(org-mode) '(company-capf company-keywords company-semantic company-files company-yasnippet company-dabbrev))
    (set-lookup-handlers! 'python-mode
      :definition #'lsp-ui-peek-find-definitions
      :references #'lsp-ui-peek-find-references)
    (set-lookup-handlers! 'emacs-lisp-mode
      :documentation #'helpful-at-point)
    (company-quickhelp-mode)
    (setq company-quickhelp-delay 0.1)
    (global-company-mode))

;; lsp
(use-package lsp-mode
  :hook
    (prog-mode . lsp)
    (reason-mode . lsp)
  :config
    (lsp-register-client
    (make-lsp-client :new-connection (lsp-stdio-connection "reason-language-server")
                      :major-modes '(reason-mode)
                      :notification-handlers (ht ("client/registerCapability" 'ignore))
                      :priority 1
                      :server-id 'reason-ls))
    (setq lsp-response-timeout 5)
    (evil-set-command-property 'lsp-goto-type-definition :jump t)
    (evil-set-command-property 'lsp-goto-implementation :jump t)
  :commands lsp)
(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
    (setq lsp-ui-doc-enable nil
          lsp-ui-doc-delay 0.1
          lsp-ui-doc-include-signature t
          lsp-ui-doc-position 'at-point
          lsp-ui-doc-max-width 65
          lsp-ui-doc-max-height 70
          ;;lsp-ui-doc-border "#fdf5b1"
          lsp-ui-doc-use-childframe t
          lsp-ui-sideline-enable t
          lsp-ui-sideline-ignore-duplicate t
          lsp-ui-sideline-show-hover t
          lsp-ui-sideline-show-symbol t
          lsp-ui-peek-enable nil
          lsp-ui-flycheck-enable 1)
    (add-to-list 'lsp-ui-doc-frame-parameters '(left-fringe . 0))
  :commands lsp-ui-mode)

(use-package company-lsp
  :after (lsp-mode)
  :config
      (add-to-list 'company-backends 'company-lsp)
      (setq company-lsp-enable-snippet t
            company-lsp-cache-candidates t)
  :commands company-lsp)

;;flycheck
(use-package flycheck
  :init (global-flycheck-mode)
  :hook (prog-mode . flycheck-mode)
  :config
    (setq flycheck-python-pycompile-executable "pycompile"
          flycheck-python-pylint-executable "pylint"
          flycheck-python-flake8-executable "flake8"
          flycheck-python-mypy-executable "mypy")
    (flycheck-define-checker proselint
          "A linter for prose."
          :command ("proselint" source-inplace)
          :error-patterns
          ((warning line-start (file-name) ":" line ":" column ": "
                (id (one-or-more (not (any " "))))
                (message (one-or-more not-newline)
                        (zero-or-more "\n" (any " ") (one-or-more not-newline)))
                line-end))
          :modes (text-mode markdown-mode gfm-mode org-mode))
    (add-to-list 'flycheck-checkers 'proselint)
    (add-to-list 'flycheck-checkers 'haskell-hlint)
    (add-to-list 'flycheck-checkers 'sh-posix-bash)
    (add-to-list 'flycheck-checkers 'sh-checkbashisms)
    (add-to-list 'flycheck-checkers 'sh-shellcheck)
    (setq flycheck-check-syntax-automatically '(mode-enabled save)))
(use-package flycheck-checkbashisms
  :after flycheck
  :config
    (flycheck-checkbashisms-setup)
    ;; Check 'echo -n' usage
    (setq flycheck-checkbashisms-newline t)
    ;; Check non-POSIX issues but required to be supported by Debian Policy 10.4
    ;; Setting this variable to non nil made flycheck-checkbashisms-newline effects
    ;; regardless of its value
    (setq flycheck-checkbashisms-posix t))
(use-package flycheck-pycheckers
  :after flycheck
  :config
    (setq flycheck-pycheckers-checkers '(flake8 pylint pyflakes mypy3 bandit pep8)
          flycheck-pycheckers-max-line-length 79)
    (add-hook! 'flycheck-mode-hook #'flycheck-pycheckers-setup))

(use-package ledger-mode
  :hook flymake-mode)


;; org
(use-package org
  :config
    (setq org-directory "~/Dropbox/Apps/Orgzly"
          org-agenda-files (list org-directory)
          org-archive-location "~/Dropbox/Apps/Orgzly/Archive"
          org-ellipsis " ▼ "
          org-bullets-bullet-list '("◉", "◎","✯","⁕", "*", "~")
          org-tags-column 80)
    (add-to-list 'org-modules 'org-habit t))

(use-package haskell-mode
  :config
    (defun haskell-as ()
      (interactive)
      (progn
        (haskell-process-load-or-reload)
        (haskell-interactive-bring)))
    (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
    (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

    (map!
        :map haskell-mode-map
        :leader
        (:prefix ("o" . "open")
          :desc "repl" "r" 'haskell-interactive-bring
        )
        (:prefix ("c" . "code")
          :desc "format imports" "i" 'haskell-mode-format-imports
          :desc "compile" "c" 'haskell-compile
          :desc "Recompile" "C" 'haskell-compile
          :desc "execute (send to REPL)" "a" 'haskell-as
          :desc "rename (iedit)" "r" 'iedit-mode
          :desc "Jump to definition" "d" 'haskell-mode-jump-to-def-or-tag
          :desc "" "D" nil
          :desc "" "E" nil
          :desc "send to REPL" "s" 'haskell-as
          :desc "show uses" "u" 'haskell-mode-find-uses
        ))
    (map!
     :map haskell-mode-map
     :n "C-c C-c" 'haskell-as
     :n "K" 'haskell-hoogle)

    (custom-set-variables
      '(haskell-font-lock-symbols nil)
      '(haskell-process-auto-import-loaded-modules t)
      '(haskell-process-load-or-reload-prompt nil)
      '(haskell-process-log nil)
      '(haskell-process-suggest-language-pragmas nil)
      '(haskell-process-suggest-no-warn-orphans t)
      '(haskell-tags-on-save t)))

(use-package hindent
  :hook (haskell-mode . hindent-mode)
  :config
    (setq hindent-reformat-buffer-on-save t
          hindent-style "johan-tibell"))
