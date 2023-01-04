(setq inhibit-startup-message t ; Don't show the splash screen
      visible-bell t ; Flash when the bell rings
      make-backup-files nil
      auto-save-default nil)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10) ; Give some breathing room

(recentf-mode 1)
(global-set-key (kbd "C-c C-f") 'recentf-open-files)
;; (column-number-mode 1) ; Toggle column number display in the mode line

(global-hl-line-mode 1)

;; Line numbers mode
(global-display-line-numbers-mode t)

;; Disable for some modes
(dolist (mode-hook '(org-mode-hook
		     term-mode-hook
		     shell-mode-hook
		     treemacs-mode-hook
		     help-mode-hook
		     ibuffer-mode-hook
		     eshell-mode-hook))
 (add-hook mode-hook (lambda () (display-line-numbers-mode -1))))

(fset 'yes-or-no-p 'y-or-n-p)

(defun cc/before-exit-emacs ()
  "Prompt the user to confirm before exiting Emacs."
  (if (yes-or-no-p "Are you sure you want to exit Emacs?")
      (kill-emacs)))

(add-hook 'kill-emacs-query-functions #'cc/before-exit-emacs)

;; Revert buffers when the underlying file has changed
(setq global-auto-revert-non-file-buffers t)
(global-auto-revert-mode 1)

;; Save what you enter into minibuffer prompts M-n/M-p
(setq history-length 25)
(savehist-mode 1)

;; Don't pop up UI dialogs when prompting
(setq use-dialog-box nil)

;; Remember and restore the last cursor location of opened files
(save-place-mode 1)

;; (add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; modus theme
(setq modus-themes-mode-line '(borderless))
(setq modus-themes-region '(bg-only))
;; (setq modus-themes-completions 'minimal)
(setq modus-themes-paren-match '(bold intense))
(setq modus-themes-bold-constructs t)
(setq modus-themes-italic-constructs t)
(setq modus-themes-syntax '(faint alt-syntax yellow-comments))

(setq modus-themes-headings
      '((1 . (rainbow overline background 1.4))
	(2 . (rainbow background 1.3))
	(3 . (rainbow bold 1.2))
	(t . (semilight 1.1))))
(setq modus-themes-scale-headings t)
(setq modus-themes-org-blocks 'tinted-background)
(load-theme 'modus-vivendi t) ; modus-theme-toggle

;; gruvbox-theme
;; (use-package
;;   gruvbox-theme
;;   :init (load-theme 'gruvbox-light-mediumsoft t))

;; Set frame transparency
(set-frame-parameter (selected-frame) 'alpha cc/frame-transparency)
(add-to-list 'default-frame-alist `(alpha . ,cc/frame-transparency))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; which-key
(use-package
  which-key
  :demand
  :diminish which-key-mode
  :custom (which-key-idle-delay 1)
  :init (which-key-mode 1))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; all-the-icons
(use-package
  all-the-icons
  :config (unless (member "all-the-icons" (font-family-list))
	    (all-the-icons-install-fonts t)))

(use-package
  all-the-icons-dired
  :after all-the-icons
  :hook (dired-mode . all-the-icons-dired-mode))

;; clean up trailing whitespace
(use-package
  whitespace
  :hook (before-save . whitespace-cleanup)
  :bind (:map prog-mode-map
	 ("C-c m w" . whitespace-mode)))

;; doom-modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(provide 'cc-better-defaults)
