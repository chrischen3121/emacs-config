;;; cc-others.el --- Other Languages

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

;; Makefile
(use-package make-mode
  :custom
  (tab-width 4)
  :bind
  (:map makefile-mode-map
        ("C-c C-f" . nil)))

(use-package sh-script
  :bind
  (:map sh-mode-map
        ("C-c C-f" . nil)))

;; Plantuml
(use-package
  plantuml-mode
  :mode "\\.puml\\'"
  :interpreter "plantuml"
  :ensure-system-package plantuml
  :custom (plantuml-default-exec-mode 'executable))

(use-package dockerfile-mode
  :hook (dockerfile-mode . lsp-deferred))

(use-package yaml-mode
  :mode "\\mongod.conf\\'"
  :hook
  (yaml-mode . lsp-deferred)
  (yaml-mode . cc/set-prog-backends)
  (yaml-mode . smartparens-mode))

(use-package graphviz-dot-mode
  :mode "\\.dot\\'"
  :ensure-system-package dot)

(use-package nginx-mode
  :hook (nginx-mode . lsp-deferred))

(provide 'cc-others)

;;; cc-others.el ends here
