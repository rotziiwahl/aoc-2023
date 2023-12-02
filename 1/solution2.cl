(defvar valid-digits '("one" "two" "three" "four" "five"
                       "six" "seven" "eight" "nine"))

(defvar reverse-valid-digits (mapcar #'reverse valid-digits))

(defun match-char-lists (shorter longer)
   (cond
      ((null shorter) t)
      ((eq (car shorter) (car longer)) (match-char-lists (cdr shorter) (cdr longer)))
      (t nil)))

(defun char-list-digit-p (char-list digit-list &optional (continuation 0))
  (let ((digit-string (car digit-list)))
    (if (match-char-lists (coerce digit-string 'list) char-list)
       (+ continuation 1)
       (if (cdr digit-list)
          (char-list-digit-p char-list (cdr digit-list) (+ continuation 1))
          nil))))

(defun get-file (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line)))

(defun find-num (char-list reference-vals)
  ; first see if the character is a literal digit
  (let ((val (digit-char-p (car char-list))))
    (if val
      val
      ; otherwise, try to match based on strings
      (let (( val2 (char-list-digit-p char-list reference-vals) ))
        (if val2
          val2
       
          ; finally, move on to the next character
          (find-num (cdr char-list) reference-vals))))))


(defun join-digits (digit-list)
  (parse-integer (format nil "~{~a~}" digit-list)))

(defun get-calibration-for-line (line)
  (let ((char-stream (coerce line 'list)))
    (let ((first-num (find-num char-stream valid-digits))
          (last-num (find-num (reverse char-stream) reverse-valid-digits)))
          (join-digits (list first-num last-num)))))

(defun get-all-calibrations (filename)
  (mapcar #'get-calibration-for-line (get-file filename)))

; the sum of all calibration values can be computed by
; (apply '+ (get-all-calibrations "filename"))