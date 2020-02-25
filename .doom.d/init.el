;;; init.el -*- lexical-binding: t; -*-

;; (setq gc-cons-threshold 1000000000)

;; (menu-bar-mode -1)
;; (toggle-scroll-bar -1)
;; (tool-bar-mode -1)

;; set font and color scheme
(setq doom-font (font-spec :family "SF Mono" :size 16)
      doom-big-font (font-spec :family "SF Mono" :size 36)
      doom-variable-pitch-font (font-spec :family "Avenir Next" :size 18))

;; some UTF-8 madness
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;; Store some personal credentionals
(setq user-full-name "Ohol Vitalii"
    user-mail-address "ohol.vitaliy@gmail.com"
    epa-file-encrypt-to user-mail-address)

;; Folow symlinks when opening files
(setq vc-follow-symlinks t)

;; annoying quit confirmation
(setq confirm-kill-emacs nil)

;; Spaces over tabs
(setq tab-width 4
      indent-tabs-mode nil)

(setq whitespace-line-column 80
    whitespace-style '(face trailing lines-tail))

;; enable some sunctionality for global use
(global-auto-revert-mode t)
(global-whitespace-mode t)
(global-hl-line-mode t)

;; two lines margin from top and bottom when scrolling
(setq scroll-margin 2)

;; Display ralative line numbers
(setq display-line-numbers nil)
;; (setq display-line-numbers-type 'relative)

;; Hide the mouse while typing:
(setq make-pointer-invisible t)

;; Turn off line wrapping
(setq-default truncate-lines t)

;; clean trailing whitespace on save
;; (add-hook! 'before-save-hook 'whitespace-cleanup)

;; Minibuffer
(setq show-trailing-whitespace t)
(add-hook! '(minibuffer-setup-hook doom-popup-mode-hook)
  (setq-local show-trailing-whitespace nil))

;; Smooth mouse scrolling
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1))  ; scroll two lines at a time
      mouse-wheel-progressive-speed nil             ; don't accelerate scrolling
      mouse-wheel-follow-mouse t                    ; scroll window under mouse
      scroll-step 1)

;; better highlight for parenthesis
;; default was too hard to notice espacially in 'molokai' color scheme
(setq show-paren-mode t
      show-paren-delay 0.1
      show-paren-style 'parenthesis)
(set-face-background 'show-paren-match "#fafa00")
(set-face-foreground 'show-paren-match (face-background 'default))
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

;; Prevents the unstyled mode-line flash at startup
(setq-default mode-line-format nil)

;; Select and raise the frame, always
(select-frame-set-input-focus (selected-frame))




(doom!  :input
        :completion
          (company               ; the ultimate code completion backend
              ;; +tng
              +auto
              +childframe)       ; a nicer company UI. Emacs +26 only!
          (ivy
              +fuzzy
              +childframe)       ; a search engine for love and life

        :ui
          deft                   ; notational velocity for Emacs
          doom                   ; what makes DOOM look the way it does
          doom-dashboard         ; a nifty splash screen for Emacs
          ;;doom-quit            ; DOOM quit-message prompts when you quit Emacs
          fill-column            ; a `fill-column' indicator
          hl-todo                ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
          ;;hydra
          indent-guides          ; highlighted indent columns
          modeline               ; snazzy, Atom-inspired modeline, plus API
          ophints                ; highlight the region an operation acts on
          (popup                 ; tame sudden yet inevitable temporary windows
            +all                 ; catch all popups that start with an asterix
            +defaults)           ; default popup rules
          ;;pretty-code          ; replace bits of code with pretty symbols
          ;;tabs                 ; an tab bar for Emacs
          treemacs               ; a project drawer, like neotree but cooler
          ;;unicode              ; extended unicode support for various languages
          vc-gutter              ; vcs diff in the fringe
          vi-tilde-fringe        ; fringe tildes to mark beyond EOB
          ;;zen                  ; distraction-free coding or writing

        :editor
          (evil +everywhere)     ; come to the dark side, we have cookies
          file-templates         ; auto-snippets for empty files
          fold                   ; (nigh) universal code folding
          (format +onsave)       ; automated prettiness
          multiple-cursors       ; editing in many places at once
          rotate-text            ; cycle region at point between text candidates
          snippets               ; my elves. They type so I don't have to

        :emacs
          dired                  ; making dired pretty [functional]
          electric               ; smarter, keyword-based electric-indent
          ibuffer                ; interactive buffer management
          vc                     ; version-control and Emacs, sitting in a tree

        :term
          ;;eshell                 ; a consistent, cross-platform shell (WIP)
          ;;shell                ; a terminal REPL for Emacs
          term                 ; terminals in Emacs
          ;;vterm                ; another terminals in Emacs

        :checkers
          (syntax +childframe)   ; tasing you for every semicolon you forget
          (spell +childframe)    ; tasing you for misspelling
          (grammar +childframe)  ; tasing grammar mistake every you make

        :tools
          debugger               ; FIXME stepping through code, to help you add bugs
          (eval +overlay)        ; run code, run (also, repls)
          (lookup                ; helps you navigate your code and documentation
            +dictionary
            +offline
            +docsets)            ; ...or in Dash docsets locally
          lsp
          magit                  ; a git porcelain for Emacs
          make                   ; run make tasks from Emacs
          (org +present)

        :lang
          ;(cc +lsp)             ; C/C++/Obj-C madness
          ;;csharp               ; unity, .NET, and mono shenanigans
          ;data                  ; config/data formats
          emacs-lisp             ; drown in parentheses
          ;;(java +meghanada)    ; the poster child for carpal tunnel syndrome
          ;;(latex +latexmk)     ; writing papers in Emacs has never been so fun
          (python +lsp)
          ;;lua                  ; one-based indices? one-based indices
          ;;markdown             ; writing docs for people to ignore
          ;;scheme               ; a fully conniving family of lisps
          (sh +lsp)              ; she sells {ba,z,fi}sh shells on the C xor

        :email
          ;;(mu4e +gmail)
          ;;notmuch
          ;;(wanderlust +gmail)

        :app
          ;;calendar
          ;;irc                  ; how neckbeards socialize
          ;;(rss +org)           ; emacs as an RSS reader
          ;;twitter              ; twitter client https://twitter.com/vnought
          ;;(write               ; emacs as a word processor (latex + org + markdown)
          ;;+wordnut             ; wordnet (wn) search
          ;;+langtool)           ; a proofreader (grammar/style check) for Emacs

        :config
          ;;literate
          (default +bindings +smartparens +snippets +evil-commands))
