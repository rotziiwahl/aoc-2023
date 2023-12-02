; parameters for the bag
(defparameter *bag-cubes* '(:red 12 :green 13 :blue 14))

(defun get-file (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line)))

; parse each line into a list of plists
(defun preprocess (line)
    (substitute #\Space #\,
      (concatenate 'string "(" line ")" )))

(defun make-sublists (char-stream &optional (new-stream #\( ) (num-parens 1))
  (let ((char (car char-stream)))
    (cond
      ((eq char #\:) (make-sublists (cdr char-stream) (cons new-stream #\() (+ num-parens 1) ))
      ((eq char #\;) (make-sublists (cons #\( (cdr char-stream)) (cons new-stream #\() (+ num-parens 1) ))
      ((and (null char) (> num-parens 0)) (make-sublists char-stream (cons new-stream #\)) (- num-parens 1)))
      ((and (null char) (= num-parens 0)) new-stream )
      (t (progn
            (print char)
            (make-sublists (cdr char-stream) (cons new-stream char)  num-parens)
          ))
          )))
          