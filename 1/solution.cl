(defun get-file (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line)))

(defun find-num (char-list)
  (let ((val (digit-char-p (car char-list))))
    (if val
      (car char-list)
      (find-num (cdr char-list)))))


(defun join-digits (digit-list)
  (parse-integer (format nil "~{~C~}" digit-list)))

(defun get-calibration-for-line (line)
  (let ((char-stream (coerce line 'list)))
    (let ((first-num (find-num char-stream))
          (last-num (find-num (reverse char-stream))))
          (join-digits (list first-num last-num)))))

(defun get-all-calibrations (filename)
  (mapcar #'get-calibration-for-line (get-file filename)))

; the sum of all calibration values can be computed by
; (apply '+ (get-all-calibrations "filename"))