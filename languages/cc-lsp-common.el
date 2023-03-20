;;; cc-lsp-common.el --- Common configuration for lsp-mode

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

(use-package lsp-mode
  :commands
  (lsp lsp-deferred)
  :hook
  (js-mode . lsp-deferred)
  (sh-mode . lsp-deferred)
  (html-mode . lsp-deferred)
  (css-mode . lsp-deferred)
  ;; TODO (conf-toml-mode . lsp-deferred)
  :custom
  (lsp-keymap-prefix "C-c l")
  (lsp-completion-provider :none)
  :config
  (lsp-enable-which-key-integration t)
  ;; TODO: ansible
  ;; (lsp-register-client
  ;;  (make-lsp-client :new-connection (lsp-stdio-connection "ansible-language-server")
  ;;                   :major-modes '(yaml-mode)
  ;;                   :server-id 'ansible))
  ;; TODO: lsp-register-client for grammarly language server
  :bind
  (:map lsp-mode-map
   ("C-c f" . lsp-format-buffer)
   ("C-c g d" . lsp-find-declaration)
   ("C-c g t" . lsp-find-type-definition)
   ("C-c r r" . lsp-rename)))

;; TODO:
;; (use-package dap-mode
;;   :after lsp-mode
;;   ;; :init
;;   ;; (which-key-add-keymap-based-replacements lsp-mode-map "C-l d" '("debug" . ))
;;   :hook (lsp-mode . dap-mode)
;;   :bind
;;   (:map dap-mode-map
;;    ("C-c l d d" . dap-debug)
;;    ("C-c l d e" . dap-debug-edit-template)))

;; ;; optionally if you want to use debugger
;; (use-package dap-mode)
;; ;; (use-package dap-LANGUAGE) to load the dap adapter for your language

(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-delay 2)
  (lsp-ui-doc-show-with-cursor nil)
  (lsp-ui-doc-show-with-mouse nil)
  (lsp-ui-doc-position 'bottom)
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-sideline-delay 0.5)
  (lsp-ui-imenu-enable t)
  (lsp-ui-imenu-buffer-position 'left)
  ;; testing
  (lsp-ui-imenu-auto-refresh t)
  (lsp-ui-imenu-refresh-delay 5)
  :bind
  (:map lsp-mode-map
   ("C-c m d" . lsp-ui-doc-glance)
   ("C-c m a" . lsp-ui-sideline-apply-code-actions)
   ("C-c m i" . lsp-ui-imenu)
   ("C-c g g" . lsp-ui-peek-find-definitions)
   ("C-c g r" . lsp-ui-peek-find-references)
   ("C-c g i" . lsp-ui-peek-find-implementation)))

(use-package lsp-ivy
  :after (lsp-mode ivy)
  :commands
  (lsp-ivy-workspace-symbol lsp-ivy-global-workspace-symbol))

(provide 'cc-lsp-common)

;;; cc-lsp-common.el ends here
