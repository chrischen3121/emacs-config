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
  (setq-local company-idle-delay 0.2
              ; company-minimum-prefix-length 0
              lsp-idle-delay 0.2
              tab-width 4))

;; open an eshell in a new window and run compiled program
(defun cc/lsp-run-compiled-program ()
  (interactive)
  (let ((file (file-name-sans-extension (file-name-nondirectory buffer-file-name))))
    ;; split if there is only one window
    (when (= (length (window-list)) 1)
      (split-window-horizontally))
    (other-window 1)
    (eshell)
    (eshell-return-to-prompt)
    (insert (concat "./" file))
    (eshell-send-input)
    (other-window -1)))

(use-package cc-mode
  :after company
  :commands c++-mode
  :hook
  (c++-mode . lsp-deferred)
  (c++-mode . cc/cpp-setup)
  ;; (c++-mode . cc/set-prog-backends)
  :bind
  (:map c++-mode-map
        ("C-c m c" . cc/lsp-cpp-compile)
        ("C-c m m" . woman)
        ("C-c m r" . cc/lsp-run-compiled-program)
        ("C-c m g" . gud-debug)))

(use-package cmake-mode
  :hook
  (cmake-mode . lsp-deferred))

(provide 'cc-lsp-cpp)

;;; cc-lsp-cpp.el ends here
