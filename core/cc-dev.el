;;; cc-dev.el --- Tools for development

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

;;; Code:

(use-package
  magit
  :custom (magit-clone-set-remote.pushDefault t)
  :config (global-unset-key (kbd "C-c M-g"))
  :bind
  ("C-x g" . magit-status))

(use-package
  projectile
  :init
  (projectile-mode 1)
  (which-key-add-key-based-replacements "C-c p" "projectile")
  (which-key-add-key-based-replacements "C-c p 4" "ctl-x-4-prefix")
  (which-key-add-key-based-replacements "C-c p 5" "ctl-x-5-prefix")
  (which-key-add-key-based-replacements "C-c p s" "projectile-grep")
  (which-key-add-key-based-replacements "C-c p x" "projectile-run")
  :custom
  (projectile-completion-system 'ivy)
  (projectile-enable-caching t)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :diminish
  ;; :delight '(:eval (concat " P[" (projectile-project-name) "]"))
  :config
  (add-to-list 'projectile-globally-ignored-directories "elpa")
  (add-to-list 'projectile-globally-ignored-directories ".mypy_cache"))

;; git: highlight changes
(use-package
  git-gutter+
  :diminish
  :init
  (global-git-gutter+-mode 1))

;; company-mode
(defun cc/set-text-backends ()
  (setq-local company-backends
	      '((company-ispell :separate) company-files)))
(defun cc/set-prog-backends ()
  (setq-local company-backends
	      '((company-capf company-keywords :separate) company-ispell)))

;; hideshow
(use-package
  hideshow
  :diminish hs-minor-mode
  :hook
  (prog-mode . hs-minor-mode)
  :bind
  (:map hs-minor-mode-map
	("C-c @" . nil)
	("C-c h <backtab>" . hs-show-all)
	("C-c h l" . hs-hide-level)
	("C-c h <tab>" . hs-toggle-hiding))

  :config
  (which-key-add-keymap-based-replacements hs-minor-mode-map "C-c h" "hideshow"))

;; Auto Completion
(use-package
  company
  :diminish company-mode
  :custom
  (company-transformers '(company-sort-by-backend-importance))
  (company-minimum-prefix-length 1)
  :hook ((after-init . global-company-mode)
	 (text-mode . cc/set-text-backends)
	 (prog-mode . cc/set-prog-backends)))

(use-package
  yasnippet
  :after company
  :diminish yas-minor-mode
  :config
  (which-key-add-keymap-based-replacements yas-minor-mode-map "C-c y" "yasnippet")
  (yas-reload-all)
  :hook ((prog-mode . yas-minor-mode-on)
	 (org-mode . yas-minor-mode-on))
  :bind (:map yas-minor-mode-map
	      ("C-c &" . nil)
	      ("C-c y n" . yas-new-snippet)
	      ("C-c y r" . yas-reload-all)
	      ("C-c y v" . yas-visit-snippet-file)
	      ("M-/" . company-yasnippet)))


;; flyspell & flycheck
(use-package
  flycheck
  :diminish flycheck-mode
  :init (which-key-add-key-based-replacements "C-c !" "flycheck")
  :commands flycheck-mode
  :delight
  :hook ((prog-mode . flycheck-mode)
	 (text-mode . flycheck-mode))
  :bind (:map flycheck-mode-map
	      ("C-c ! ?" . nil)
	      ("C-c ! h" . nil)
	      ("C-c ! V" . nil)
	      ("C-c ! C-w" . nil)
	      ("C-c ! C" . nil)
	      ("C-c ! x" . nil)
	      ("C-c ! e" . nil)
	      ("C-c ! H" . nil)))

(use-package
  flyspell
  :diminish flyspell-mode
  :bind (:map flyspell-mode-map
	      ("C-c $" . nil)
	      ("C-c ! s" . flyspell-buffer)
	      ("C-c ! i" . flyspell-correct-word-before-point))
  :hook ((prog-mode . flyspell-prog-mode)
	 (org-mode . flyspell-mode)))

;; "Move Where I Mean"
(use-package
  mwim
  :bind
  (:map prog-mode-map
	("C-a" . mwim-beginning-of-code-or-line)
	("C-e" . mwim-end-of-code-or-line)))

;; Visualizing color codes
(use-package
  rainbow-mode
  :diminish
  :hook prog-mode)

;; Colorize parens
(use-package
  rainbow-delimiters
  :diminish
  :hook emacs-lisp-mode)

(provide 'cc-dev)

;;; cc-dev.el ends here
