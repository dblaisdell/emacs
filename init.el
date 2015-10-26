(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-theme-load-path  (quote ("~/.emacs.d/elpa/solarized-theme-20150916.504")))
 '(custom-safe-themes
   (quote ("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "13a67c5968379752e55fcb3960125f809ae6230c7711ecbd3aed4f1cc66cf71a" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(inhibit-startup-screen t)
 '(org-babel-load-languages (quote ((emacs-lisp . t) (plantuml . t))))
 '(org-confirm-babel-evaluate nil)
 '(org-plantuml-jar-path (expand-file-name "~/.emacs.d/plantuml.jar"))
 '(org-src-fontify-natively t)
 '(rainbow-delimiters-max-face-count 9)
 '(idle-highlight-idle-time 0.5)
 '(projectile-switch-project-action 'neotree-projectile-action))

;;Setq variables
(setq
 backup-by-copying t			; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves"))			; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 5
 kept-old-versions 5
 version-control t)


(let ((file '"~/.emacs.d/proxy.el"))
  (if (file-exists-p file)
      (load-file file)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Package management
(require 'package)
;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(nlinum clojure-mode clj-refactor cider ac-cider company
			     idle-highlight-mode paredit projectile
			     rainbow-delimiters yaml-mode
			     htmlize magit exec-path-from-shell
			     puppet-mode puppetfile-mode git git-blame
			     neotree apache-mode align-cljlet mvn solarized-theme))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))

;; Requires
(require 'rainbow-delimiters)
(require 'uniquify)
(require 'ansi-color)
(require 'git)
(require 'git-blame)
(require 'cider)
(require 'ac-cider)
(require 'yaml-mode)
(require 'neotree)
(require 'idle-highlight-mode)

;; Global Hooks
(global-linum-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(ac-config-default)
(projectile-global-mode)

;; Cider
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)

;; Puppet
(add-hook 'puppet-mode-hook (lambda ()
			      (auto-complete-mode)
			      (idle-highlight-mode)
			      (rainbow-delimiters-mode)
			      (show-paren-mode)))

;; YAML
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; Clojure
(add-hook 'clojure-mode-hook (lambda ()
			       (auto-complete-mode)
			       (paredit-mode)
			       (rainbow-delimiters-mode)
			       (idle-highlight-mode)
			       (show-paren-mode)))
;; Emacs Lisp
(add-hook 'emacs-lisp-mode-hook (lambda ()
				  (auto-complete-mode)
				  (paredit-mode)
				  (rainbow-delimiters-mode)
				  (idle-highlight-mode)
				  (show-paren-mode)))

;; Neotree
(global-set-key [f8] 'neotree-toggle)

;;Solarized Theme
(load-theme 'solarized-dark t)


;; Window Toggle
(defadvice pop-to-buffer (before cancel-other-window first)
  (ad-set-arg 1 nil))
(ad-activate 'pop-to-buffer)

;; Toggle window dedication
(defun toggle-window-dedicated ()
  "Toggle whether the current active window is dedicated or not"
  (interactive)
  (message
   (if (let (window (get-buffer-window (current-buffer)))
         (set-window-dedicated-p window
                                 (not (window-dedicated-p window))))
       "Window '%s' is dedicated"
     "Window '%s' is normal")
   (current-buffer)))

;; Press [pause] key in each window you want to "freeze"
(global-set-key [f9] 'toggle-window-dedicated)
