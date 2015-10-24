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
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(nlinum clojure-mode clj-refactor cider ac-cider company
			     idle-highlight-mode paredit projectile
			     yasnippet rainbow-delimiters yaml-mode
			     htmlize magit exec-path-from-shell elfeed sx ack
			     puppet-mode puppetfile-mode))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))

(require 'git)
(require 'git-blame)
(require 'ac-cider)

(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)

;(add-to-list 'load-path "~/.emacs.d") ; This may not be appeared if you have already added.
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(eval-after-load "auto-complete"
    '(add-to-list 'ac-modes 'cider-mode))

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(global-linum-mode t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defun my-clojure-mode ()
  (auto-complete-mode)
  (paredit-mode))

(projectile-global-mode)

(add-hook 'clojure-mode-hook 'my-clojure-mode)

(add-hook 'emacs-lisp-mode-hook 'my-clojure-mode)

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
