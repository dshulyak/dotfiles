(require 'company)
(require 'flycheck)
(require 'go-eldoc)
(require 'company-go)
(require 'projectile)
(require 'go-projectile)

(add-hook 'before-save-hook 'gofmt-before-save)
(setq-default gofmt-command "goimports")
(add-hook 'go-mode-hook 'go-eldoc-setup)
(add-hook 'go-mode-hook (lambda ()
                            (set (make-local-variable 'company-backends) '(company-go))
                            (company-mode)))
(add-hook 'go-mode-hook 'yas-minor-mode)
(add-hook 'go-mode-hook 'flycheck-mode)

(eval-after-load 'go-mode
  '(progn
    ;; Set $GOPATH
    (go-projectile-set-gopath)))
