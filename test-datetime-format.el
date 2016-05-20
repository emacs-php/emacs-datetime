;;; test-datetime.el --- Test for datetime.el

;; Copyright (C) 2016 USAMI Kenta

;; Author: USAMI Kenta <tadsan@zonu.me>
;; Created: 18 May 2016
;; Version: 0.0.1
;; Package-Requires: ((test-simple "1.2"))
;; Keywords: datetime calendar
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

;;; Code:

(let ((default-directory (concat (file-name-as-directory default-directory) ".cask")))
  (add-to-list 'load-path default-directory)
  (normal-top-level-add-subdirs-to-load-path))

(require 'test-simple)
(test-simple-start)

(assert-t (load-file "./datetime.el")
   "Can't load datetime.el - are you in the right directory?")



(end-tests)

;;; test-datetime.el ends here
