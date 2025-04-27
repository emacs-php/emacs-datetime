;;; datetime-format-test.el --- Test for datetime-format  -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Friends of Emacs-PHP development

;; Author: USAMI Kenta <tadsan@zonu.me>
;; Created: 18 May 2016
;; Version: 0.0.1
;; Package-Requires: ((emacs "26.3"))
;; Keywords: lisp, datetime, calendar
;; Homepage: https://github.com/zonuexe/emacs-datetime

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; Test codes for datetime-format.

;;; Code:
(require 'ert)
(require 'datetime-format)
(require 'timecop)

(eval-when-compile
  (require 'compat-28))

(defvar datetime-format-original-tz (getenv "TZ"))

(defmacro datetime-format--map (list function)
  "Apply FUNCTION to each element of LIST.
This macro helps with expression expansion at compile time."
  (declare (indent 1))
  (let ((sequence (eval list)))
    `(prog1 (quote ,sequence)
       ,@(mapcar function sequence))))

(ert-deftest datetime-format-test-env-tz ()
  (should (string= datetime-format-original-tz "-9:30")))

(ert-deftest datetime-format-test-format ()
  (with-environment-variables (("TZ" "-9:30")) ;; Australia/Darwin
    (datetime-format--map '(("2009-02-14T09:01:30+09:30" (datetime-format 'atom))
             ("2009-02-14T09:01:30+09:30" (datetime-format 'atom (current-time)))
             ("1970-01-01T09:30:00+09:30" (datetime-format 'atom 0))
             ("1970-01-01T00:00:00+00:00" (datetime-format 'atom 0 :timezone "UTC"))
             ("2015-01-12T02:31:11+09:30" (datetime-format 'atom "2015-01-12 02:01:11"))
             ("2015-01-12T02:01:11+02:00" (datetime-format 'atom "2015-01-12 02:01:11"
                                                           :timezone "Europe/Kiev"))
             ("2015-01-11T17:01:11Z" (datetime-format 'atom-utc "2015-01-12 02:01:11"))
             ("2009-02-13T18:31:30-05:00" (datetime-format 'atom nil
                                                           :timezone "America/New_York")))
      (lambda (pair)
        (cl-destructuring-bind (expected expr) pair
          `(timecop 1234567890 (should (string= ,expected (eval ,expr))))))))
  (setenv "TZ" datetime-format-original-tz))

(provide 'datetime-format-test)
;;; datetime-format-test.el ends here
