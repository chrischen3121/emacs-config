;;; cc-latex.el --- Summary

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
  :quelpa (cdlatex :fetcher github :repo "cdominik/cdlatex"))

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
  :config
  (pdf-loader-install)
  :bind
  (:map pdf-annot-minor-mode-map
   ("C-c h" . pdf-annot-add-highlight-markup-annotation)
   ("C-c t" . pdf-annot-add-text-annotation)
   ("C-c d" . pdf-annot-delete)
   :map pdf-view-mode-map
   ("d" . 'pdf-view-next-page-command)
   ("a" . 'pdf-view-previous-page-command)
   ("s" . 'pdf-view-scroll-up-or-next-page)
   ("w" . 'pdf-view-scroll-down-or-previous-page)))

;; (use-package
;;   org-noter
;;   :after pdf-tools
;;   :bind
;;   (:map org-mode-map
;;         ("C-c n n" . org-noter)))

(provide 'cc-latex)

;;; cc-latex.el ends here
