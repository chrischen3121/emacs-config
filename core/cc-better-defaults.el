;;; cc-better-defaults.el --- Better Default

;; Author: chrischen
;; Maintainer: chrischen

;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; M-s h --- highlight

;;; Code:
(setq inhibit-startup-message t ; Don't show the splash screen
      visible-bell t ; Flash when the bell rings
      make-backup-files nil
      auto-save-default nil)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(delete-selection-mode 1)
(set-fringe-mode 10) ; Give some breathing room

;; recentf-mode
(recentf-mode 1)
(global-set-key (kbd "C-c C-f") 'recentf-open-files)
(global-hl-line-mode 1)

;; Line numbers mode
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'org-mode-hook #'display-line-numbers-mode)

(column-number-mode 1) ; Toggle column number display in the mode line

(fset 'yes-or-no-p 'y-or-n-p)
(global-unset-key (kbd "C-z"))

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
  :init (which-key-mode 1)
  :config
  (which-key-add-key-based-replacements "C-c m" "mode-commands")
  (which-key-add-key-based-replacements "C-x 8" "strange-chars")
  (which-key-add-key-based-replacements "C-x RET" "coding-system")
  (which-key-add-key-based-replacements "C-x p" "project")
  (which-key-add-key-based-replacements "C-x t" "tab")
  (which-key-add-key-based-replacements "C-x n" "narrow")
  (which-key-add-key-based-replacements "C-x r" "register")
  (which-key-add-key-based-replacements "C-x a" "abbrev")
  (which-key-add-key-based-replacements "C-x x" "buffer")
  (which-key-add-key-based-replacements "C-x X" "edebug")
  (which-key-add-key-based-replacements "C-x C-a" "edebug")
  (which-key-add-key-based-replacements "C-h 4" "info-other-window")
  (which-key-add-key-based-replacements "M-s h" "highlight"))

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

  :bind
  (:map prog-mode-map
	("C-c m w" . whitespace-mode)))

;; doom-modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

;; Easy shortcut to switch windows
(use-package
  ace-window
  :bind (([remap other-window] . ace-window)
	 ("C-x w" . ace-swap-window)))

(use-package
  hl-todo
  :init
  (global-hl-todo-mode 1))

;; Better C-w action
(use-package
  whole-line-or-region
  :diminish whole-line-or-region-local-mode
  :init (whole-line-or-region-global-mode 1))

;; It can help you to move your cursor to ANY position in emacs
;; by using only 3 times key press.
(use-package
  ace-jump-mode
  :bind ("C-x j" . ace-jump-mode))

;; smartparens
;; use M-x sp-cheat-sheet show all commands
(use-package
  smartparens
  :diminish smartparens-mode
  :init (require ' smartparens-config)
  :hook ((org-mode . smartparens-mode)
	 (prog-mode . smartparens-mode))
  :bind (:map emacs-lisp-mode-map
	 ("C-M-f" . sp-forward-sexp)
	 ("C-M-b" . sp-backward-sexp)))

;; command-log-mode: show keybinding history
(use-package command-log-mode
  :config
  (global-command-log-mode 1))

;; TODO edebug
;; TODO eldoc

(provide 'cc-better-defaults)
;;; cc-better-defaults.el ends here
