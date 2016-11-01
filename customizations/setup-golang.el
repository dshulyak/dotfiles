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
(add-hook 'go-mode-hook 'flycheck-mode)

(eval-after-load 'go-mode
  '(progn
    (go-projectile-set-gopath)
    (go-projectile-install-tools)))


(defun go-install ()
    (interactive)
    (compile "go install -v ./"))

(defun go-test ()
  (interactive)
  (compile "go test -v ./"))

(global-set-key (kbd "C-c t") 'go-test)
(global-set-key (kbd "C-c i")  'go-install)
