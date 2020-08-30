(setq make-backup-files nil
      auto-save-default nil)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(line-number-mode 1)
(column-number-mode 1)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setq-default display-line-numbers-type 'relative
	      display-line-numbers-current-absolute t
	      display-line-numbers-width 4)

(electric-pair-mode 1)
(show-paren-mode 1)

(setq scroll-step 1
      scroll-conservatively 10000
      scroll-margin 0)

(winner-mode 1)

(add-hook 'before-save-hook 'whitespace-cleanup)

(setq ring-bell-function 'ignore)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package darktooth-theme)

(use-package evil
  :init
  (evil-mode 1))

(use-package minions
  :init
  (minions-mode 1))

(use-package moody
  :init
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode)
  :config
  (setq x-underline-at-descent-line t)
  (setq moody-mode-line-height 25))

(use-package which-key
  :init
  (which-key-mode 1))

(use-package ivy
  :init
  (ivy-mode 1))
(use-package counsel
  :after (ivy)
  :init
  (counsel-mode 1))

(use-package swiper
  :after (ivy))

(use-package avy)

(use-package company
  :init
  (global-company-mode 1)
  :config
  (define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)
  (define-key company-active-map (kbd "C-n") 'company-select-next-or-abort)
  (setq company-minimum-prefix-length 1)
  (setq company-tooltip-idle-delay 0))

(use-package eglot)

(use-package yasnippet)
(use-package yasnippet-snippets
  :after (yasnippet))

(use-package evil-magit)

(use-package counsel-projectile
  :init
  (counsel-projectile-mode))

(use-package rust-mode)
(use-package cargo
  :after (rust-mode)
  :hook
  (rust-mode . cargo-minor-mode))

(use-package elpy
  :config
  (elpy-enable))

(use-package auctex
  :defer t)

(add-to-list 'eglot-server-programs '(c-mode . ("/usr/bin/ccls")))
(add-to-list 'eglot-server-programs '(c++-mode . ("/usr/bin/ccls")))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'c-mode-hook 'yas-minor-mode)
(add-hook 'c++-mode-hook 'yas-minor-mode)

(add-to-list 'eglot-server-programs '(rust-mode . ("~/.cargo/bin/rust-analyzer")))
(add-hook 'rust-mode-hook 'eglot-ensure)
(add-hook 'rust-mode-hook 'yas-minor-mode)

(require 'gud)
(define-key gud-minor-mode-map (kbd "<S-f5>") 'gud-run)
(define-key gud-minor-mode-map (kbd "<f5>") 'gud-cont)
(define-key gud-minor-mode-map (kbd "<f7>") 'gud-tbreak)
(define-key gud-minor-mode-map (kbd "<f8>") 'gud-break)
(define-key gud-minor-mode-map (kbd "<f9>") 'gud-next)
(define-key gud-minor-mode-map (kbd "<f10>") 'gud-step)
(define-key gud-minor-mode-map (kbd "<S-f10>") 'gud-finish)
(add-hook 'gdb-mode-hook 'gdb-many-windows)

(setq leader-map (make-sparse-keymap))
(setq file-map (make-sparse-keymap))
(setq buffer-map (make-sparse-keymap))
(setq search-map (make-sparse-keymap))
(setq avy-map (make-sparse-keymap))
(setq window-map (make-sparse-keymap))
(setq git-map (make-sparse-keymap))
(setq quit-map (make-sparse-keymap))
(define-key evil-normal-state-map (kbd ",") leader-map)
(define-key evil-motion-state-map (kbd ",") leader-map)
(define-key leader-map (kbd "f") file-map)
(define-key leader-map (kbd "b") buffer-map)
(define-key leader-map (kbd "s") search-map)
(define-key leader-map (kbd "a") avy-map)
(define-key leader-map (kbd "w") window-map)
(define-key leader-map (kbd "p") projectile-command-map)
(define-key leader-map (kbd "g") git-map)
(define-key leader-map (kbd "q") quit-map)
(define-key leader-map (kbd ",") 'counsel-M-x)
(define-key file-map (kbd "f") 'find-file)
(define-key file-map (kbd "s") 'save-buffer)
(define-key buffer-map (kbd "b") 'switch-to-buffer)
(define-key buffer-map (kbd "k") 'kill-buffer)
(define-key buffer-map (kbd "x") 'kill-buffer-and-window)
(define-key search-map (kbd "s") 'swiper)
(define-key search-map (kbd "a") 'swiper-all)
(define-key avy-map (kbd "c") 'avy-goto-char)
(define-key avy-map (kbd "w") 'avy-goto-word-1)
(define-key window-map (kbd "h") (lambda () (interactive) (split-window-below) (other-window 1)))
(define-key window-map (kbd "v") (lambda () (interactive) (split-window-right) (other-window 1)))
(define-key window-map (kbd "[") (lambda () (interactive) (shrink-window-horizontally 5) (set-transient-map window-map)))
(define-key window-map (kbd "]") (lambda () (interactive) (enlarge-window-horizontally 5) (set-transient-map window-map)))
(define-key window-map (kbd "{") (lambda () (interactive) (shrink-window 5) (set-transient-map window-map)))
(define-key window-map (kbd "}") (lambda () (interactive) (enlarge-window 5) (set-transient-map window-map)))
(define-key window-map (kbd "1") 'delete-other-windows)
(define-key window-map (kbd "0") 'delete-window)
(define-key git-map (kbd "g") 'magit-status)
(define-key git-map (kbd "d") 'magit-dispatch)
(define-key quit-map (kbd "q") 'save-buffers-kill-emacs)
(global-set-key (kbd "<M-left>") (lambda () (interactive) (windmove-left) (set-transient-map window-map)))
(global-set-key (kbd "<M-down>") (lambda () (interactive) (windmove-down) (set-transient-map window-map)))
(global-set-key (kbd "<M-up>") (lambda () (interactive) (windmove-up) (set-transient-map window-map)))
(global-set-key (kbd "<M-right>") (lambda () (interactive) (windmove-right) (set-transient-map window-map)))
(global-set-key (kbd "<C-return>") 'eshell)
(define-key prog-mode-map (kbd "<tab>") 'indent-for-tab-command)
(define-key counsel-mode-map (kbd "<escape>") 'minibuffer-keyboard-quit)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(darktooth))
 '(custom-safe-themes
   '("bf4b3dbc59b2b0873bd74ebf8f3a8c13d70dc3d36a4724b27edb1e427f047c1e" default))
 '(display-buffer-alist '(("*eshell*" display-buffer-at-bottom (nil))))
 '(package-selected-packages
   '(auctex elpy cargo rust-mode counsel-projectile evil-magit yasnippet-snippets yasnippet eglot company avy counsel ivy which-key moody minions evil darktooth-theme use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
