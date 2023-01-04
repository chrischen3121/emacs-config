(use-package
  magit
  :custom (magit-clone-set-remote.pushDefault t)
  :bind ("C-x g" . magit-status))

;; highlight changes
;; (use-package
;;   git-gutter+
;;   :delight
;;   :hook (after-init . global-git-gutter+-mode))

;; company-mode
(defun cc/set-text-backends ()
  (setq-local company-backends '((company-ispell
                                  :separate) company-files)))
(defun cc/set-prog-backends ()
  (setq-local company-backends '((company-capf company-keywords :separate) company-ispell)))

(use-package
  company
  ;; :delight
  :custom
  (company-transformers '(company-sort-by-backend-importance))
  (company-minimum-prefix-length 1)
  :hook ((after-init . global-company-mode)
         (text-mode . cc/set-text-backends)
         (prog-mode . cc/set-prog-backends)))


(provide 'cc-dev)
