(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (tango-dark)))
 '(inhibit-startup-screen t)
 '(org-agenda-files (quote ("c:/Users/lunk/Desktop/todo.org")))
 '(org-babel-load-languages (quote ((emacs-lisp . t) (plantuml . t))))
 '(org-confirm-babel-evaluate nil)
 '(org-plantuml-jar-path "c:/Users/lunk/Downloads/plantuml.jar")
 '(org-src-fontify-natively t)
 '(rainbow-delimiters-max-face-count 9))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "gray"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "dodger blue"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "deep sky blue"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "light sky blue"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "forest green"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "lawn green"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "orange"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "red")))))

(require 'package) ;; You might already have this line
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(nlinum clojure-mode clj-refactor cider ac-cider company
			     idle-highlight-mode paredit projectile
			     rainbow-delimiters yaml-mode
			     htmlize magit exec-path-from-shell 
			     puppet-mode puppetfile-mode git git-blame
			     neotree))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))

;; Globals
(require 'rainbow-delimiters)
(require 'uniquify)
(require 'ansi-color)
(require 'git)
(require 'git-blame)
;; Global Hooks
(global-linum-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(ac-config-default)
(projectile-global-mode)

;; Cider
(require 'cider)
(require 'ac-cider)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)

;; Puppet
(require 'puppet)
(add-hook 'puppet-mode-hook (lambda ()
			      (auto-complete-mode)))

;; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; Clojure
(add-hook 'clojure-mode-hook (lambda ()
			       (auto-complete-mode)
			       (paredit-mode)
			       (rainbow-delimiters-mode)))

;; Emacs Lisp
(add-hook 'emacs-lisp-mode-hook (lambda ()
				  (auto-complete-mode)
				  (paredit-mode)
				  (rainbow-delimiters-mode)))
;; Neotree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
