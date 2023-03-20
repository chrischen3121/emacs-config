;;; cc-lsp-python.el --- Python lsp-mode configuration

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

(use-package python
  :hook
  (python-mode . lsp-deferred)
  :custom
  (python-shell-interpreter "ipython")
  (python-shell-interpreter-args "--simple-prompt -i")
  (python-indent-guess-indent-offset t)
  (python-indent-guess-indent-offset-verbose nil)
  (lsp-pylsp-plugins-black-enabled t)
  ;; (lsp-pylsp-plugins-pycodestyle-enabled t)
  (lsp-pylsp-plugins-pylint-enabled t)
  :bind
  (:map python-mode-map
        ("C-c C-f" . nil)))

(use-package poetry
  :ensure t
  :init
  (poetry-tracking-mode 1)
  :custom
  (poetry-tracking-strategy 'projectile))

(provide 'cc-lsp-python)

;;; cc-lsp-python.el ends here
