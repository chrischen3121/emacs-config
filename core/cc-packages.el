
;; Initialize package sources
(require 'package)

(setq package-archives '(("elpa"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                         ("org" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))

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
;; (setq use-package-verbose t)
;; (use-package
;;   use-package-ensure-system-package
;;   :ensure t)

;; M-x auto-package-update-now
(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

(provide 'cc-packages)
