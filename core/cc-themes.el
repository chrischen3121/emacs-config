;;; cc-themes.el --- Theme Configuration

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

;; ;; modus theme high-contrast
;; (setq modus-themes-mode-line '(borderless))
;; (setq modus-themes-region '(bg-only))
;; ;; (setq modus-themes-completions 'minimal)
;; (setq modus-themes-paren-match '(bold intense))
;; (setq modus-themes-bold-constructs t)
;; (setq modus-themes-italic-constructs t)
;; (setq modus-themes-syntax '(faint alt-syntax yellow-comments))

;; (setq modus-themes-headings
;;       '((1 . (rainbow overline background 1.4))
;;	(2 . (rainbow background 1.3))
;;	(3 . (rainbow bold 1.2))
;;	(t . (semilight 1.1))))
;; (setq modus-themes-scale-headings t)
;; (setq modus-themes-org-blocks 'tinted-background)
;; (load-theme 'modus-operandi t) ; M-x modus-theme-toggle
;; (global-set-key (kbd "<f1>") 'modus-themes-toggle)

;; doom-themes low-contrast
(defun cc/switch-themes-toggle ()
  """Switch light/dark themes"""
  (interactive)
  (if (eq (car custom-enabled-themes) 'doom-gruvbox-light)
      (progn (disable-theme 'doom-gruvbox-light)
	     (load-theme 'doom-palenight t))
    (disable-theme 'doom-palenight)
    (load-theme 'doom-gruvbox-light t)))

(use-package doom-themes
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  :config
  (load-theme 'doom-gruvbox-light t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config)
  :bind ("<f1>" . 'cc/switch-themes-toggle))

(provide 'cc-themes)

;;; cc-themes.el ends here
