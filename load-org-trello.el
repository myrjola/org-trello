;;; load-org-trello.el --- Load the namespaces of org-trello in a dev or test context
;;; Commentary:
;;; Code:

(add-to-list 'load-path (expand-file-name "."))

(defvar *ORGTRELLO-NAMESPACES* '("org-trello-action.el"
                                 "org-trello-api.el"
                                 "org-trello-backend.el"
                                 "org-trello-buffer.el"
                                 "org-trello-cbx.el"
                                 "org-trello-controller.el"
                                 "org-trello-data.el"
                                 "org-trello-hash.el"
                                 "org-trello-input.el"
                                 "org-trello-log.el"
                                 "org-trello-proxy.el"
                                 "org-trello-query.el"
                                 "org-trello-setup.el"
                                 "org-trello-utils.el"
                                 "org-trello.el")
  "Org-trello namespaces for development purposes.")

(defun org-trello/dev-load-namespaces! ()
  "Load the org-trello namespaces."
  (interactive)
  (mapc (lambda (it) (load-with-code-conversion it it)) *ORGTRELLO-NAMESPACES*))

(defun org-trello/dev-find-unused-definitions! ()
  "Find unused definitions."
  (interactive)
  (let ((filename "/tmp/org-trello-find-unused-definitions.el"))
    (with-temp-file filename
      (erase-buffer)
      (mapc (lambda (it)
              (insert-file-contents it)
              (goto-char (point-max))) *ORGTRELLO-NAMESPACES*)
      (emacs-lisp-mode)
      (write-file filename)
      (call-interactively 'emr-el-find-unused-definitions))))

(org-trello/dev-load-namespaces!)
(message "org-trello loaded!")

(require 'org-trello)

(define-key emacs-lisp-mode-map (kbd "C-c o n") 'org-trello/dev-load-namespaces!)
(define-key org-trello-mode-map (kbd "C-c o n") 'org-trello/dev-load-namespaces!)
(define-key emacs-lisp-mode-map (kbd "C-c o f") 'org-trello/dev-find-unused-definitions!)
(define-key org-trello-mode-map (kbd "C-c o f") 'org-trello/dev-find-unused-definitions!)

;; dev utils functions

(defun trace-functions (fns)
  "Trace functions FNS."
  (mapc 'trace-function fns))

(defun untrace-functions (fns)
  "Trace functions FNS."
  (mapc 'untrace-function fns))

(provide 'load-org-trello)
;;; load-org-trello.el ends here
