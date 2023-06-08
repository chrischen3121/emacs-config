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
  (org-roam-db-gc-threshold most-positive-fixnum) ; improve performance
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
     ))
  :config
  (org-roam-db-autosync-mode)
  (require 'org-roam-protocol)
  (require 'org-roam-dailies)
  (which-key-add-keymap-based-replacements org-mode-map "C-c n b" "Backlinks")
  :bind
  (("C-c n j" . org-roam-dailies-goto-today)
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
   ("C-c n g" . org-roam-graph))
  :bind-keymap
  ;; daily notes keymap
  ("C-c n d" . org-roam-dailies-map))

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
  bibtex-completion
  :defer t
  :custom
  ;; zotero bib file
  (bibtex-completion-bibliography cc/zotero-bibtex-bib-file)
  (bibtex-completion-notes-path cc/org-roam-reference-directory)
  (bibtex-completion-library-path cc/zotero-zotfile-pdf-directory))

(use-package
  ivy-bibtex
  :commands ivy-bibtex
  :after (ivy org-refs bibtex-completion)
  :bind
  ("C-c n b" . ivy-bibtex))

(setq cc/org-roam-bib-ref-template
      (concat "#+FILETAGS: Book \n"
              "- tags :: %^{keywords} \n"
              "* %^{title}\n"
              ":PROPERTIES:\n"
              ":Custom_ID: %^{citekey}\n"
              ":URL: %^{url}\n"
              ":AUTHOR: %^{author-or-editor}\n"
              ":NOTER_DOCUMENT: "
              cc/zotero-zotfile-pdf-directory
              "/%^{citekey}.pdf\n"
              ":NOTER_PAGE:\n"
              ":END:"))

(use-package org-roam-bibtex
  :after org-roam
  :custom
  (orb-insert-interface 'ivy-bibtex)
  (orb-insert-link-description 'citekey)
  (orb-preformat-keywords
   '("citekey" "title" "url" "author-or-editor" "keywords" "file"))
  (orb-process-file-keyword t)
  (orb-attached-file-extensions '("pdf"))
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :bind
  (:map org-mode-map
        ("C-c n k" . orb-insert-link)
        ("C-c n e" . orb-note-actions))
  :config
  (add-to-list 'org-roam-capture-templates
               `("r" "bibliography reference" plain
                 ,cc/org-roam-bib-ref-template
                 :target (file+head "refs/${citekey}.org"
                                    "#+TITLE: ${title}\n")))
  )

(provide 'cc-org-roam)

;;; cc-org-roam.el ends here
