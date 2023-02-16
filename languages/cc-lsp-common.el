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
  :custom
  (lsp-keymap-prefix "C-c l")
  (lsp-completion-provider :none)
  :config
  (lsp-enable-which-key-integration t)
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
  (lsp-ui-doc-position 'bottom)
  (lsp-ui-sideline-enable nil)
  (lsp-ui-sideline-show-hover nil)
  :bind
  (:map lsp-mode-map
   ("C-c g g" . lsp-ui-peek-find-definitions)
   ("C-c g r" . lsp-ui-peek-find-references)
   ("C-c g i" . lsp-ui-peek-find-implementation)))

(use-package lsp-ivy
  :after (lsp-mode ivy)
  :commands
  (lsp-ivy-workspace-symbol lsp-ivy-global-workspace-symbol))

(provide 'cc-lsp-common)

;;; cc-lsp-common.el ends here
