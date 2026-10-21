;;; cl-highlight-test.el --- Serapeum font-lock checks -*- lexical-binding: t; -*-

(require 'ert)
(load (expand-file-name "../cl-highlight.el"
                        (file-name-directory (or load-file-name buffer-file-name)))
      nil t)

(defun mag/test-face-at-token (token)
  "Return the face on the first occurrence of TOKEN in the current buffer."
  (save-excursion
    (goto-char (point-min))
    (search-forward token)
    (get-text-property (- (point) (length token)) 'face)))

(ert-deftest mag/serapeum-declaration-faces ()
  "Highlight bare and qualified declarations, nested types and markers."
  (dolist (operator '("->" "serapeum:->" "serapeum::->" "sera:->" "SERAPEUM:->"))
    (ert-info ((format "Operator: %s" operator))
      (with-temp-buffer
        (insert (format "(%s fetch ((or string pathname) &optional integer
  &key (:verbose boolean) &rest t)
  (values (vector character) &optional null))" operator))
        (lisp-mode)
        (font-lock-ensure)
        (dolist (entry '(("->" . luk/cl-serapeum-introducer-face)
                         ("fetch" . luk/cl-serapeum-declared-name-face)
                         ("or" . luk/cl-primitive-control-face)
                         ("string" . luk/cl-serapeum-type-atom-face)
                         ("pathname" . luk/cl-serapeum-type-atom-face)
                         ("&optional" . luk/cl-serapeum-declaration-syntax-face)
                         ("integer" . luk/cl-serapeum-type-atom-face)
                         ("&key" . luk/cl-serapeum-declaration-syntax-face)
                         ("boolean" . luk/cl-serapeum-type-atom-face)
                         ("&rest" . luk/cl-serapeum-declaration-syntax-face)
                         ("values" . luk/cl-serapeum-type-constructor-face)
                         ("vector" . luk/cl-serapeum-type-constructor-face)
                         ("character" . luk/cl-serapeum-type-atom-face)
                         ("null" . luk/cl-serapeum-type-atom-face)))
          (ert-info ((format "Token: %s" (car entry)))
            (should (eq (mag/test-face-at-token (car entry)) (cdr entry)))))))))

(ert-deftest mag/serapeum-declarations-in-comments-and-strings ()
  "Keep declaration-like text inside comments and strings in their own faces."
  (with-temp-buffer
    (insert "; (serapeum:-> commented (string) boolean)\n\"(sera:-> quoted (integer) null)\"\n")
    (lisp-mode)
    (font-lock-ensure)
    (should (eq (mag/test-face-at-token "commented") 'font-lock-comment-face))
    (should (eq (mag/test-face-at-token "quoted") 'font-lock-string-face))))

;;; cl-highlight-test.el ends here
