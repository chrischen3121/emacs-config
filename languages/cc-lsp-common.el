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
  :custom
  (lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode)


;; (use-package lsp-ivy
;;   :after (lsp-mode ivy)
;;   :commands
;;   (lsp-ivy-workspace-symbol lsp-ivy-global-workspace-symbol))

(provide 'cc-lsp-common)

;;; cc-lsp-common.el ends here
