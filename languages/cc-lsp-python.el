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

;; This package is used to configure python lsp-mode.

;;; Hints:

;; This package uses poetry.el to activate poetry virtualenv.
;; Please make sure virtualenv will be activated before starting lsp server.
;; or you can restart lsp server(lsp-workspace-restart `C-c l w r`) after activating virtualenv manually.

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

  ;; lsp plugins
  ;; default jedi
  (lsp-pylsp-plugins-jedi-completion-fuzzy nil) ; if enabled, it can hit performance

  ;; completion
  (lsp-pylsp-plugins-jedi-completion-enabled t)
  (lsp-pylsp-plugins-rope-completion-enabled nil)

  ;; formatting
  (lsp-pylsp-plugins-black-enabled t) ; black formatting
  (lsp-pylsp-plugins-yapf-enabled nil) ; yapf formatting
  (lsp-pylsp-plugins-autopep8-enabled nil) ; autopep8 formatting

  ;; linting
  (lsp-pylsp-plugins-pyflakes-enabled nil) ; default pyflakes linting
  (lsp-pylsp-plugins-flake8-enabled nil) ; flake8 linting
  (lsp-pylsp-plugins-pylint-enabled nil) ; pylint linting
  (lsp-pylsp-plugins-pycodestyle-enabled nil) ; pycodestyle linting
  ;; ruff fastest linting
  ;; pipx inject python-lsp-server python-lsp-ruff


  (lsp-pylsp-plugins-mccabe-enabled t) ; mccabe complexity checking

  ;; docstring
  (lsp-pylsp-plugins-pydocstyle-enabled nil) ; docstring style checking

  ;; refactoring
  ;; pipx inject python-lsp-server pylsp-rope
  ;; (lsp-pylsp-rename-backend 'rope)

  :bind
  (:map python-mode-map
        ("C-c C-f" . nil)))

(use-package poetry
  :ensure t
  :custom
  (poetry-tracking-mode 1)
  (poetry-tracking-strategy 'switch-buffer)
  :bind
  (:map python-mode-map
        ("C-c m p" . poetry)))

(provide 'cc-lsp-python)

;;; cc-lsp-python.el ends here
