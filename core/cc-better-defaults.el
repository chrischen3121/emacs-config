(setq inhibit-startup-message t ; Don't show the splash screen
      visible-bell t ; Flash when the bell rings
      make-backup-files nil) 

(tool-bar-mode -1)
(scroll-bar-mode -1)
(recentf-mode 1) ; recentf-open-files
(global-hl-line-mode 1)
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

(provide 'cc-better-defaults)
