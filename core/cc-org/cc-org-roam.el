;;; cc-org-roam.el --- Org Roam Configuration

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

(use-package org-roam
  :init
  (which-key-add-key-based-replacements "C-c n" "org-roam")
  :diminish
  :custom
  (org-roam-directory cc/org-roam-directory)
  (org-roam-db-location cc/org-roam-db-location)
  (org-roam-graph-viewer cc/org-roam-graph-viewer)
  (org-roam-dailies-directory cc/org-roam-dailies-directory)
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
   '(("d" "default" plain "%?"
      :immediate-finish t
      :if-new (file+head "${slug}.org" "#+TITLE: ${title}\n")
      :unnarrowed t)
     ("t" "temp" plain "%?"
      :immediate-finish t
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                         "#+TITLE: ${title}\n")
      :unnarrowed t)
     ("r" "bibliography reference" plain "%?"
      :target
      (file+head "references/${citekey}.org"
                 "#+TITLE: ${title}\n")
      :unnarrowed t)))
  :config
  (org-roam-db-autosync-mode)
  (require 'org-roam-protocol)
  (which-key-add-keymap-based-replacements org-mode-map "C-c n b" "Backlinks")
  :bind
  (("C-c n j" . org-roam-dailies-goto-today)
   ("C-c n d" . org-roam-dailies-find-directory)
   ("C-c n c" . org-roam-capture)
   ("C-c n f" . org-roam-node-find)
   ("C-c n i" . org-roam-node-insert)
   ("C-c n p" . org-id-get-create)
   ("C-c n u" . org-roam-ui-mode)
   ("C-c n l" . org-roam-ui-sync-theme)
   :map org-mode-map
   ("C-c n a" . org-roam-alias-add)
   ("C-c n b" . org-roam-buffer-toggle)
   ("C-c n t" . org-roam-tag-add)
   ("C-c n r" . org-roam-ref-add)
   ("C-c n n" . org-roam-node-random)
   ("C-c n g" . org-roam-graph)))

(use-package
  org-roam-ui
  :after org-roam
  :diminish
  :custom
  (org-roam-ui-sync-theme t)
  (org-roam-ui-follow t)
  (org-roam-ui-update-on-save t))

;; full-text search
;; C-c C-g refresh the file browser
;; C-c C-c to clear the filter string
(use-package
  deft
  :after org
  :bind ("C-c n s" . deft)
  :custom
  (deft-recursive t)
  (deft-strip-summary-regexp ":PROPERTIES:\n\\(.+\n\\)+:END:\n")

  ;; (deft-use-filename-as-title nil)
  ;; (deft-use-filter-string-for-filename t)
  ;; disable auto-save
  (deft-auto-save-interval -1.0)
  (deft-default-extension "org")
  (deft-directory cc/org-roam-directory))

(use-package
  org-ref
  :custom
  (bibtex-completion-bibliography cc/zotero-bibtex-bib-file)
  (bibtex-completion-notes-path cc/org-roam-reference-directory)
  (bibtex-completion-pdf-field "file")
  (bibtex-completion-pdf-open-function
   (lambda (fpath)
     (call-process "open" nil 0 nil fpath)))
  )

(use-package
  ivy-bibtex
  :commands ivy-bibtex
  :after org-ref)

(use-package org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (require 'org-ref))

(provide 'cc-org-roam)

;;; cc-org-roam.el ends here
