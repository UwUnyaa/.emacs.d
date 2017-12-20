;;; web-mode-plus.el --- additional editing comamnds for web-mode

;; Copyright (C) 2017 DoMiNeLa10

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.


;;; Commentary:
;; This file defines a couple of additional commands for `web-mode' that never
;; got merged into the upstream version. Because of that, this mode
;; (obviously) depends on `web-mode'.
;; 
;; Refer to README.org for installation instructions.

(require 'web-mode)

;;; Variables:

(defvar web-mode-plus-contained-elements
  '(("ol" . "li")
    ("ul" . "li")
    ("tr" . "td"))
  "List of elements and elements they typically contain.
Used by `web-mode-plus-element-create-next'.")

(defvar web-mode-plus-link-attributes
  '(("a"      . "href")
    ("link"   . "href")
    ("script" . "src")
    ("iframe" . "src")
    ("img"    . "src"))
  "List of elements and attributes that hold links.")

(defvar web-mode-plus-html-snippets
  '(("html5" . "<!doctype html>\n<html>\n<head>\n<title></title>\n<meta charset=\"utf-8\" />\n</head>\n<body>\n|\n</body>\n</html>")
    ("table" . "<table>\n<tr>\n<td>|</td>\n</tr>\n</table>")
    ("ul" . "<ul>\n<li>|</li>\n</ul>")
    ("ol" . "<ol>\n<li>|</li>\n</ol>")
    ("dl" . "<dl>\n<dt>|</dt>\n<dd></dd>\n</dl>")
    ("script" . "<script type=\"text/javascript\">\n|\n</script>")
    ("style" . "<style type=\"text/css\">\n|\n</style>")
    ("viewport" . "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />|")))

;;; Code:

;;;###autoload
(defun web-mode-plus-bind-keys ()
  "Set default keybindings for `web-mode-plus'.
This function should be run after `web-mode' is loaded."
  (interactive)
  (define-key web-mode-map (kbd "M-RET") #'web-mode-plus-element-create-next)
  (define-key web-mode-map (kbd "C-c C-o") #'web-mode-plus-follow-link)
  (define-key web-mode-map (kbd "C-c <C-return>") #'web-mode-plus-break-lines))

;;;###autoload
(defun web-mode-plus-set-html-snippets ()
  "Replace HTML snippets with ones optimized for `web-mode-plus'."
  (setf (alist-get nil web-mode-engines-snippets)
        web-mode-plus-html-snippets))

(defun web-mode-plus-element-name ()
  "Return the name of the element at point."
  (let ((start-point (point))
        name-beginning name)
    (web-mode-element-beginning)
    (setq name-beginning (1+ (point)))
    (forward-word)
    (setq name
          (buffer-substring-no-properties name-beginning (point)))
    (goto-char start-point)
    name))

(defun web-mode-plus-attribute-get (attribute)
  "Return value of attribute ATTRIBUTE from the element at point or nil.
Nil is also returned if attribute is empty or doesn't exist."
  (let* ((start-point (point))
         (element-beg (web-mode-element-beginning))
         (element-end (web-mode-tag-end))
         (attribute-value "")
         quote-type)
    (goto-char element-beg)
    (if (search-forward (concat attribute "=") element-end t)
        (if (member (setq quote-type (char-after)) '(?' ?\"))
            ;; quoted attribute
            (progn
              (while (and (< (progn (forward-char)
                                    (point))
                             element-end)
                          (not (= (char-after) quote-type)))
                (when (= (char-after) ?\\)
                  (forward-char))
                (setq attribute-value
                      (concat
                       attribute-value
                       (char-to-string (char-after)))))
              (unless (< (1+ (point)) element-end)
                (error "Unbalanced quotes")))

          ;; unquoted attribute
          (let* ((attribute-beg (point))
                 (attribute-end
                  (search-forward-regexp " \\|/?>" element-end)))
            ;; trim space or element closing from the value
            (setq attribute-end
                  (- attribute-end
                     (if (string-equal
                          "/>"
                          (buffer-substring-no-properties
                           (- (point) 2) (point)))
                         2
                       1)))
            (setq attribute-value
                  (buffer-substring-no-properties
                   attribute-beg attribute-end)))))

    ;; just the attribute value
    (when (and (string-equal "" attribute-value)
               (progn
                 (goto-char element-beg)
                 (search-forward attribute element-end t)))
      (setq attribute-value attribute))

    ;; return point where it was
    (goto-char start-point)

    ;; return nil if attribute doesn't exist or is emtpy
    (unless (string-equal "" attribute-value)
      attribute-value)))

(defun web-mode-plus-follow-link (&optional in-browser)
  "Open a file to a file linked by the element at point.
Opens the file in a web browser (`eww' or `browse-url') when this function is
called with a numeric argument or IN-BROWSER is set."
  (interactive "P")
  (let ((link-attribute
         (cdr (assoc
               (web-mode-plus-element-name) web-mode-plus-link-attributes)))
        file-or-link)
    (unless link-attribute
      (error "Not in an element that links to anything"))
    (setq file-or-link (web-mode-plus-attribute-get link-attribute))
    (if (string-match "^https?://" file-or-link)
        (if in-browser
            (browse-url file-or-link)
          (eww file-or-link))
      (unless (file-exists-p file-or-link)
        (error "Linked file doesn't exist"))
      (if in-browser
          (browse-url (concat "file://" (expand-file-name file-or-link)))
        (find-file file-or-link)))))

(defun web-mode-plus-element-create-next ()
  "Create another element of the same type after the current one.
If the created element normally contains another element inside
of it, create it too. List of these elements can be found in
`web-mode-plus-contained-elements'. Detailed lists are also handled
properly."
  (interactive)
  (let* ((start-point (point))
         (element-name (progn (web-mode-element-parent)
                              (web-mode-element-tag-name)))
         (in-dl-p (string-equal element-name "dl"))
         (in-dt-or-dd-p (member element-name '("dt" "dd")))
         (contained-element
          (cdr (assoc element-name web-mode-plus-contained-elements)))
         reg-start reg-end)
    (if element-name
        (progn
          (when (string-equal element-name "dt")
            (web-mode-element-end)
            (web-mode-element-next))
          (setq reg-start (web-mode-element-end))
          (insert
           (cond (in-dl-p "\n<dl>\n<dt></dt>\n<dd></dd>\n</dl>")
                 (in-dt-or-dd-p "\n<dt></dt>\n<dd></dd>")
                 (contained-element
                  (format "\n<%s>\n<%s></%s>\n</%s>"
                          element-name contained-element
                          contained-element element-name))
                 (t (format "\n<%s></%s>"
                            element-name element-name))))
          (setq reg-end (point))
          (backward-char
           (cond (in-dl-p 21)
                 (in-dt-or-dd-p 15)
                 (contained-element (+(length contained-element)
                                      (length element-name) 7))
                 (t (+ (length element-name) 3))))
          (indent-region reg-start reg-end))
      (error "Not inside of a tag"))))

(defun web-mode-plus-break-lines ()
  "Insert a \"<br/>\" tag at point or on every line in region."
  (interactive)
  (if (use-region-p)
      (let ((point-line (line-number-at-pos))
            (point-column (current-column))
            (end-line (line-number-at-pos (region-end))))
	(goto-char (region-beginning))
	(while (<= (line-number-at-pos) end-line)
	  (end-of-line)
	  (insert "<br/>")
	  (forward-line))
	(forward-line (- point-line (line-number-at-pos)))
        (move-to-column point-column))
    (insert "<br/>")))

(provide 'web-mode-plus)
;;; web-mode-plus.el ends here
