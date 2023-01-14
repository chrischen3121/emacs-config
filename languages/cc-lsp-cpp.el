;;; cc-lsp-cpp.el --- C++ lsp-mode configuration

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

(defun cc/lsp-cpp-compile ()
  (interactive)
  (unless (file-exists-p "Makefile")
	(set (make-local-variable 'compile-command)
	 (let ((file (file-name-nondirectory buffer-file-name)))
	   (format "g++ -std=c++20 -Wall -g -o %s %s" (file-name-sans-extension file) file))))
  (compile compile-command))

(defun cc/cpp-setup ()
  (setq-local company-idle-delay 0.0
		  company-minimum-prefix-length 1
		  lsp-idle-delay 0.1))

(use-package cc-mode
  :after company
  :commands c++-mode
  :hook
  (c++-mode . lsp-deferred)
  (c++-mode . cc/cpp-setup)
  :bind
  (:map c++-mode-map
		("C-c m c" . cc/lsp-cpp-compile)))

(use-package cmake-mode
  :hook
  (cmake-mode . lsp-deferred))

(provide 'cc-lsp-cpp)

;;; cc-lsp-cpp.el ends here
