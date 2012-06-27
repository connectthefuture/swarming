;; Just bootstrap a few packages

(or (require 'package nil t)
    (load-file "~/.emacs.d/package23.el"))

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (null package-archive-contents)
  (package-refresh-contents))

(dolist (p '(starter-kit starter-kit-lisp starter-kit-bindings
                         starter-kit-eshell clojure-mode))
  (when (not (package-installed-p p))
    (package-install p)))
