;;; cc-ivy-counsel.el --- Configurations for ivy/counsel

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

(use-package swiper
  :commands swiper)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-backward-delete-char)
	 ("C-j" . ivy-immediate-done)
	 :map ivy-switch-buffer-map
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-d" . ivy-reverse-i-search-kill))
  :init
  (ivy-mode 1))

;; counsel
(use-package
  counsel
  :bind (:map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :init (counsel-mode 1))

;; helpful
(use-package
  helpful
  :after counsel
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind (:map counsel-mode-map
	 ([remap describe-key] . helpful-key)
	 ([remap describe-symbol] . helpful-symbol)
	 ([remap describe-command] . helpful-command)
	 :map emacs-lisp-mode-map
	 ("C-c d" . helpful-at-point)))

(use-package ivy-rich
  :after (ivy counsel)
  :init
  (ivy-rich-mode 1))

;; Improved Candidate Sorting with prescient.el
(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  ;; to have sorting remembered across sessions!
  (prescient-persist-mode 1)
  (ivy-prescient-mode 1))

(provide 'cc-ivy-counsel)

;;; cc-ivy-counsel.el ends here
