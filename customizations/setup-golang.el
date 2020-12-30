;;; setup-golang.el --- Golang Setup
;;; Commentary:

;;; Code:
(setenv "PATH" (concat (getenv "PATH") ":~/go/bin"))
(setq exec-path (append exec-path '("~/go/bin")))

(defun my-lsp-format-buffer ()
  (if (eq major-mode 'go-mode)
      (lsp-format-buffer)))

(defun my-lsp-organize-imports ()
  (if (eq major-mode 'go-mode)
      (lsp-organize-imports)))

(use-package lsp-mode
  :commands lsp
  :init
  (setq lsp-keymap-prefix "H-l")
  ;; reformat Go code and add missing (or remove old) imports
  :hook ((before-save . my-lsp-format-buffer)
         (before-save . my-lsp-organize-imports))
  :bind (("C-c e r" . lsp-find-references)
         ("C-c e R" . lsp-rename)
         ("C-c e i" . lsp-find-implementation)
         ("C-c e t" . lsp-find-type-definition)))

(use-package lsp-ui
  :init
  (setq lsp-ui-doc-enable nil
        lsp-ui-sideline-delay 5.0)
  :bind (("C-c d" . lsp-ui-doc-show)
         ("C-c i" . lsp-ui-imenu)))

(use-package go-guru
  :after go-mode)

(use-package go-mode
  :bind
  (:map go-mode-map
        ("C-c e g" . godoc)
        ("C-c P" . my-godoc-package))
  :hook ((go-mode . lsp)))

(add-hook 'go-mode-hook 'lsp-deferred)

(use-package company
  :ensure t
  :config
  ;; Optionally enable completion-as-you-type behavior.
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(provide 'setup-golang)
;;; setup-golang.el ends here
