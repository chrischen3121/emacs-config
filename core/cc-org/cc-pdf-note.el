;;; cc-pdf-note.el --- Summary

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

(use-package cdlatex
  :defer t
  :quelpa (cdlatex :fetcher github :repo "cdominik/cdlatex")
  :hook
  (org-mode . org-cdlatex-mode))

(use-package tex
  :ensure auctex
  :custom
  (TeX-parse-self t)
  (TeX-PDF-mode t)
  (TeX-DVI-via-PDFTeX t)
  (TeX-source-correlate-mode t)
  (TeX-source-correlate-start-method 'synctex)
  (TeX-view-program-selection '((output-pdf "PDF Tools")))
  :hook
  (LaTeX-mode . turn-on-cdlatex)
  (LaTeX-mode . turn-on-reftex)
  (LaTeX-mode . outline-minor-mode)
  (LaTeX-mode . outline-hide-body)
  ;; refresh pdf after compilation
  (TeX-after-compilation-finished-functions . TeX-revert-document-buffer))

;;; pdf-tools Hints
;; o: show table of content
;; q: close table of content
;; l: last position
;; r: next position
;; +: zoom in
;; -: zoom out
;; W: fit page width
(use-package
  pdf-tools
  :custom
  (pdf-view-display-size 'fit-width)
  (pdf-view-resize-factor 1.1)
  (pdf-annot-activate-created-annotations t)
  (pdf-view-use-scaling t)
  (pdf-view-use-imagemagick nil)
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :hook
  (pdf-view-mode . pdf-view-themed-minor-mode)
  :config
  (pdf-loader-install)
  (which-key-add-key-based-replacements "C-c C-a" "pdf-annot")
  (which-key-add-key-based-replacements "C-c C-r" "pdf-view-minor-modes")
  :bind
  (:map pdf-annot-minor-mode-map
   ("C-c h" . pdf-annot-add-highlight-markup-annotation)
   ("C-c t" . pdf-annot-add-text-annotation)
   ("C-c d" . pdf-annot-delete)
   ("C-c l" . pdf-annot-list-annotations) ; Hint: <SPC> go to selected annotation
   :map pdf-view-mode-map
   ("d" . 'pdf-view-next-page-command)
   ("a" . 'pdf-view-previous-page-command)
   ("s" . 'pdf-view-scroll-up-or-next-page)
   ("w" . 'pdf-view-scroll-down-or-previous-page)
   ("C-c m t" . pdf-view-themed-minor-mode)))

;; Hints:
;; In org-mode
;; M-n: next page
;; M-p: previous page
(use-package
  org-noter
  :init
  ;; fix 'pdf-annot-minor-mode-map not found' error
  (require 'pdf-annot)
  :custom
  (org-noter-notes-search-path `(,cc/org-roam-reference-directory))
  (org-noter-auto-save-last-location t)
  (org-noter-highlight-selected-text t)
  (org-noter-max-short-selected-text-length 25)
  :bind
  (:map org-mode-map
        ("C-c n n" . org-noter)
        :map pdf-view-mode-map
        ("C-c n n" . org-noter)
        :map org-noter-doc-mode-map
        ("e" . org-noter-insert-note) ; easy for left-hand
        ("M-e" . org-noter-insert-precise-note)))

(provide 'cc-pdf-note)

;;; cc-pdf-note.el ends here
