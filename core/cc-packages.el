;;; cc-packages.el --- Package Management

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

;; Initialize package sources
(require 'package)

(setq package-archives '(
                         ("stable-melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/stable-melpa/")
                         ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                         ("gnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("org" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
                         ))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; Futher reduce load time
(eval-when-compile
  (require 'use-package))

;; diminish
(use-package diminish
  :ensure t)

;; Globally ensure package installation
(setq use-package-always-ensure t)
(setq use-package-verbose t)
(use-package use-package-ensure-system-package)

;; M-x auto-package-update-now
(use-package auto-package-update
  :custom
  (auto-package-update-interval 14)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results nil)
  (auto-package-update-delete-old-versions nil)
  (auto-package-update-show-preview t)
  (auto-package-update-excluded-packages '(use-package))
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

;; quelpa
(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)))

;; disable quelpa-checkout-melpa on startup
(setq quelpa-update-melpa-p nil)
(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))

(require 'quelpa-use-package)

(provide 'cc-packages)

;;; cc-packages.el ends here
