;; Time-stamp: <2011-04-11 Mon 16:55:34 erocpil>

(load "~/.emacs.d/server.el")
;; ahei 的配置
(load "~/emacs-site-lisp/.emacs-ahei.el")
;; 叶文彬的配置
(load "~/.emacs.d/.emacs-ywb.el")
(load "~/site-lisp/wubi/update.el")
;; lipcore 的配置
(load "~/.emacs.d/.emacs-erocpil-custom.el")
(load "~/.emacs.d/muse-init.el")
(load "~/.emacs.d/org-mode.el")
(load "~/.emacs.d/weblogger.el")
(load "~/.emacs.d/auctex-conf.el")
(load "~/.emacs.d/rect-mark-settings-extra.el")
(load "~/.emacs.d/perl-conf.el")
(load "~/.emacs.d/operations.el")
;; (load "~/.emacs.d/twitter-conf.el")
(cond
 ((equal emacs-version "23.1.1")
  (setq custom-file "~/.emacs.d/.emacs-cust-23.1.el"))
 (t
  (setq custom-file "~/.emacs.d/.emacs-cust-23.2.el")))
(load custom-file)
;; xemacs
;; (setq load-home-init-file t) ; don't load init file from ~/.xemacs/init.el
