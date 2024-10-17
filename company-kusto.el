;;; company-kusto.el --- Company-mode completion backend for kusto-mode  -*- lexical-binding: t -*-

;; Copyright © 2019, by Hindol Adhya

;; Author: Hindol Adhya <hindol.adhya@gmail.com>
;; Version: 0.0.1
;; Keywords: languages kusto kql query company
;; Homepage: https://github.com/ration/kusto-mode.el
;; Package-Requires: ((emacs "24.3"))

;; This file is not part of GNU Emacs.

;;; Commentary:
;;
;; In Emacs >= 26, company-capf is used instead.

;;; Code:

(require 'company)
(require 'cl-lib)
(require 'kusto-mode)

(defconst company-kusto-completions
  (append kusto-operators
          kusto-builtin-functions
          kusto-data-types))

;;;###autoload
(defun company-kusto (command &optional arg &rest _ignored)
  "`company-mode' completion backend for `kusto-mode'.
Argument COMMAND specifies the action for the completion backend (possible
values: `interactive', `prefix', `candidates', `sorted').
Optional argument ARG if COMMAND is `candidates', holds the prefix (partial
symbol) for which the backend should provide possible completions."
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-kusto))
    (prefix (and (eq major-mode 'kusto-mode)
                 (company-grab-symbol)))
    (candidates
     (cond
      ((company-grab-symbol)
       (all-completions arg company-kusto-completions))))
    (sorted t)))

(provide 'company-kusto)
;;; company-kusto.el ends here
